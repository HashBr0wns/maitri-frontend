import 'package:flutter/material.dart';
import 'package:maitri/utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final Widget iconName;
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput(
      {super.key,
      required this.textEditingController,
      this.isPass = false,
      required this.hintText,
      required this.iconName,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: BorderSide(color:primaryColor),borderRadius: BorderRadius.all(Radius.circular(25)));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: iconName,
        hintText: hintText,
        border: inputBorder,
        fillColor: backgroundColor,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(18),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
