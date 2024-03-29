import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:maitri/utils/colors.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatPage extends StatefulWidget {
  final Key? key;

  const ChatPage({this.key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late CameraController _cameraController;
  late TextEditingController _textController;
  final ScrollController _sc = ScrollController();
  final List<ChatMessage> _messages = [];
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _initializeCamera();
    _initSpeech();
    _addMessage(ChatMessage(
        text:
            "Describe what you want to know about your surroundings. Please point the camera towards the object or place you want to know more about.",
        sender: "model"));
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    print('listening');
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    print('stop listening');
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  bool _isCapturing = false;

  void _onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      _lastWords = result.recognizedWords;
    });

    // Check if the camera is initialized and not currently capturing
    if (_cameraController.value.isInitialized &&
        !_isCapturing &&
        result.finalResult) {
      // Set the capturing flag to true
      _isCapturing = true;
      try {
        XFile imageFile = await _cameraController.takePicture();
        _addMessage(ChatMessage(text: _lastWords, sender: "user"));
        _sendMessage(imageFile, _lastWords);
      } catch (e) {
        print("Error taking picture: $e");
      } finally {
        // Set the capturing flag back to false when the capture is completed
        _isCapturing = false;
        _speechEnabled = false;
        await Future.delayed(Duration(seconds: 1)); // Delay for stability
        _initSpeech();
      }
    }
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.max);
    // _cameraController.setFlashMode(FlashMode.off);
    await _cameraController.initialize();
    setState(() {});
  }

  void _sendMessage(XFile image, String text) async {
    // Placeholder API details
    print('Call is successful');
    String apiUrl =
        'https://ea2a0f9b-2256-4e50-ba34-08fe54b6d6df-00-391y2lq3o3aga.sisko.replit.dev/surrounding?question=$text';
    print(apiUrl);

    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path),
    });

    try {
      Response response = await Dio().post(
        apiUrl,
        data: formData,
      );

      // Process the API response and update the UI
      _handleApiResponse(response.data['message']);
      // _handleApiResponse(response);
    } catch (error) {
      // Handle errors
      print('API Error: $error');
    }
  }

  void _captureAndSendMessage() async {
    ChatMessage currentMessage =
        ChatMessage(text: _textController.text, sender: "user");
    _addMessage(currentMessage);
    _textController.clear();
    if (_cameraController.value.isInitialized) {
      XFile imageFile = await _cameraController.takePicture();
      _sendMessage(imageFile, currentMessage.text!);
    }
  }

  void _handleApiResponse(String messageText) {
    // Extract relevant information from the response
    // String messageText = response.data['message'];
    // String messageText = "Example Response";

    // Add the received message to the chat
    _addMessage(ChatMessage(text: messageText, sender: "model"));
  }

  Future _speak(ChatMessage message) async {
    var result = await flutterTts.speak(message.text!);
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  void _addMessage(ChatMessage message) {
    setState(() {
      _messages.insert(0, message);
    });
    _speak(message);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0
          // title: const Text('Chat Page'),
          ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Describe your surroundings',
              style: TextStyle(
                  fontFamily: 'OtomanopeeOne',
                  color: secondaryColor,
                  fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.4,
          //   width: MediaQuery.of(context).size.width * 0.8,
          //   child: _cameraController != null &&
          //           _cameraController.value.isInitialized
          //       ? Draggable(
          //           feedback: Container(),
          //           child: CameraPreview(_cameraController),
          //         )
          //       : Container(),
          // ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                // WidgetsBinding.instance.addPostFrameCallback((_) => _sc.jumpTo(_sc.position.maxScrollExtent));
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      // prefixIcon: iconName,
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor, width: 4),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      fillColor: backgroundColor,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      filled: true,
                      contentPadding: EdgeInsets.all(18),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: secondaryColor,
                  child: IconButton(
                    iconSize: 25,
                    icon: Icon(
                      _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                      color: backgroundColor,
                    ),
                    onPressed: _speechToText.isNotListening
                        ? _startListening
                        : _stopListening,
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: secondaryColor,
                  child: IconButton(
                    iconSize: 25,
                    icon: const Icon(
                      Icons.send,
                      color: backgroundColor,
                    ),
                    onPressed: _captureAndSendMessage,
                    // onPressed: () => print('this is a press'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Align(
      alignment: message.sender == "user"
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        decoration: BoxDecoration(
          color: message.sender == "user" ? primaryColor : Colors.white,
          border: Border.all(color: primaryColor, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(message.text!,
            textAlign:
                message.sender == "user" ? TextAlign.right : TextAlign.left,
            style: TextStyle(
                fontSize: 18,
                color: message.sender == "user" ? Colors.white : primaryColor,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}

class ChatMessage {
  final String? text;
  final String? sender;

  ChatMessage({required this.text, required this.sender});
}
