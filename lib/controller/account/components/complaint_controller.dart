import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderComplaintController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController complaintMessageCon = TextEditingController();
  RxBool complaintMessageValidation = false.obs;
  RxString complaintMessageError = ''.obs;
}
