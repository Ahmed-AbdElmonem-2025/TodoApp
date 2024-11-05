
import 'package:flutter/material.dart';

class textFieldItem extends StatelessWidget {
  textFieldItem({
    Key? key,
    required this.Controller,
    required this.hintText,
    this.isSecure,
    this.onTap,
  }) : super(key: key);

  final TextEditingController Controller;
  String hintText;
  bool? isSecure;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: Controller,
      onTap:onTap,
      validator: (Input) {
        if (Controller.text.isEmpty) {
          return "$hintText must be not empty";
        } else {
          return null;
        }
      },
      obscureText: isSecure ?? false ,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}
