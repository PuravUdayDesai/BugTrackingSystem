import 'package:bug_bounty/screens/login_screen.dart';
import 'package:bug_bounty/screens/dashboard.dart';
import 'package:bug_bounty/utils/AppStyle.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import '../l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      loadingText: Text(AppLocalizations.of(context)!.loading),
      navigator: LoginScreen(),
      durationInSeconds: 2,
    );
  }
}
