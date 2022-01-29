import 'package:bug_bounty/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bug Bounty',
        theme: ThemeData(fontFamily: 'Product'),
        debugShowCheckedModeBanner: false,
        home: SplashPage());
  }
}
