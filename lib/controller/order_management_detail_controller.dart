import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:foodfestadeliverymen/data/models/get_order_by_id_model.dart';
import 'package:foodfestadeliverymen/repositories/desktop_repository.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class OrderManagementDetailController extends GetxController {
  Rx<GetOrderByIdModel> getOrderDataModel = GetOrderByIdModel().obs;

  RxBool isLoading = true.obs;
  RxString orderId = "".obs;

  @override
  void onInit() {
    orderId.value = Get.arguments['orderId'];
    super.onInit();
  }

  Future<void> downloadFile(
      {required String url,
      required String fileName,
      required bool isDownload}) async {
    try {
      // Request WRITE_EXTERNAL_STORAGE permission at runtime
      await _requestStoragePermission();

      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: '/storage/emulated/0/Download/',
        fileName: fileName,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: true,
      );
      isDownload = false;

      log('Download task ID: $taskId');
    } catch (e) {
      log('Error during download: $e');
    }
  }

  Future<void> _requestStoragePermission() async {
    try {
      // Ask for permission
      await Permission.storage.request();
    } on PlatformException catch (e) {
      log('Error requesting storage permission: $e');
    }
  }

  @override
  Future<void> onReady() async {
    await DesktopRepository().getOrderByIdApiCall(
        isLoader: isLoading,
        orderId: orderId.value,
        orderData:
            getOrderDataModel); // "9b3acdb9-facd-48f7-b42b-808a47ee202a");
    super.onReady();
  }
}
