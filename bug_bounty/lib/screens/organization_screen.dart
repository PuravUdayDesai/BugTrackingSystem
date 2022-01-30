import 'package:bug_bounty/models/Organization.dart';
import 'package:bug_bounty/screens/dashboard.dart';
import 'package:bug_bounty/screens/register_screen.dart';
import 'package:bug_bounty/screens/roles_screen.dart';
import 'package:bug_bounty/utils/ApiService.dart';
import 'package:bug_bounty/utils/AppStyle.dart';
import 'package:bug_bounty/utils/Utility.dart';
import 'package:bug_bounty/widgets/TicketInfo.dart';
import 'package:bug_bounty/widgets/basic_textfield.dart';
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
                      Text('List of tickets',
                          style: TextStyle(
                              fontSize: AppStyle.MediumTextSize,
                              color: AppStyle.brown,
                              fontWeight: FontWeight.bold)),
                      Divider(thickness: 1),
                      Expanded(
                          child: ListView.separated(
                        itemCount: 10,
                        itemBuilder: (context, snap) {
                          return TicketInfo(
                              title: 'UI design error', info: 'High priority');
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
