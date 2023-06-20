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

  Column profilMenu(press, icons, text) => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: Color(0xFFF5F6F9),
              ),
              onPressed: press,
              child: Row(
                children: [
                  Icon(icons),
                  SizedBox(width: 20),
                  Expanded(child: Text(text)),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          )
        ],
      );
}
