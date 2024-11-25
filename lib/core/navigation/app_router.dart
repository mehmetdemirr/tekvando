import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:tekvando/product/auth/forgot-password/forgot_password_screen.dart';
import 'package:tekvando/product/auth/login/view/login_screen.dart';
import 'package:tekvando/product/auth/register/view/register_screen.dart';
import 'package:tekvando/product/auth/reset-password/reset_password_screen.dart';
import 'package:tekvando/product/bottom_navigation/view/bottom_navigation_screen.dart';
import 'package:tekvando/product/notification/view/notification_screen.dart';
import 'package:tekvando/product/setting/setting_screen.dart';
import 'package:tekvando/product/splash/view/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen|Page,Route',
)
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => Platform.isAndroid
      ? const RouteType.material()
      : const RouteType.cupertino();
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: RouterItem.splash.str(),
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: RouterItem.bottomNavigation.str(),
          page: BottomNavigationRoute.page,
        ),
        AutoRoute(
          path: RouterItem.setting.str(),
          page: SettingRoute.page,
        ),
        AutoRoute(
          path: RouterItem.notification.str(),
          page: NotificationRoute.page,
        ),
        AutoRoute(
          path: RouterItem.login.str(),
          page: LoginRoute.page,
        ),
        AutoRoute(
          path: RouterItem.register.str(),
          page: RegisterRoute.page,
        ),
        AutoRoute(
          path: RouterItem.resetPassword.str(),
          page: ResetPasswordRoute.page,
        ),
      ];
}

enum RouterItem {
  splash,
  login,
  register,
  resetPassword,
  forgotPassword,
  bottomNavigation,
  home,
  setting,
  notification,
}

extension RouterItems on RouterItem {
  String str() {
    return "/$name";
  }
}
