import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utility {
  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  String getFormattedDate(DateTime _date) {
    String finalDate = _date.day.toString();
    if (_date.month == 1)
      finalDate += ' Jan, ';
    else if (_date.month == 2)
      finalDate += ' Feb, ';
    else if (_date.month == 2)
      finalDate += ' Mar, ';
    else if (_date.month == 2)
      finalDate += ' Apr, ';
    else if (_date.month == 2)
      finalDate += ' May, ';
    else if (_date.month == 2)
      finalDate += ' Jun, ';
    else if (_date.month == 2)
      finalDate += ' Jul, ';
    else if (_date.month == 2)
      finalDate += ' Aug, ';
    else if (_date.month == 2)
      finalDate += ' Sep, ';
    else if (_date.month == 2)
      finalDate += ' Oct, ';
    else if (_date.month == 2)
      finalDate += ' Nov, ';
    else
      finalDate += ' Dec, ';

    finalDate += _date.year.toString();
    return finalDate;
  }
}
