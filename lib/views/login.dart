import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled5/logic/auth.dart';

import '../custom/button.dart';
import '../custom/route.dart';
import '../custom/text.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 200),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 80,
                ),
                customText('email', Icons.mail_outline,
                    TextInputType.emailAddress, _emailController, (val) {
                  if (val!.isEmpty) {
                    return "can't be empty";
                  } else if (val.length < 8) {
                    return "can't be less then 8";
                  }
                }),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: _isHidden,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isHidden = !_isHidden;
                        });
                      },
                      child: Icon(
                          _isHidden ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  controller: _passController,
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "can't be empty";
                    } else if (val.length < 8) {
                      return "can't be less then 8";
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                customButton('Sign In', () {
                  if (_formKey.currentState!.validate()) {
                    final email = _emailController.text;
                    final pass = _passController.text;
                    Auth().log(email, pass, context);
                  }
                }),
                SizedBox(
                  height: 15,
                ),
                RichText(
                    text: TextSpan(
                        text: 'Don\'t Have an Account?',
                        style: TextStyle(color: Colors.black),
                        children: [
                      TextSpan(
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => Get.toNamed(reg),
                          text: 'Create Now',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w600))
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
