// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import '../bindings/chat_binding.dart';
import '../bindings/doctor_binding.dart';
import '../views/consultation/doctor_chat_screen.dart';
import '../bindings/profile_binding.dart';
import '../routes/auth_middleware.dart';
import '../views/consultation/doctor_screen.dart';
import '../views/home/splash_screen.dart';
import '../views/profile/profile_screen.dart';
import '../bindings/article_binding.dart';
import '../views/article/article_detail_screen.dart';
import '../views/article/article_screen.dart';
import '../bindings/auth_binding.dart';
import '../bindings/home_binding.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/register_screen.dart';
import '../views/home/home_page.dart';

class AppPages {
  static const SPLASH = '/';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const HOME = '/home';
  static const ARTICLE = '/article';
  static const ARTICLE_DETAIL = '/article/detail';
  static const DOCTOR = '/doctor';
  static const CHAT = '/chat/:id';
  static const PROFILE = '/profile';


  static final routes = [
    GetPage(
      name: SPLASH,
      page: () => SplashScreen(),
      binding: AuthBinding(),
    ),
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
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: ARTICLE,
      page: () => ArticleScreen(),
      binding: ArticleBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: ARTICLE_DETAIL,
      page: () => ArticleDetailScreen(),
      binding: ArticleBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: DOCTOR, 
      page: () => DoctorScreen(),
      binding: DoctorBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: CHAT, 
      page: () => DoctorChatScreen(),
      binding: ChatBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: PROFILE, 
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
