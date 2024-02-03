import 'package:flutter/material.dart';
import 'package:maitri/utils/colors.dart';
import 'signin_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => SigninPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 300,
              ),
              const Text('Maitrī',
                  style: TextStyle(
                      fontFamily: 'OtomanopeeOne',
                      fontWeight: FontWeight.w400,
                      fontSize: 60,
                      shadows: [
                        Shadow(
                            color: secondaryColor,
                            offset: Offset(-10, 8),
                            blurRadius: 0.5)
                      ],
                      color: Colors.white)),
              const SizedBox(
                height: 110,
              ),
              Image.asset('assets/images/main.png',width: 300,)
            ],
          ),
        ),
      ),
    );
  }
}
