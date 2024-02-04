import 'package:flutter/material.dart';
import 'package:maitri/screens/describe_page.dart';
import 'package:maitri/utils/colors.dart';

class ChooseLang extends StatefulWidget {
  const ChooseLang({super.key});

  @override
  State<ChooseLang> createState() => _ChooseLangState();
}

class _ChooseLangState extends State<ChooseLang> {
  String? selectedLang;

  Widget switchScreen(String lang) {
    // print(lang);
    return ChatPage(
      lang: lang,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: secondaryColor,
            title: const Text('Choose your preferred language')),
        body: Container(
          margin: const EdgeInsets.all(25),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                const Text(
                  'Choose a language that you are comfortable in',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          switchScreen('en');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            fixedSize: const Size(100, 50),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        child: const Text('English')),
                    const SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          switchScreen('hi');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            fixedSize: const Size(100, 50),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        child: const Text('Hindi')),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
