import 'package:get/route_manager.dart';

import '../views/home.dart';
import '../views/intro.dart';
import '../views/login.dart';
import '../views/pages/account.dart';
import '../views/reg.dart';
import '../views/splash.dart';

const String splash = '/splash';
const String intro = '/intro';
const String login = '/login';
const String reg = '/reg';
const String home = '/home';
const String account = '/account';
// const String err = '/err';

List<GetPage> getPages = [
  GetPage(name: splash, page: () => SplashScreen()),
  GetPage(name: intro, page: () => introScreen()),
  GetPage(name: login, page: () => LoginScreen()),
  GetPage(name: reg, page: () => RegScreen()),
  GetPage(name: home, page: () => Home()),
  GetPage(name: account, page: () => Account()),
  // GetPage(name: err, page: ()=>SplashScreen()),
];
