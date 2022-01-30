import 'dart:convert';

import 'package:bug_bounty/widgets/custom_drawer.dart';
import 'package:bug_bounty/models/Organization.dart';
import 'package:bug_bounty/utils/ApiService.dart';
import 'package:bug_bounty/utils/PrefHelper.dart';
import 'package:bug_bounty/utils/Utility.dart';
import 'package:bug_bounty/widgets/basic_textfield.dart';
import 'package:bug_bounty/widgets/display_details.dart';
import 'package:flutter/material.dart';

import 'package:bug_bounty/models/User.dart';
import 'package:bug_bounty/utils/AppStyle.dart';

class OrganizationScreen extends StatefulWidget {
  @override
  _OrganizationScreenState createState() => _OrganizationScreenState();
}

class _OrganizationScreenState extends State<OrganizationScreen> {
  bool _isLoading = false;
  User? userInfo;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    PrefsHelper().getUserInfo().then((value) {
      userInfo = User.fromJson(json.decode(value));
      print(userInfo);
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  Widget makeCard(Organization org) {
    DateTime _date = DateTime.parse(org.createdOn as String);

    return Column(
      children: [
        Card(
            elevation: 7,
            child: ListTile(
                title: Text(org.organizationName as String,
                    style: TextStyle(
                        color: AppStyle.brown, fontWeight: FontWeight.bold)),
                subtitle: Text(Utility().getFormattedDate(_date)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: Icon(Icons.info_outline,
                            size: 25.0, color: Colors.grey),
                        onPressed: () {
                          _bottomSheet(context, org);
                        }),
                    IconButton(
                        icon:
                            Icon(Icons.delete, size: 25.0, color: Colors.grey),
                        iconSize: 30.0,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext c) {
                                return AlertDialog(
                                  title: Text("Sure?",
                                      style: TextStyle(
                                        color: Colors.red,
                                      )),
                                  content:
                                      Text("Are you sure want to delete.?"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("No",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          )),
                                      onPressed: () {
                                        Navigator.of(c).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Yes",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          )),
                                      onPressed: () {
                                        ApiService()
                                            .deleteOrganization(
                                                org.organizationId as int)
                                            .then((value) {
                                          if (value) {
                                            Navigator.of(c).pop();
                                            setState(() {});
                                          } else {
                                            Utility().showToast(
                                                'Unable to delete, please try again.');
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                );
                              });
                        }),
                  ],
                ),
                onTap: () {
                  // Navigator.push(context,MaterialPageRoute(builder : (context)=>UpdateCompany(obj))).then((value){
                  // 	if(value != null){
                  // 		showMessage('Record Successfully Updated.!!');
                  // 		setState((){
                  // 			getNewData = true;
                  // 		});
                  // 	}
                  // });
                })),
        Divider(),
      ],
    );
  }

  void _bottomSheet(context, Organization org) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
        builder: (c) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Center(
                    child: Text('Organization Details',
                        style: TextStyle(
                          fontSize: AppStyle.XLargeTextSize,
                          color: AppStyle.brown,
                        ))),
                SizedBox(height: 10.0),
                ListTile(
                  title: DisplayDetails(
                    title: 'Organization name:',
                    info: org.organizationName as String,
                  ),
                  onTap: () => {},
                ),
                ListTile(
                  title: DisplayDetails(
                    title: 'Description:',
                    info: org.organizationDescription as String,
                  ),
                  onTap: () => {},
                ),
                ListTile(
                  title: DisplayDetails(
                    title: 'Website link:',
                    info: org.organizationWebsite as String,
                  ),
                  onTap: () => {},
                ),
                ListTile(
                  title: DisplayDetails(
                    title: 'Created on:',
                    info: Utility().getFormattedDate(
                        DateTime.parse(org.createdOn as String)),
                  ),
                  onTap: () => {},
                ),
                SizedBox(height: 10.0),
              ]),
            ),
          );
        });
  }

  Widget getDialog(String title, double height, context) {
    TextEditingController _orgName = TextEditingController();
    TextEditingController _orgDesc = TextEditingController();
    TextEditingController _orgWebsite = TextEditingController();

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height * 0.3),
      child: AlertDialog(
        actions: [
          Center(
              child: TextButton(
            child: Text('Submit', style: TextStyle(color: AppStyle.brown)),
            onPressed: () {
              Organization org = Organization(
                  organizationName: _orgName.text,
                  organizationDescription: _orgDesc.text,
                  organizationWebsite: _orgWebsite.text);
              ApiService()
                  .addOrganization(org, userInfo!.userId as int)
                  .then((value) {
                if (value) {
                  Navigator.pop(context);
                  setState(() {});
                } else {
                  Utility().showToast(
                      'Unable to add organization, please try again.');
                }
              });
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
                  controller: _orgName,
                  hintText: 'Enter organization name',
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty) return 'Organization name is required';
                  },
                  obscureText: false),
              AuthenticationTextField(
                  controller: _orgDesc,
                  hintText: 'Enter organization description',
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty)
                      return 'Organization description is required';
                  },
                  obscureText: false),
              AuthenticationTextField(
                  controller: _orgWebsite,
                  hintText: 'Enter your website',
                  keyboardType: TextInputType.url,
                  validator: null,
                  obscureText: false)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return _isLoading
        ? Scaffold(body: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: AppStyle.cream,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return getDialog('Add Organization', height, context);
                    });
              },
              child: Icon(Icons.add),
              backgroundColor: AppStyle.brown,
            ),
            drawer: SafeArea(
                child: CustomDrawer(
              index: 2,
              userContactNumber:
                  userInfo == null ? '' : userInfo!.userContactNumber as String,
              userName: userInfo == null ? '' : userInfo!.userName as String,
            )),
            appBar: AppBar(
                iconTheme: IconThemeData(color: AppStyle.brown),
                backgroundColor: AppStyle.cream,
                centerTitle: true,
                title: Image.asset(
                  'assets/logo.jpeg',
                  height: height * 0.09,
                )),
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                margin: EdgeInsets.symmetric(vertical: height * 0.03),
                child: FutureBuilder(
                    future: userInfo == null
                        ? null
                        : ApiService().getOrgByUserId(userInfo!.userId as int),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        List<Organization> orgList =
                            snap.data as List<Organization>;
                        return ListView.builder(
                            itemCount: orgList.length,
                            itemBuilder: (context, index) {
                              return makeCard(orgList[index]);
                            });
                      } else {
                        return Center(child: Text('No organizations'));
                      }
                    })),
          );
  }
}
