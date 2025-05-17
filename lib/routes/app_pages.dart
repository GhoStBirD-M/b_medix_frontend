// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import '../../routes/login_redirect_middleware.dart';
import '../bindings/bindings.dart';
import '../views/article/articles.dart';
import '../views/auth/auth.dart';
import '../views/consultation/consultations.dart';
import '../views/order/orders_screen.dart';
import '../views/order/cart_sreen.dart';
import '../routes/auth_middleware.dart';
import '../views/profile/profile_screen.dart';
import '../views/home/splash_screen.dart';
import '../views/home/home_page.dart';

class AppPages {
  static const SPLASH = '/';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const HOME = '/home';
  static const ARTICLE = '/article';
  static const ARTICLE_DETAIL = '/article/detail';
  static const CONSULTATION = '/consultation';
  static const MEDICINE_DETAILS = '/medicine/detail';
  static const CHAT = '/chat/:id';
  static const CART = '/cart';
  static const ORDERS = '/orders';
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
      middlewares: [LoginRedirectMiddleware()],
    ),
    GetPage(
      name: REGISTER,
      page: () => RegisterScreen(),
      binding: AuthBinding(),
      middlewares: [LoginRedirectMiddleware()],
    ),
    GetPage(
      name: HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: PROFILE,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
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
      name: CONSULTATION,
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
      name: MEDICINE_DETAILS,
      page: () => MedicineDetailScreen(),
      binding: MedicineBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: CART,
      page: () => CartScreen(),
      binding: CartBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: ORDERS,
      page: () => OrdersScreen(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
