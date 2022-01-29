import 'package:bug_bounty/screens/dashboard.dart';
import 'package:bug_bounty/screens/organizations.dart';
import 'package:bug_bounty/screens/project_screen.dart';
import 'package:bug_bounty/utils/AppStyle.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final int index;
  final String userName;
  final String userContactNumber;

  CustomDrawer(
      {required this.index,
      required this.userName,
      required this.userContactNumber});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: height * 0.15,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppStyle.brown, AppStyle.darkBrown],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Center(
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Image.asset('assets/profile.png',
                        height: height * 0.1)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName,
                        style: TextStyle(
                            color: AppStyle.white,
                            fontSize: AppStyle.LargeTextSize)),
                    Text(userContactNumber,
                        style: TextStyle(color: Colors.white)),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(height: height * 0.01),
        ListTile(
          leading: Icon(Icons.dashboard, color: AppStyle.brown),
          title: Text('Dashboard'),
          tileColor: index == 1 ? AppStyle.cream : null,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => HomeScreen(),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.blur_circular_rounded, color: AppStyle.brown),
          title: Text('Organizations'),
          tileColor: index == 2 ? AppStyle.cream : null,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => OrganizationScreen(),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.folder_open, color: AppStyle.brown),
          title: Text('Projects'),
          tileColor: index == 3 ? AppStyle.cream : null,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ProjectScreen(),
              ),
            );
          },
        ),
      ],
    ));
  }
}
