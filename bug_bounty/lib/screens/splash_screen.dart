import 'package:bug_bounty/screens/login_screen.dart';
import 'package:bug_bounty/utils/AppStyle.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        'assets/logo.jpeg',
      ),
      backgroundColor: AppStyle.cream,
      showLoader: true,
      loadingText: Text("Loading..."),
      navigator: LoginScreen(),
      durationInSeconds: 2,
    );
  }
}
