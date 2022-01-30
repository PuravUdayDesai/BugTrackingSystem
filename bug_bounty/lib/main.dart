import 'package:bug_bounty/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        home: SplashPage(),
        supportedLocales: L10n.all,
        localizationsDelegates: {
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        }
      );
  }
}
