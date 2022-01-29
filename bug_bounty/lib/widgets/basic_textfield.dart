import 'package:bug_bounty/utils/AppStyle.dart';
import 'package:flutter/material.dart';

class AuthenticationTextField extends StatelessWidget {

  TextEditingController controller;
  String hintText;
  TextInputType keyboardType;
  String? Function(String?)? validator;
  bool obscureText;
  Widget? suffixIcon;

  AuthenticationTextField(
        {required this.controller,
        required this.hintText,
        required this.keyboardType,
        required this.validator,
        required this.obscureText,
        this.suffixIcon});

  // const AuthenticationTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: AppStyle.brown,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppStyle.grey,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppStyle.brown,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppStyle.brown,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppStyle.red,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppStyle.red,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
