import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../custom/button.dart';
import '../custom/route.dart';
import '../custom/style.dart';
import '../custom/text.dart';
import '../logic/auth.dart';

class RegScreen extends StatefulWidget {
  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _uppassController = TextEditingController();

  final TextEditingController _fnameController = TextEditingController();

  final TextEditingController _lnameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  XFile? image;
  bool _isHidden = true;

  pickImageGallery() async {
    final ImagePicker picker = ImagePicker();
    image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    // print(image!.path);
    // print(image!.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 100),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Signup",
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                      child: image == null
                          ? Center(
                              child: IconButton(
                                  onPressed: () => pickImageGallery(),
                                  icon: Icon(Icons.camera)),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                File(image!.path),
                                fit: BoxFit.fill,
                              )),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  customText('first name', Icons.account_circle_outlined,
                      TextInputType.text, _fnameController, (val) {
                    if (val!.isEmpty) {
                      return "can't be empty";
                    } else if (val.length < 5) {
                      return "can't be less then 5";
                    }
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  customText('last name', Icons.account_circle_outlined,
                      TextInputType.text, _lnameController, (val) {
                    if (val!.isEmpty) {
                      return "can't be empty";
                    } else if (val.length < 5) {
                      return "can't be less then 5";
                    }
                  }),
                  SizedBox(
                    height: 15,
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
                        child: Icon(_isHidden
                            ? Icons.visibility_off
                            : Icons.visibility),
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
                        child: Icon(_isHidden
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    controller: _uppassController,
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
                  customButton('Sign Up', () {
                    if (image == null) {
                      Get.showSnackbar(
                          AppStyle().failedSnack('Upload Your Image First'));
                    } else if (_formKey.currentState!.validate()) {
                      final fname = _fnameController.text;
                      final lname = _lnameController.text;
                      final email = _emailController.text;
                      final pass = _passController.text;
                      Auth().upload(image, context, fname, lname, email, pass);
                      // Get.toNamed(home);
                      //Get.showSnackbar(AppStyle().successSnack('Access Granted'));
                    } else {
                      Get.showSnackbar(AppStyle().failedSnack('Access Denied'));
                    }
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Already Have an Account?',
                          style: TextStyle(color: Colors.black),
                          children: [
                        TextSpan(
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(login),
                            text: 'Login Now',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600)),
                      ])),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
