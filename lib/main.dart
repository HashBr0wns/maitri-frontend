import 'package:flutter/material.dart';
import 'package:maitri/screens/choose_lang.dart';
import 'package:maitri/screens/dashboard.dart';
import 'package:maitri/screens/splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:maitri/screens/describe_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Locale? systemLocale = WidgetsBinding.instance?.platformDispatcher?.locale;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
      locale: systemLocale,
      supportedLocales: const [
        Locale('en'),
        Locale('hi')
      ],
      // home: const ChatPage(),
      home: const ChooseLang(),
      // home: Dashboard(),
    );
  }
}
