import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../custom/route.dart';
import '../custom/text.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  chooseScreen(context) {
    var loginchk = box.read('logchk');
    var regchk = box.read('regchk');
    var logged = box.read('logged');

    if (logged == true) {
      Get.toNamed(home);
    } else if (loginchk == true || regchk == true) {
      Get.toNamed(login);
    } else {
      Get.toNamed(intro);
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () => chooseScreen(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 220),
                child: Center(
                    child: Image.asset(
                  'assets/icons/schedule.png',
                  width: 100,
                  height: 100,
                )),
              ),
              // Center(child: Image.asset('assets/images/main.png', width: 120,),),
              SizedBox(
                height: 10,
              ),
              Text(
                AppString.app_name,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
