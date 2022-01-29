// import 'package:bug_bounty/models/User.dart';
// import 'package:bug_bounty/utils/ApiService.dart';
// import 'package:bug_bounty/utils/AppStyle.dart';
// import 'package:bug_bounty/utils/Utility.dart';
// import 'package:bug_bounty/widgets/basic_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({Key? key}) : super(key: key);

//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController countryNameController = TextEditingController();

//   TextEditingController companyNameController = TextEditingController();
//   TextEditingController companyDescController = TextEditingController();
//   TextEditingController companyWebsiteController = TextEditingController();

//   bool isLoading = false;
//   bool _obscureText = true;

//   String _regAsOrg = 'No';

//   void _toggle() {
//     this.setState(() {
//       _obscureText = !_obscureText;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;

//     return isLoading
//         ? Scaffold(
//             backgroundColor: AppStyle.cream,
//             body: SafeArea(
//               child: Center(
//                 child: CircularProgressIndicator(
//                   color: AppStyle.white,
//                 ),
//               ),
//             ),
//           )
//         : Scaffold(
//             backgroundColor: AppStyle.white,
//             appBar: AppBar(
//               backgroundColor: AppStyle.white,
//               elevation: 1,
//               centerTitle: true,
//               title: Text(
//                 'Register your account',
//                 style: TextStyle(
//                   color: AppStyle.brown,
//                   fontSize: AppStyle.MediumTextSize,
//                 ),
//               ),
//             ),
//             body: SafeArea(
//               child: Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: width * 0.1),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: height * 0.03,
//                         ),
//                         AuthenticationTextField(
//                           controller: nameController,
//                           hintText: 'Enter your name',
//                           obscureText: false,
//                           keyboardType: TextInputType.text,
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please enter your name';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(
//                           height: width / 20,
//                         ),
//                         AuthenticationTextField(
//                           controller: phoneController,
//                           hintText: 'Enter contact number',
//                           obscureText: false,
//                           keyboardType: TextInputType.phone,
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Phone number cannot be empty';
//                             } else if (value.length != 10) {
//                               return 'Please enter valid contact number';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(
//                           height: width / 20,
//                         ),
//                         AuthenticationTextField(
//                           controller: emailController,
//                           hintText: 'Enter your email address',
//                           obscureText: false,
//                           keyboardType: TextInputType.emailAddress,
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Email address cannot be empty';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(
//                           height: width / 20,
//                         ),
//                         AuthenticationTextField(
//                           controller: passwordController,
//                           hintText: 'Password',
//                           obscureText: _obscureText,
//                           suffixIcon: Padding(
//                             padding: const EdgeInsets.only(right: 5.0),
//                             child: IconButton(
//                               onPressed: _toggle,
//                               icon: Icon(
//                                 _obscureText
//                                     ? FontAwesomeIcons.eyeSlash
//                                     : FontAwesomeIcons.eye,
//                                 color: Colors.black,
//                                 size: 20.0,
//                               ),
//                             ),
//                           ),
//                           keyboardType: TextInputType.visiblePassword,
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Password cannot be empty';
//                             } else if (value.length < 6) {
//                               return 'Password cannot be less than 6 characters';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(
//                           height: width / 20,
//                         ),
//                         AuthenticationTextField(
//                           controller: countryNameController,
//                           hintText: 'Enter country name',
//                           obscureText: false,
//                           keyboardType: TextInputType.text,
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Country name cannot be empty';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(
//                           height: height * 0.05,
//                         ),
//                         InkWell(
//                           child: Container(
//                             height: height * 0.08,
//                             width: width * 0.5,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: AppStyle.darkCream),
//                               borderRadius: BorderRadius.circular(10.0),
//                               boxShadow: [
//                                 BoxShadow(color: Colors.grey, blurRadius: 2)
//                               ],
//                               gradient: LinearGradient(
//                                   colors: [AppStyle.cream, AppStyle.darkCream],
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter),
//                             ),
//                             child: Center(
//                                 child: Text(
//                               'Register',
//                               style: TextStyle(
//                                   color: AppStyle.brown,
//                                   fontSize: AppStyle.SmallTextSize),
//                             )),
//                           ),
//                           onTap: () {
//                             if (_formKey.currentState!.validate()) {
//                               User user = User(
//                                   userContactNumber: phoneController.text,
//                                   userCountry: countryNameController.text,
//                                   userEmailId: emailController.text,
//                                   userName: nameController.text,
//                                   password: passwordController.text);

