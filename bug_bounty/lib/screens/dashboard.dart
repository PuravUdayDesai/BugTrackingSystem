import 'dart:convert';

import 'package:bug_bounty/Widgets/custom_drawer.dart';
import 'package:bug_bounty/models/User.dart';

import 'package:bug_bounty/utils/AppStyle.dart';
import 'package:bug_bounty/utils/Constants.dart';
import 'package:bug_bounty/utils/PrefHelper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// getDashboardData() async {

//   var headers = {
//     'Authorization': CurrentUser.ACCESS_TOKEN
//   };
//   final res = await http.get(Uri.GET_OWNER+'/dashboard/${CurrentUser.id}',headers: headers);

//   return Dashboard.fromJson(jsonDecode(res.body));
// }

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  User? userInfo;

  Widget displayCard(IconData ic, String title, String count, int colorCode) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 350,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 7,
              color: Color(colorCode),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(ic, color: Colors.white70),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                              child: Text(
                            title,
                          )),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.black26),
                  Text(
                    count + '*',
                    textScaleFactor: 1.6,
                  ),
                ],
              ),
            )),
        onTap: null,
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<User> _user = Constants().getUserInfo();

    return _isLoading
        ? Scaffold(
            body: Center(
                child: CircularProgressIndicator(
            color: AppStyle.brown,
          )))
        : Scaffold(
            backgroundColor: AppStyle.cream,
            drawer: SafeArea(
                child: CustomDrawer(
              index: 1,
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
            body: SingleChildScrollView(
              child: Container(
                  height: MediaQuery.of(context).size.height * 1.4,
                  child: Column(
                    children: <Widget>[
                      Divider(),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    'Top Perfomances',
                                    textScaleFactor: 1.8,
                                    style: TextStyle(
                                      color: AppStyle.brown,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(),
                              Expanded(
                                  flex: 3,
                                  child: 1 == 0
                                      ? Center(
                                          child: Text('No Data Exists.!!',
                                              style: TextStyle(
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold)))
                                      : ListView.builder(
                                          itemCount: 3,
                                          itemBuilder: (con, index) {
                                            var item = {};
                                            return Card(
                                              elevation: 3,
                                              child: ListTile(
                                                leading: Container(
                                                    width: 40.0,
                                                    height: 40.0,
                                                    decoration: new BoxDecoration(
                                                        color: Colors.transparent,
                                                        shape: BoxShape.circle,
                                                        image: new DecorationImage(
                                                            fit: BoxFit.fitHeight,
                                                            image: index == 0
                                                                ? AssetImage('assets/first.jpg')
                                                                : index == 1
                                                                    ? AssetImage('assets/second.jpg')
                                                                    : AssetImage('assets/third.jpg')))),
                                                title: Text(
                                                  _user[index].userName
                                                      as String,
                                                  style: TextStyle(
                                                    color: AppStyle.brown,
                                                  ),
                                                ),
                                                trailing: Text(_user[index]
                                                    .userId
                                                    .toString()),
                                              ),
                                            );
                                          })),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            elevation: 1,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                    flex: 2,
                                    child: Center(
                                        child: Text(
                                      'STATS AT GLANCE',
                                      textScaleFactor: 1.8,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppStyle.brown,
                                      ),
                                    ))),
                                Divider(),
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: displayCard(
                                            Icons.shopping_cart,
                                            'Products',
                                            '5', //${dashboardData.numberOfProducts}
                                            0xffffc400),
                                      ),
                                      Expanded(
                                        child: displayCard(
                                            Icons.people,
                                            'Clients',
                                            '2', //${dashboardData.numberOfClients}
                                            0xff2c75b0),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: displayCard(
                                              Icons.pages,
                                              'Tickets',
                                              '10', //${dashboardData.numberOftickets}
                                              0xffeb6963)),
                                      Expanded(
                                        child: displayCard(
                                            Icons.business_center,
                                            'Executives',
                                            '20', //${dashboardData.numberOfExecutives}
                                            0xff28b061),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )

                  // if(snapshot.data.length == 0){
                  //   return Text('No data exists.!!');
                  // }
                  //return Center(child : CircularProgressIndicator());

                  ),
            ),
          );
  }
}
