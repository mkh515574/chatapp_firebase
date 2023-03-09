import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hintText,
      this.borderSide,
      required this.keyboardType,
      required this.isPassword,
      this.controller,
      this.iconData,
      required this.textValidate});
  final String hintText;
  TextEditingController? controller;
  String textValidate;
  bool isPassword = false;
  var keyboardType;
  var iconData;
  BorderSide? borderSide = const BorderSide(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(border: Border(bottom: borderSide!)),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        validator: (val) {
          if (val!.isEmpty) {
            return textValidate;
          }
          return null;
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: iconData,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400])),
      ),
    );
  }
}
