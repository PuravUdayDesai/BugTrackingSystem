import 'package:bug_bounty/utils/AppStyle.dart';
import 'package:flutter/material.dart';

class TicketInfo extends StatelessWidget {
  final String title;
  final String info;

  TicketInfo({required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 7,
            child: ListTile(
                title: Text(title,
                    style: TextStyle(
                        color: AppStyle.brown, fontWeight: FontWeight.bold)),
                subtitle: Text(info),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: Icon(Icons.info_outline,
                            size: 25.0, color: Colors.grey),
                        onPressed: () {
                          // _bottomSheet(context, org);
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
                                        // ApiService()
                                        //     .deleteOrganization(
                                        //         org.organizationId as int)
                                        //     .then((value) {
                                        //   if (value) {
                                        //     Navigator.of(c).pop();
                                        //     setState(() {});
                                        //   } else {
                                        //     Utility().showToast(
                                        //         'Unable to delete, please try again.');
                                        //   }
                                        // });
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
}
