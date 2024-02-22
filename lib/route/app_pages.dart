import 'package:foodfestadeliverymen/view/account/widgets/my_earning_screen.dart';
import 'package:foodfestadeliverymen/view/account/widgets/update_password_screen.dart';
import 'package:foodfestadeliverymen/view/auth/forgot_password_screen.dart';
import 'package:foodfestadeliverymen/view/index/bottom_screen.dart';
import 'package:foodfestadeliverymen/view/index/widgets/edit_profile_screen.dart';
import 'package:foodfestadeliverymen/view/index/widgets/home/widgets/order_detail_Screen.dart';
import 'package:foodfestadeliverymen/view/index/widgets/order/widget/order_management_detail_screen.dart';
import 'package:get/get.dart';

import '../view/auth/login_screen.dart';
import '../view/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.bottomScreen,
      page: () => BottomScreen(),
    ),
    GetPage(
      name: AppRoutes.updatePasswordScreen,
      page: () => UpdatePasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.editAccountScreen,
      page: () => EditAccountScreen(),
    ),
    GetPage(
      name: AppRoutes.orderDetailScreen,
      page: () => OrderDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.orderManagementDetailScreen,
      page: () => OrderManagementDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.myEarningScreen,
      page: () => MyEarningScreen(),
    ),
  ];
}
