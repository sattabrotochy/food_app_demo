import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String name;
  bool obscureText;
  IconData iconData;

  final TextEditingController controller;
  MyTextField({
    @required this.name,
    @required this.obscureText,
    @required this.iconData,
    @required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(
          iconData,
          color: Colors.white,
        ),
        hintText: name,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
