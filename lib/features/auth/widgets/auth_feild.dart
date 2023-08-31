import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class AuthFeild extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const AuthFeild(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Pallete.greyColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Pallete.blueColor, width: 3)),
          contentPadding: EdgeInsets.all(22),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 18)),
    );
  }
}
