import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStyle {
  progressDialog(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Image.asset(
              'assets/file/loading.gif',
              height: 100,
            ),
          );
        });
  }

  GetSnackBar failedSnack(message) => GetSnackBar(
        message: message,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        icon: Icon(Icons.warning),
      );

  GetSnackBar successSnack(message) => GetSnackBar(
        message: message,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        icon: Icon(Icons.done),
      );

  BottomNavigationBarItem navBar(icons, labels) =>
      BottomNavigationBarItem(icon: Icon(icons), label: labels);
}
