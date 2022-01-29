import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  void saveUserInfo(String userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userInfo', userInfo);
  }

  Future<String> getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('userInfo');
    return token == null ? '' : token;
  }
}
