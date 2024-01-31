import 'dart:async';

import 'package:get/get.dart';

import '../route/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    navigation();
    super.onInit();
  }


  navigation() {
    Timer(
      const Duration(seconds: 5),
      () => Get.offAllNamed(AppRoutes.loginScreen),
    );
  }
}
