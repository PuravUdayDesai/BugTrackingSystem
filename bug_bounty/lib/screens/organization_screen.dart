import 'package:bug_bounty/models/Organization.dart';
import 'package:bug_bounty/models/User.dart';
import 'package:bug_bounty/screens/dashboard.dart';
import 'package:bug_bounty/screens/register_screen.dart';
import 'package:bug_bounty/screens/roles_screen.dart';
import 'package:bug_bounty/utils/ApiService.dart';
import 'package:bug_bounty/utils/AppStyle.dart';
import 'package:bug_bounty/utils/Constants.dart';
import 'package:bug_bounty/utils/Utility.dart';
import 'package:bug_bounty/widgets/TicketInfo.dart';
import 'package:bug_bounty/widgets/basic_textfield.dart';
import 'package:bug_bounty/widgets/display_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SpecificOrganizationScreen extends StatefulWidget {
  final Organization organizationInfo;
  SpecificOrganizationScreen({required this.organizationInfo});

  @override
  _SpecificOrganizationScreenState createState() =>
      _SpecificOrganizationScreenState();
}

class _SpecificOrganizationScreenState
    extends State<SpecificOrganizationScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  List<User> _users = Constants().getUserInfo();

  Widget makeCard(User org) {
    // DateTime _date = DateTime.parse(org. as String);

    return Card(
        elevation: 7,
        child: ListTile(
            title: Text(org.userName as String,
                style: TextStyle(
                    color: AppStyle.brown, fontWeight: FontWeight.bold)),
            subtitle: Text(org.role!),
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
                    icon: Icon(Icons.delete, size: 25.0, color: Colors.grey),
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
                              content: Text("Are you sure want to delete?"),
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
                                    Navigator.of(c).pop();
                                    _users.remove(org);
                                    setState(() {});
                                  },
                                ),
                              ],
                            );
                          });
                    }),
              ],
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute<void>(
              //     builder: (BuildContext context) =>
              //         SpecificOrganizationScreen(organizationInfo: org),
              //   ),
              // );
            }));
  }

  void _bottomSheet(context, User org) {
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
                    child: Text('User Details',
                        style: TextStyle(
                          fontSize: AppStyle.XLargeTextSize,
                          color: AppStyle.brown,
                        ))),
                SizedBox(height: 10.0),
                ListTile(
                  title: DisplayDetails(
                    title: 'User name:',
                    info: org.userName as String,
                  ),
                  onTap: () => {},
                ),
                ListTile(
                  title: DisplayDetails(
                    title: 'Email ID:',
                    info: org.userEmailId as String,
                  ),
                  onTap: () => {},
                ),
                ListTile(
                  title: DisplayDetails(
                    title: 'Contact number:',
                    info: org.userContactNumber as String,
                  ),
                  onTap: () => {},
                ),
                ListTile(
                  title: DisplayDetails(
                    title: 'Country name:',
                    info: org.userCountry!,
                  ),
                  onTap: () => {},
                ),
                ListTile(
                  title: DisplayDetails(
                    title: 'Role:',
                    info: org.role!,
                  ),
                  onTap: () => {},
                ),
                SizedBox(height: 10.0),
              ]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return isLoading
        ? Scaffold(
            backgroundColor: AppStyle.cream,
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppStyle.brown,
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: AppStyle.cream,
            appBar: AppBar(
                iconTheme: IconThemeData(color: AppStyle.brown),
                backgroundColor: AppStyle.cream,
                centerTitle: true,
                title: Image.asset(
                  'assets/logo.jpeg',
                  height: height * 0.09,
                )),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: height,
                  margin: EdgeInsets.symmetric(vertical: height * 0.03),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Container(
                              height: height * 0.25,
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppStyle.cream,
                                        AppStyle.darkCream
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                  boxShadow: [
                                    BoxShadow(color: Colors.grey, blurRadius: 2)
                                  ],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                  child: Text(
                                'Create roles',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: AppStyle.SmallTextSize,
                                ),
                              )),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        RolesScreen(
                                      organizationId: widget
                                          .organizationInfo.organizationId,
                                    ),
                                  ));
                            },
                          ),
                          Container(
                            height: height * 0.25,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      AppStyle.cream,
                                      AppStyle.darkCream
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey, blurRadius: 2)
                                ],
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: Text(
                              'Invite Employees',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: AppStyle.SmallTextSize,
                              ),
                            )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Divider(thickness: 1),
                      Text('List of employees',
                          style: TextStyle(
                              fontSize: AppStyle.MediumTextSize,
                              color: AppStyle.brown,
                              fontWeight: FontWeight.bold)),
                      Divider(thickness: 1),
                      Expanded(
                          child: ListView.separated(
                        itemCount: _users.length,
                        itemBuilder: (context, index) {
                          return makeCard(_users[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                      ))
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
