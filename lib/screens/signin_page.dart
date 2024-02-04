import 'package:flutter/material.dart';
import 'package:maitri/screens/dashboard.dart';
import 'package:maitri/utils/colors.dart';
import 'package:maitri/widgets/text_field.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign In',
              style: TextStyle(
                  fontFamily: 'OtomanopeeOne',
                  color: secondaryColor,
                  fontSize: 50),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            TextFieldInput(
                textEditingController: _emailController,
                iconName: const Icon(
                  Icons.email,
                  color: primaryColor,
                ),
                hintText: 'Email ID',
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
                textEditingController: _passwordController,
                iconName: const Icon(
                  Icons.lock,
                  color: primaryColor,
                ),
                hintText: 'Password',
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Dashboard()));
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(350, 60),
                  backgroundColor: primaryColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)))),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot password ?',
                      style: TextStyle(color: darkerShade, fontSize: 18),
                      textAlign: TextAlign.right,
                    ))),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: primaryColor,
                  minRadius: 30,
                ),
                CircleAvatar(
                  backgroundColor: primaryColor,
                  minRadius: 30,
                ),
                CircleAvatar(
                  backgroundColor: primaryColor,
                  minRadius: 30,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
