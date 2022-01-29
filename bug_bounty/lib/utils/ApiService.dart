import 'dart:convert';

import 'package:bug_bounty/models/User.dart';
import 'package:bug_bounty/utils/PrefHelper.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String URL = 'http://143.244.133.9:5001';

  Future<bool> loginUser(String contact, String password) async {
    Map data = {"contact": contact, "password": password};
    var response =
        await http.post(Uri.parse('$URL/user/login'), body: json.encode(data));
    print('LOGIN RESPONSE : ${json.decode(response.body)}');
    if (response.statusCode == 200) {
      User user = User.fromJson(json.decode(response.body));
      user.userContactNumber = contact;
      PrefsHelper().saveUserInfo(jsonEncode(user));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registerUser(User user) async {
    return true;
    // var response = await http.post(Uri.parse('$URL/user/register'),
        // body: json.encode(data));
    // print('REGISTER RESPONSE : ${json.decode(response.body)}');
    // if (response.statusCode == 200) {
    //   User user = User.fromJson(json.decode(response.body));
    //   // user.userContactNumber = contact;
    //   PrefsHelper().saveUserInfo(jsonEncode(user));
    //   return true;
    // } else {
    //   return false;
    // }
  }
}
