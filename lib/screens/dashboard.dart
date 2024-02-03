import 'package:flutter/material.dart';
import 'package:maitri/utils/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 36, 36),
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.person,
                  size: 35,
                  color: secondaryColor,
                ),
              ),
            ),
            const Text(
              'Welcome',
              style: TextStyle(
                  fontFamily: 'OtomanopeeOne',
                  fontWeight: FontWeight.w400,
                  fontSize: 50,
                  color: secondaryColor),
            ),
            Container(
              width: 300,
              height: 180,
              decoration: const BoxDecoration(color: primaryColor, borderRadius: BorderRadius.all(Radius.circular(25)),),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 36,
                    color: Colors.white,
                  ),
                  SizedBox(height: 30,),
                  Text(
                    "hello",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
