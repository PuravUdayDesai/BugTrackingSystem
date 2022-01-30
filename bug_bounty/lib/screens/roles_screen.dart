import 'dart:convert';

import 'package:bug_bounty/widgets/custom_drawer.dart';
import 'package:bug_bounty/models/Organization.dart';
import 'package:bug_bounty/models/Project.dart';
import 'package:bug_bounty/models/ProjectAccess.dart';
import 'package:bug_bounty/utils/ApiService.dart';
import 'package:bug_bounty/utils/PrefHelper.dart';
import 'package:bug_bounty/utils/Utility.dart';
import 'package:bug_bounty/widgets/basic_textfield.dart';
import 'package:flutter/material.dart';

import 'package:bug_bounty/models/User.dart';
import 'package:bug_bounty/utils/AppStyle.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import '../l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class RolesScreen extends StatefulWidget {
  final int? organizationId;
  RolesScreen({this.organizationId});

  @override
  _RolesScreenState createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  bool _isLoading = false;
  User? userInfo;

  TextEditingController roleName = new TextEditingController();
  TextEditingController roleDesc = new TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  List<Project> projList = [];
  List<ProjectAccess> accessList = [];

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    PrefsHelper().getUserInfo().then((value) async {
      userInfo = User.fromJson(json.decode(value));
      projList = await ApiService().getProjByUserId(userInfo!.userId as int);
      for (int i = 0; i < projList.length; i++) {
        accessList.add(ProjectAccess(applicationId: projList[i].applicationId));
      }
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  Widget getDialog(String title, double height, context) {
    TextEditingController _projName = TextEditingController();
    TextEditingController _projDesc = TextEditingController();
    String? _dropdownvalue;
    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height * 0.3),
      child: AlertDialog(
        actions: [
          Center(
              child: TextButton(
            child: Text('Submit', style: TextStyle(color: AppStyle.brown)),
            onPressed: () {
              // ApiService()
              //     .addOrganization(org, userInfo!.userId as int)
              //     .then((value) {
              //   if (value) {
              //     Navigator.pop(context);
              //     setState(() {});
              //   } else {
              //     Utility().showToast(
              //         'Unable to add organization, please try again.');
              //   }
              // });
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
                side: MaterialStateProperty.all(
                    BorderSide(color: AppStyle.brown))),
          ))
        ],
        title: Row(
          children: [
            Text(title),
            Spacer(
              flex: 2,
            ),
            Expanded(
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.cancel,
                      color: AppStyle.brown,
                    )))
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              AuthenticationTextField(
                  controller: _projName,
                  hintText: 'Enter project name',
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty) return 'Project name is required';
                  },
                  obscureText: false),
              AuthenticationTextField(
                  controller: _projDesc,
                  hintText: 'Enter project description',
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty) return 'Project description is required';
                  },
                  obscureText: false),
              DropdownButton(
                  value: _dropdownvalue,
                  hint: Text('Select organization'),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _dropdownvalue = newValue!;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }

  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  @override
  Widget build(BuildContext context) {
    void changeColor(Color color) {
      setState(() => pickerColor = color);
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppStyle.cream,
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppStyle.brown),
          backgroundColor: AppStyle.cream,
          centerTitle: true,
          title: Text('Roles', style: TextStyle(color: AppStyle.brown))),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: height * 0.03),
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              children: [
                AuthenticationTextField(
                  controller: roleName,
                  hintText: 'Enter your role name',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Role name cannot be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                AuthenticationTextField(
                  controller: roleDesc,
                  hintText: 'Enter your role description',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Role description cannot be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: AppStyle.brown))),
                  child: ListTile(
                    leading: Container(
                      color: pickerColor,
                      height: height * 0.04,
                      width: width * 0.3,
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Pick a color!'),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: pickerColor,
                                      onColorChanged: changeColor,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: const Text('Got it'),
                                      onPressed: () {
                                        setState(
                                            () => currentColor = pickerColor);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: Icon(Icons.keyboard_arrow_right_outlined)),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: projList.length,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          title: Text(projList[index].applicationName!,
                              style: TextStyle(
                                  color: AppStyle.black,
                                  fontSize: AppStyle.SmallTextSize)),
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    value: accessList[index].create,
                                    onChanged: (val) {
                                      setState(() {
                                        accessList[index].create = val!;
                                      });
                                    }),
                                Text('Create'),
                                SizedBox(width: width * 0.2),
                                Checkbox(
                                    value: accessList[index].read,
                                    onChanged: (val) {
                                      setState(() {
                                        accessList[index].read = val!;
                                      });
                                    }),
                                Text('Read'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: accessList[index].update,
                                    onChanged: (val) {
                                      setState(() {
                                        accessList[index].update = val!;
                                      });
                                    }),
                                Text('Update'),
                                SizedBox(width: width * 0.2),
                                Checkbox(
                                    value: accessList[index].delete,
                                    onChanged: (val) {
                                      setState(() {
                                        accessList[index].delete = val!;
                                      });
                                    }),
                                Text('Delete'),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
                TextButton(
                    onPressed: () {
                      Map info = {
                        "organizationId": widget.organizationId,
                        "roleName": roleName.text,
                        "roleColor": pickerColor.value.toString(),
                        "roleDescription": roleDesc.text,
                        "applications": accessList
                      };
                      ApiService().addRole(info).then((value) {
                        if (value)
                          Utility().showToast('User role created');
                        else
                          Utility().showToast(
                              'Unable to create role, please try again');
                      });
                    },
                    child: Text('Create role',
                        style: TextStyle(
                            color: AppStyle.brown,
                            fontSize: AppStyle.SmallTextSize)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
