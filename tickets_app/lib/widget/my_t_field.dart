import 'package:flutter/material.dart';
import 'package:tickets_app/core/extensions/color_ext.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      required this.controller});
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          filled: true,
          fillColor: C.lithGray,
          hintText: hintText,
        ),
      ),
    );
  }
}
