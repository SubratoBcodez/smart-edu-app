import 'package:get/route_manager.dart';
import 'package:untitled5/views/exam_nav.dart';
import 'package:untitled5/views/pages/about.dart';
import 'package:untitled5/views/pages/classes.dart';

import '../views/home.dart';
import '../views/intro.dart';
import '../views/login.dart';
import '../views/pages/account.dart';
import '../views/pages/notice.dart';
import '../views/pages/notice_page.dart';
import '../views/pages/subjects.dart';
import '../views/reg.dart';
import '../views/splash.dart';

const String splash = '/splash';
const String intro = '/intro';
const String login = '/login';
const String reg = '/reg';
const String home = '/home';
const String account = '/account';
const String subjects = '/subjects';
const String classes = '/classes';
const String exam = '/exam_nav';
const String notice = '/notice';
const String notpage = '/noticepage';
const String about = '/about';

// const String err = '/err';

List<GetPage> getPages = [
  GetPage(name: splash, page: () => SplashScreen()),
  GetPage(name: intro, page: () => introScreen()),
  GetPage(name: login, page: () => LoginScreen()),
  GetPage(name: reg, page: () => RegScreen()),
  GetPage(name: home, page: () => Home()),
  GetPage(name: account, page: () => Account()),
  GetPage(name: subjects, page: () => Subjects()),
  GetPage(name: classes, page: () => ClassSch()),
  GetPage(name: exam, page: () => ExamNav()),
  GetPage(name: notice, page: () => Notice()),
  GetPage(name: notpage, page: () => NoticePage(data: Get.arguments)),
  GetPage(name: about, page: () => Developers()),

  // GetPage(name: err, page: ()=>SplashScreen()),
];
