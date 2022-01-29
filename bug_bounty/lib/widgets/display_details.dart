import 'package:bug_bounty/utils/AppStyle.dart';
import 'package:flutter/material.dart';

class DisplayDetails extends StatelessWidget {
  final String title;
  final String info;

  DisplayDetails({required this.title, required this.info});

  // const AuthenticationTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: title + ' ',
            style: TextStyle(
                fontFamily: 'Product',
                color: AppStyle.black,
                fontSize: AppStyle.MediumTextSize,
                fontWeight: FontWeight.bold),
            children: [
          TextSpan(
            text: info,
            style: TextStyle(
                fontFamily: 'Product',
                color: AppStyle.black,
                fontSize: AppStyle.SmallTextSize,
                fontWeight: FontWeight.normal),
          )
        ]));
  }
}
