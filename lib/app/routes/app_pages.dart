import 'package:get/get.dart';
import 'package:myapp/app/modules/Create/bindings/create_binding.dart';
import 'package:myapp/app/modules/Create/views/create_view.dart';

import '../../splash_screen.dart';

import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/Register/bindings/register_binding.dart';
import '../modules/Register/views/register_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const Login = Routes.LOGIN;
  static const Splash = '/splash';
  static const Create = '/create';

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Create,
      page: () => CreateView(),
      binding: CreateBinding(),
    ),
  ];
}
