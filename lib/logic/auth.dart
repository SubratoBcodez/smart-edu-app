import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled5/custom/route.dart';
import 'package:untitled5/custom/style.dart';

class Auth {
  final box = GetStorage();
  upload(Image, context, fname, lname, email, idnum, pass) async {
    try {
      AppStyle().progressDialog(context);
      File imageFile = File(Image.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      UploadTask uploadTask =
          storage.ref('profile-img').child(Image.name).putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String imgUrl = await snapshot.ref.getDownloadURL();
      Get.back();
      reg(fname, lname, email, idnum, pass, imgUrl);
      // print(imgUrl);
    } catch (e) {
      Get.showSnackbar(AppStyle().failedSnack('Something went wrong'));
    }
  }

  reg(fname, lname, idnum, email, pass, imgUrl) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      var userCredential = credential.user;

      if (userCredential!.uid.isNotEmpty) {
        CollectionReference reference =
            FirebaseFirestore.instance.collection('students');
        reference.doc().set({
          'f_name': fname,
          'l_name': lname,
          'idnum': idnum,
          'email': email,
          'pass': pass,
          'picture': imgUrl,
        }).then((value) {
          Get.back();
          Get.showSnackbar(
              AppStyle().successSnack('Account Created Successfull'));
          box.write('logged', true);
          box.write('idnum', idnum);
          Get.toNamed(home);
        });
      } else {}
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.back();
        Get.showSnackbar(
            AppStyle().failedSnack('The password provided is too weak.'));

        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.back();
        Get.showSnackbar(AppStyle()
            .failedSnack('The account already exists for that email.'));

        // print('The account already exists for that email.');
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(AppStyle().failedSnack('Something went wrong'));
    }
  }

  log(email, pass, context) async {
    try {
      AppStyle().progressDialog(context);
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);

      var userCredenttial = credential.user;
      if (userCredenttial!.uid.isNotEmpty) {
        Get.back();
        Get.showSnackbar(AppStyle().successSnack('Access Granted'));
        box.write('logged', true);
        box.write('email', email);
        Get.toNamed(home);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.back();
        Get.showSnackbar(
            AppStyle().failedSnack('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        Get.back();
        Get.showSnackbar(
            AppStyle().failedSnack('Wrong password provided for that user.'));
      } else {
        Get.back();
        Get.showSnackbar(AppStyle().failedSnack('Something went wrong'));
      }
    }
  }
}