//                               ApiService().registerUser(user).then((value) {
//                                 if (value) {
//                                   Navigator.pop(context);
//                                 } else {
//                                   Utility().showToast(
//                                       'Contact number already exists, please try with different number.');
//                                 }
//                               });
//                             }
//                           },
//                         ),
//                         SizedBox(
//                           height: width / 20,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//   }
// }

import 'package:bug_bounty/models/User.dart';
import 'package:bug_bounty/utils/ApiService.dart';
import 'package:bug_bounty/utils/AppStyle.dart';
import 'package:bug_bounty/utils/Utility.dart';
import 'package:bug_bounty/widgets/basic_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();

  bool isLoading = false;
  bool _obscureText = true;

  void _toggle() {
    this.setState(() {
      _obscureText = !_obscureText;
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
                  color: AppStyle.white,
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: AppStyle.cream,
            appBar: AppBar(
              backgroundColor: AppStyle.cream,
              elevation: 0.0,
            ),
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: width,
                      padding: EdgeInsets.symmetric(
                        vertical: width / 10,
                        horizontal: width / 20,
                      ),
                      decoration: BoxDecoration(
                        color: AppStyle.cream,
                      ),
                      child: Image.asset('assets/logo.jpeg',
                          height: height * 0.13),
                    ),
                    Expanded(
                      child: Container(
                        width: width,
                        height: height * 0.85,
                        padding: EdgeInsets.symmetric(
                          horizontal: width / 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppStyle.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.05,
                              ),
                              Text(
                                'Register your account',
                                style: TextStyle(
                                  color: AppStyle.brown,
                                  fontSize: AppStyle.XLargeTextSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: width / 10,
                              ),
                              AuthenticationTextField(
                                controller: nameController,
                                hintText: 'Enter your name',
                                obscureText: false,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: width / 20,
                              ),
                              AuthenticationTextField(
                                controller: phoneController,
                                hintText: 'Enter contact number',
                                obscureText: false,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Phone number cannot be empty';
                                  } else if (value.length != 10) {
                                    return 'Please enter valid contact number';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: width / 20,
                              ),
                              AuthenticationTextField(
                                controller: emailController,
                                hintText: 'Enter your email address',
                                obscureText: false,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email address cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: width / 20,
                              ),
                              AuthenticationTextField(
                                controller: passwordController,
                                hintText: 'Password',
                                obscureText: _obscureText,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: IconButton(
                                    onPressed: _toggle,
                                    icon: Icon(
                                      _obscureText
                                          ? FontAwesomeIcons.eyeSlash
                                          : FontAwesomeIcons.eye,
                                      color: Colors.black,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password cannot be empty';
                                  } else if (value.length < 6) {
                                    return 'Password cannot be less than 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: width / 20,
                              ),
                              AuthenticationTextField(
                                controller: countryNameController,
                                hintText: 'Enter country name',
                                obscureText: false,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Country name cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: height * 0.05,
                              ),
                              SizedBox(
                                height: height * 0.05,
                              ),
                              InkWell(
                                child: Container(
                                  height: height * 0.08,
                                  width: width * 0.5,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppStyle.darkCream),
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 2)
                                    ],
                                    gradient: LinearGradient(
                                        colors: [
                                          AppStyle.cream,
                                          AppStyle.darkCream
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Register',
                                    style: TextStyle(
                                        color: AppStyle.brown,
                                        fontSize: AppStyle.SmallTextSize),
                                  )),
                                ),
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    User user = User(
                                        userContactNumber: phoneController.text,
                                        userCountry: countryNameController.text,
                                        userEmailId: emailController.text,
                                        userName: nameController.text,
                                        password: passwordController.text);
                                    ApiService()
                                        .registerUser(user)
                                        .then((value) {
                                      if (value) {
                                        Navigator.pop(context);
                                      } else {
                                        Utility().showToast(
                                            'Contact number already exists, please try with different number.');
                                      }
                                    });
                                  }
                                },
                              ),
                              SizedBox(
                                height: width / 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
