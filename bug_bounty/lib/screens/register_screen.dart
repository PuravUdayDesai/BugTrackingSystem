import 'package:bug_bounty/models/User.dart';
import 'package:bug_bounty/utils/ApiService.dart';
import 'package:bug_bounty/utils/AppStyle.dart';
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

  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyDescController = TextEditingController();
  TextEditingController companyWebsiteController = TextEditingController();

  bool isLoading = false;
  bool _obscureText = true;

  String _regAsOrg = 'No';

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
            backgroundColor: AppStyle.white,
            appBar: AppBar(
              backgroundColor: AppStyle.white,
              elevation: 1,
              centerTitle: true,
              title: Text(
                'Register your account',
                style: TextStyle(
                  color: AppStyle.brown,
                  fontSize: AppStyle.MediumTextSize,
                ),
              ),
            ),
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.03,
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
                          height: width / 20,
                        ),
                        Text('Do you want to register as an organization?'),
                        Row(
                          children: [
                            Radio(
                                value: 'Yes',
                                groupValue: _regAsOrg,
                                onChanged: (val) {
                                  setState(() {
                                    _regAsOrg = val as String;
                                  });
                                }),
                            Text('Yes')
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 'No',
                                groupValue: _regAsOrg,
                                onChanged: (val) {
                                  setState(() {
                                    _regAsOrg = val as String;
                                  });
                                }),
                            Text('No')
                          ],
                        ),
                        _regAsOrg == 'Yes'
                            ? Column(
                                children: [
                                  AuthenticationTextField(
                                    controller: companyNameController,
                                    hintText: 'Enter your company name',
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Company name cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: width / 20,
                                  ),
                                  AuthenticationTextField(
                                    controller: companyDescController,
                                    hintText: 'Enter description of company',
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Company description cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: width / 20,
                                  ),
                                  AuthenticationTextField(
                                      controller: companyWebsiteController,
                                      hintText: 'Enter website of company',
                                      obscureText: false,
                                      keyboardType: TextInputType.url,
                                      validator: null),
                                ],
                              )
                            : Container(),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        InkWell(
                          child: Container(
                            height: height * 0.08,
                            width: width * 0.5,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppStyle.darkCream),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(color: Colors.grey, blurRadius: 2)
                              ],
                              gradient: LinearGradient(
                                  colors: [AppStyle.cream, AppStyle.darkCream],
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
                                  userName: nameController.text);
                              ApiService().registerUser(user).then((value) {
                                
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
            ),
          );
  }
}
