// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:tes_main/views/doctor/doctor_screen.dart';
import '../bindings/article_binding.dart';
import '../views/article/article_detail_screen.dart';
import '../views/article/article_screen.dart';
import '../bindings/auth_binding.dart';
import '../bindings/home_binding.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/register_screen.dart';
import '../views/home/home_page.dart';

class AppPages {
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const HOME = '/home';
  static const ARTICLE = '/article';
  static const ARTICLE_DETAIL = '/article/detail';
  static const DOCTOR = '/doctor';


  static final routes = [
    GetPage(
      name: LOGIN,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: REGISTER,
      page: () => RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: ARTICLE,
      page: () => ArticleScreen(),
      binding: ArticleBinding(),
    ),
    GetPage(
      name: ARTICLE_DETAIL,
      page: () => ArticleDetailScreen(),
      binding: ArticleBinding(),
    ),
    GetPage(
      name: DOCTOR, 
      page: () => DoctorScreen(),
      )
  ];
}
