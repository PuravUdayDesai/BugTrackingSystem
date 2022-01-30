import 'dart:convert';

import 'package:bug_bounty/models/Organization.dart';
import 'package:bug_bounty/models/Project.dart';
import 'package:bug_bounty/models/User.dart';
import 'package:bug_bounty/utils/PrefHelper.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String URL = 'http://192.168.1.31:8080';

  Future<bool> loginUser(String contact, String password) async {
    Map data = {"userContactNumber": contact, "userPassword": password};
    var response = await http.post(Uri.parse('$URL/user/login'),
        body: json.encode(data), headers: {'Content-type': 'application/json'});
    // print('LOGIN RESPONSE : ${json.decode(response.body)}');r
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
    var response = await http.post(Uri.parse('$URL/user'),
        body: json.encode(user), headers: {'Content-type': 'application/json'});
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Organization>> getOrgByUserId(int id) async {
    var respose = await http.get(Uri.parse('$URL/organization/$id'));

    List res = jsonDecode(respose.body) as List;
    List<Organization> orgList = [];

    for (int i = 0; i < res.length; i++) {
      print(res[i]);
      orgList.add(Organization.fromJson(res[i]));
    }

    return orgList;
  }

  Future<bool> addOrganization(Organization org, int userId) async {
    Map data = {
      "organizationName": org.organizationName,
      "organizationDescription": org.organizationDescription,
      "organizationWebsite": org.organizationWebsite,
      "markForPrivate": org.markForPrivate,
      "userId": userId
    };
    var response = await http.post(Uri.parse('$URL/organization'),
        body: json.encode(data), headers: {'Content-type': 'application/json'});
    print(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addProject(Project project) async {
    var response = await http.post(Uri.parse('$URL/application'),
        body: json.encode(project),
        headers: {'Content-type': 'application/json'});
    print(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addRole(Map info) async {
    var response = await http.post(Uri.parse('$URL/role'),
        body: json.encode(info),
        headers: {'Content-type': 'application/json'});
    print(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Project>> getProjByUserId(int id) async {
    var respose = await http.get(Uri.parse('$URL/application/$id'));
    print(respose.body);
    List res = jsonDecode(respose.body) as List;
    List<Project> orgList = [];

    for (int i = 0; i < res.length; i++) {
      orgList.add(Project.fromJson(res[i]));
    }

    return orgList;
  }

  Future<bool> deleteOrganization(int id) async {
    var response = await http.delete(Uri.parse('$URL/organization/$id'));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteProject(int id) async {
    var response = await http.delete(Uri.parse('$URL/application/$id'));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
