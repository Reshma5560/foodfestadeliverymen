import 'package:flutter/material.dart';
import 'package:foodfestadeliverymen/view/account/setting_screen.dart';
import 'package:foodfestadeliverymen/view/index/widgets/edit_profile_screen.dart';
import 'package:foodfestadeliverymen/view/index/widgets/home/home_screen.dart';
import 'package:foodfestadeliverymen/view/index/widgets/order/order_management_screen.dart';
import 'package:get/get.dart';

class BottomController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxBool isLoading = false.obs;

  void changeIndex(int index) async {
    selectedIndex.value = index;
    if (index == 0) {
    } else if (index == 1) {
    } else if (index == 2) {}
  }

  final pages = <Widget>[
    HomeScreen(),
    OrderManagementScreen(),
    EditAccountScreen(),
    AccountScreen()
  ];
}
