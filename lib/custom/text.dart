import 'package:flutter/material.dart';

Widget customText(hint, prefixIcon, keyboardType, contrller, validator,
    {obscureText = false}) {
  return TextFormField(
      keyboardType: keyboardType,
      controller: contrller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: hint,
        // hintText: hint,

        prefixIcon: Icon(prefixIcon),
      ));
}

class AppString {
  static const app_name = "IDP Lab II";
}
