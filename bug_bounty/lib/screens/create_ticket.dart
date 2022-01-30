import 'dart:convert';

import 'package:bug_bounty/Widgets/custom_drawer.dart';
import 'package:bug_bounty/models/Organization.dart';
import 'package:bug_bounty/models/Project.dart';
import 'package:bug_bounty/models/Ticket.dart';
import 'package:bug_bounty/utils/ApiService.dart';
import 'package:bug_bounty/utils/Constants.dart';
import 'package:bug_bounty/utils/PrefHelper.dart';
import 'package:bug_bounty/utils/Utility.dart';
import 'package:bug_bounty/widgets/basic_textfield.dart';
import 'package:bug_bounty/widgets/display_details.dart';
import 'package:flutter/material.dart';

import 'package:bug_bounty/models/User.dart';
import 'package:bug_bounty/utils/AppStyle.dart';

class CreateTicket extends StatefulWidget {
  Project projectInfo;
  CreateTicket({required this.projectInfo});

  @override
  _CreateTicketState createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  bool _isLoading = false;
  User? userInfo;
  List<Ticket> _tickets = Constants().getTickets();

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    PrefsHelper().getUserInfo().then((value) async {
      userInfo = User.fromJson(json.decode(value));
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  Widget makeCard(Ticket org) {
    return Column(
      children: [
        Card(
            elevation: 7,
            child: ListTile(
                leading: Container(
                    height: 50, width: 50, color: Color(org.statusColor!)),
                title: Text(org.title as String,
                    style: TextStyle(
                        color: AppStyle.brown, fontWeight: FontWeight.bold)),
                subtitle: Text(org.priority!),
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
                                        _tickets.remove(org);
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

  void _bottomSheet(context, Ticket org) {
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
                    child: Text('Ticket Details',
                        style: TextStyle(
                          fontSize: AppStyle.XLargeTextSize,
                          color: AppStyle.brown,
                        ))),
                SizedBox(height: 10.0),
                ListTile(
                  title: DisplayDetails(
                    title: 'Title:',
                    info: org.title as String,
                  ),
                  onTap: () => {},
                ),
                ListTile(
                  title: DisplayDetails(
                    title: 'Description:',
                    info: org.desc as String,
                  ),
                  onTap: () => {},
                ),
                ListTile(
                  title: DisplayDetails(
                    title: 'Status:',
                    info: org.status!,
                  ),
                  onTap: () => {},
                ),
                ListTile(
                  title: DisplayDetails(
                    title: 'Priority:',
                    info: org.priority!,
                  ),
                  onTap: () => {},
                ),
                SizedBox(height: 10.0),
              ]),
            ),
          );
        });
  }

  // Widget getDialog(String title, double height, context) {
  //   TextEditingController _projName = TextEditingController();
  //   TextEditingController _projDesc = TextEditingController();
  //   String? _appVis;
  //   int? _dropdownvalue;

  //   return ConstrainedBox(
  //     constraints: BoxConstraints(maxHeight: height * 0.3),
  //     child: AlertDialog(
  //       actions: [
  //         Center(
  //             child: TextButton(
  //           child: Text('Submit', style: TextStyle(color: AppStyle.brown)),
  //           onPressed: () {
  //             Project proj = Project(
  //                 applicationName: _projName.text,
  //                 applicationDescription: _projDesc.text,
  //                 organizationId: _dropdownvalue,
  //                 markForPrivate: _appVis == 'Private' ? true : false);
  //             ApiService().addProject(proj).then((value) {
  //               if (value) {
  //                 Navigator.pop(context);
  //                 setState(() {});
  //               } else {
  //                 Utility().showToast(
  //                     'Unable to add organization, please try again.');
  //               }
  //             });
  //           },
  //           style: ButtonStyle(
  //               shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(15))),
  //               side: MaterialStateProperty.all(
  //                   BorderSide(color: AppStyle.brown))),
  //         ))
  //       ],
  //       title: Row(
  //         children: [
  //           Text(title),
  //           Spacer(
  //             flex: 2,
  //           ),
  //           Expanded(
  //               child: TextButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: Icon(
  //                     Icons.cancel,
  //                     color: AppStyle.brown,
  //                   )))
  //         ],
  //       ),
  //       content: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             AuthenticationTextField(
  //                 controller: _projName,
  //                 hintText: 'Enter project name',
  //                 keyboardType: TextInputType.text,
  //                 validator: (val) {
  //                   if (val!.isEmpty) return 'Project name is required';
  //                 },
  //                 obscureText: false),
  //             AuthenticationTextField(
  //                 controller: _projDesc,
  //                 hintText: 'Enter project description',
  //                 keyboardType: TextInputType.text,
  //                 validator: (val) {
  //                   if (val!.isEmpty) return 'Project description is required';
  //                 },
  //                 obscureText: false),
  //             SizedBox(
  //               height: height * 0.015,
  //             ),
  //             StatefulBuilder(
  //               builder:
  //                   (BuildContext context, void Function(void Function()) st) {
  //                 return DropdownButton(
  //                     value: _dropdownvalue,
  //                     hint: Text('Select organization'),
  //                     icon: const Icon(Icons.keyboard_arrow_down),
  //                     items: _orgInfo.map((Organization item) {
  //                       return DropdownMenuItem(
  //                         value: item.organizationId,
  //                         child: Text(item.organizationName as String),
  //                       );
  //                     }).toList(),
  //                     onChanged: (int? newValue) {
  //                       st(() {
  //                         _dropdownvalue = newValue!;
  //                       });
  //                     });
  //               },
  //             ),
  //             StatefulBuilder(
  //               builder:
  //                   (BuildContext context, void Function(void Function()) st) {
  //                 return DropdownButton(
  //                   value: _appVis,
  //                   hint: Text('Visibility of project'),
  //                   icon: const Icon(Icons.keyboard_arrow_down),
  //                   items: ['Public', 'Private'].map((e) {
  //                     return DropdownMenuItem(value: e, child: Text(e));
  //                   }).toList(),
  //                   onChanged: (val) {
  //                     st(() {
  //                       _appVis = val as String;
  //                     });
  //                   },
  //                 );
  //               },
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return _isLoading
        ? Scaffold(
            body: Center(
                child: CircularProgressIndicator(
            color: AppStyle.brown,
          )))
        : Scaffold(
            backgroundColor: AppStyle.cream,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // showDialog(
                //     context: context,
                //     builder: (context) {
                //       return getDialog('Add Ticket', height, context);
                //     });
              },
              child: Icon(Icons.add),
              backgroundColor: AppStyle.brown,
            ),
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
                child: ListView.builder(
                    itemCount: _tickets.length,
                    itemBuilder: (context, index) {
                      return makeCard(_tickets[index]);
                    })),
          );
  }
}
