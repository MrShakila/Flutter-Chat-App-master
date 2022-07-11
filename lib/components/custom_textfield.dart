import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFIeld extends StatelessWidget {
  final String title;
  final Icon icon;
  final Icon suficon;

  // final TextEditingController controller;
  final TextInputType textInputType;
  bool isObscure;
  CustomTextFIeld(
      {Key? key,
      required this.title,
      required this.icon,
      required this.suficon,
      //  this.controller,
      this.isObscure = false,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: TextFormField(
            keyboardType: textInputType,
            obscureText: isObscure,
            // controller: controller,
            decoration: InputDecoration(
                suffixIcon: suficon,
                prefixIcon: icon,
                hintText: title,
                border: InputBorder.none),
          ),
        ));
  }
}
