// ignore_for_file: unnecessary_null_comparison, unnecessary_string_interpolations

import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:foodfestadeliverymen/controller/account/account_controller.dart';
import 'package:foodfestadeliverymen/controller/account/components/edit_account_controller.dart';
import 'package:foodfestadeliverymen/controller/account/components/my_earning_controller.dart';
import 'package:foodfestadeliverymen/controller/home_controller.dart';
import 'package:foodfestadeliverymen/controller/order_management_controller.dart';
import 'package:foodfestadeliverymen/data/api/api_function.dart';
import 'package:foodfestadeliverymen/data/models/current_order_model.dart';
import 'package:foodfestadeliverymen/data/models/current_order_status_model.dart';
import 'package:foodfestadeliverymen/data/models/get_deliverymen_earning_model.dart';
import 'package:foodfestadeliverymen/data/models/get_order_by_id_model.dart';
import 'package:foodfestadeliverymen/data/models/get_order_history_filter_model.dart';
import 'package:foodfestadeliverymen/data/models/get_profile_model.dart';
import 'package:foodfestadeliverymen/data/models/get_review_model.dart';
import 'package:foodfestadeliverymen/data/models/request_order_model.dart';
import 'package:foodfestadeliverymen/res/color_print.dart';
import 'package:foodfestadeliverymen/res/ui_utils.dart';
import 'package:foodfestadeliverymen/route/app_routes.dart';
import 'package:foodfestadeliverymen/utils/utils.dart';
import 'package:get/get.dart';

import '../data/handler/api_url.dart';

class DesktopRepository {
  Future<dynamic> getProfileApiCall({RxBool? isLoader}) async {
    final con = Get.find<ProfileController>();

    try {
      isLoader?.value = true;
      await APIFunction().getApiCall(apiName: ApiUrls.getProfileUrl).then(
        (response) async {
          printData(key: "get profile  response", value: response);
          if (!isValEmpty(response) && response["status"] == true) {
            GetProfileModel data = GetProfileModel.fromJson(response);

            con.getDataMap = data;
            con.userApiImageFile.value = con.getDataMap?.data.image ?? "";

            con.userName.value =
                "${con.getDataMap?.data.firstName} ${con.getDataMap?.data.lastName}";
            con.phoneNoName.value = con.getDataMap?.data.phone ?? "";
            con.firstName.value = con.getDataMap?.data.firstName ?? "";
            con.lastName.value = con.getDataMap?.data.lastName ?? "";
            con.email.value = con.getDataMap?.data.email ?? "";
            log("${con.getDataMap}");
            await getReviewApiCall(isLoader: isLoader);
          }
          return response;
        },
      );
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 404) {
        printWarning(e.response?.statusCode);
        printError(type: this, errText: "$e");
      }
      rethrow;
    } finally {
      isLoader?.value = false;
    }
  }

  Future<dynamic> getReviewApiCall({RxBool? isLoader}) async {
    final con = Get.find<ProfileController>();

    try {
      isLoader?.value = true;
      await APIFunction()
          .getApiCall(
              apiName: "${ApiUrls.deliverymenUrl}${ApiUrls.getReviewUrl}")
          .then(
        (response) async {
          printData(key: "get review  response", value: response);
          if (!isValEmpty(response) && response["status"] == true) {
            GetReviewModel data = GetReviewModel.fromJson(response);

            con.getReviewData.value = data.data ?? GetReviewData();
          }
          return response;
        },
      );
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 404) {
        printWarning(e.response?.statusCode);
        printError(type: this, errText: "$e");
      }
      rethrow;
    } finally {
      isLoader?.value = false;
    }
  }

  Future<dynamic> editProfileApiCall({RxBool? isLoader}) async {
    final editAccountController = Get.find<EditAccountController>();
    try {
      isLoader?.value = true;
      dio.FormData formData = dio.FormData.fromMap({
        "first_name": editAccountController.firstNameCon.text.trim(),
        "last_name": editAccountController.lastNameCon.text.trim(),
        "email": editAccountController.emailCon.text.trim(),
        "phone": editAccountController.mobileNumberCon.text.trim(),
        "image": await dio.MultipartFile.fromFile(
          editAccountController.apiImage!.path,
          filename: editAccountController.imagePath.value.split("/").last,
        ),
      });
      await APIFunction()
          .postApiCall(apiName: ApiUrls.updateUserProfileUrl, params: formData)
          .then(
        (response) async {
          printData(key: "update profile response", value: response);
          if (!isValEmpty(response) && response["status"] == true) {
            if (!isValEmpty(response["message"])) {
              toast(response["message"].toString());
              Get.back();
              await getProfileApiCall();
              Get.offNamed(AppRoutes.bottomScreen);
            }
          }
          return response;
        },
      );
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 404) {
        printWarning(e.response?.statusCode);
        printError(type: this, errText: "$e");
      }
    } finally {
      isLoader?.value = false;
    }
  }

//complaint order
  Future<dynamic> complaintOrderApiCall(
      {RxBool? isLoader, dynamic params}) async {
    try {
      isLoader?.value = true;

      await APIFunction()
          .postApiCall(apiName: ApiUrls.orderComplaintUrl, params: params)
          .then(
        (response) async {
          printData(key: "complaint order response", value: response);
          if (!isValEmpty(response) && response["status"] == true) {
            if (!isValEmpty(response["message"])) {
              Get.back();
              toast(response["message"].toString());
              Get.offNamed(AppRoutes.bottomScreen);
            }
          }
          return response;
        },
      );
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 404) {
        printWarning(e.response?.statusCode);
        printError(type: this, errText: "$e");
      }
    } finally {
      isLoader?.value = false;
    }
  }

  ///get current order list api
  Future<dynamic> getCurrentOrderListAPI({required bool isInitial}) async {
    final HomeController con = Get.find<HomeController>();
    try {
      if (await getConnectivityResult()) {
        con.currentOrderListData.clear();
        if (isInitial) {
          con.page.value = 2;
          con.isLoading.value = true;
          con.nextPageStop.value = true;
        }

        if (con.nextPageStop.isTrue) {
          await APIFunction()
              .getApiCall(
                  apiName:
                      "${ApiUrls.deliverymenUrl}${ApiUrls.currentOrderUrl}?per_page=${con.page.value}")
              .then(
            (response) async {
              printData(key: "current order response", value: response);
              CurrentOrderModel currentOrderModel =
                  CurrentOrderModel.fromJson(response);

              currentOrderModel.data?.data?.forEach((element) {
                // log("-------------${element.restaurant}");
                // log("-------------${element.restaurant != null}");
                if (element != null) {
                  con.currentOrderListData.add(element);
                }
              });

              con.currentOrderListData.refresh();
              con.page.value++;
              printData(
                  key: "current order length",
                  value: con.currentOrderListData.length);
              if (con.currentOrderListData.length ==
                  currentOrderModel.data?.total) {
                con.nextPageStop.value = false;
              }
              await getCurrentOrderStatusListApiCall(isLoader: con.isLoading);
              return response;
            },
          );
        }
      }
    } catch (e) {
      printError(type: this, errText: "$e");
    } finally {
      con.isLoading.value = false;
      con.paginationLoading.value = false;
    }
  }

  ///get request order list api
  Future<dynamic> getRequestOrderListAPI({required bool isInitial}) async {
    final HomeController con = Get.find<HomeController>();
    try {
      if (await getConnectivityResult()) {
        if (isInitial) {
          con.requestOrderListData.clear();
          con.page.value = 2;
          con.isLoading.value = true;
          con.nextPageStop.value = true;
        }

        if (con.nextPageStop.isTrue) {
          await APIFunction()
              .getApiCall(
                  apiName:
                      "${ApiUrls.deliverymenUrl}${ApiUrls.requestOrderUrl}?per_page=${con.page.value}")
              .then(
            (response) async {
              printData(key: "request order response", value: response);
              RequestOrderModel requestOrderModel =
                  RequestOrderModel.fromJson(response);

              requestOrderModel.data?.data?.forEach((element) {
                // log("-------------${element.restaurant}");
                // log("-------------${element.restaurant != null}");
                if (element != null) {
                  con.requestOrderListData.add(element);
                }
              });

              con.requestOrderListData.refresh();
              con.page.value++;
              printData(
                  key: "request order length",
                  value: con.requestOrderListData.length);
              if (con.requestOrderListData.length ==
                  requestOrderModel.data?.total) {
                con.nextPageStop.value = false;
              }
              return response;
            },
          );
        }
      }
    } catch (e) {
      printError(type: this, errText: "$e");
    } finally {
      con.isLoading.value = false;
      con.paginationLoading.value = false;
    }
  }

  //get order by id api call
  Future<dynamic> getOrderByIdApiCall(
      {RxBool? isLoader,
      required String orderId,
      required Rx<GetOrderByIdModel> orderData}) async {
    // final con = Get.find<OrderDetailController>();

    try {
      await APIFunction()
          .getApiCall(apiName: "${ApiUrls.getOrderByIdUrl}/$orderId")
          .then(
        (response) async {
          printData(key: "order track response", value: response);
          if (!isValEmpty(response) && response["status"] == true) {
            GetOrderByIdModel data = GetOrderByIdModel.fromJson(response);

            orderData.value = data;
          }
          return response;
        },
      );
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 404) {
        printWarning(e.response?.statusCode);
        printError(type: this, errText: "$e");
      }
      rethrow;
    } finally {
      isLoader?.value = false;
    }
  }

//Accept order api call
  Future<dynamic> acceptOrderApiCall({RxBool? isLoader, dynamic params}) async {
    try {
      isLoader?.value = true;

      await APIFunction()
          .postApiCall(
              apiName: '${ApiUrls.deliverymenUrl}${ApiUrls.acceptOrderUrl}',
              params: params)
          .then(
        (response) async {
          printData(key: "accept order response", value: response);
          if (!isValEmpty(response) && response["status"] == true) {
            if (!isValEmpty(response["message"])) {
              toast(response["message"].toString());
              getCurrentOrderListAPI(isInitial: false);
              getRequestOrderListAPI(isInitial: false);
              // getPastOrderListAPI(isInitial: true);

              // Get.offNamed(AppRoutes.bottomScreen);
            }
          }
          return response;
        },
      );
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 404) {
        printWarning(e.response?.statusCode);
        printError(type: this, errText: "$e");
      }
    } finally {
      isLoader?.value = false;
    }
  }

  //get current order status list api call
  Future<dynamic> getCurrentOrderStatusListApiCall({RxBool? isLoader}) async {
    final con = Get.find<HomeController>();

    try {
      await APIFunction()
          .getApiCall(
              apiName:
                  "${ApiUrls.deliverymenUrl}${ApiUrls.getCurrentOrderStatusListUrl}")
          .then(
        (response) async {
          con.getCurrentOrderStatusListData.clear();
          printData(
              key: "get current order status list response", value: response);
          if (!isValEmpty(response) && response["status"] == true) {
            CurrentOrderStatusModel getCurrentStatusData =
                CurrentOrderStatusModel.fromJson(response);

            con.getCurrentOrderStatusListData.add(
                CurrentOrderStatusDatum(statusName: 'Select order status'));
            con.getCurrentOrderStatusListData
                .addAll(getCurrentStatusData.data!);
            con.orderstatusDropDownValue.value =
                con.getCurrentOrderStatusListData[0];
            con.getCurrentOrderStatusListData.refresh();
          }
          return response;
        },
      );
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 404) {
        printWarning(e.response?.statusCode);
        printError(type: this, errText: "$e");
      }
      rethrow;
    } finally {
      isLoader?.value = false;
    }
  }

//update order status  api call
  Future<dynamic> updateOrderStatusApiCall(
      {RxBool? isLoader, dynamic params}) async {
    try {
      isLoader?.value = true;

      await APIFunction()
          .postApiCall(
              apiName:
                  '${ApiUrls.deliverymenUrl}${ApiUrls.updateCurrentOrderStatusUrl}',
              params: params)
          .then(
        (response) async {
          printData(key: "update order status response", value: response);
          if (!isValEmpty(response) && response["status"] == true) {
            if (!isValEmpty(response["message"])) {
              toast(response["message"].toString());
            }
          }
          return response;
        },
      );
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 404) {
        printWarning(e.response?.statusCode);
        printError(type: this, errText: "$e");
      }
    } finally {
      isLoader?.value = false;
    }
  }

//get order history filer api call
  Future<dynamic> getOrderHistoryFilterApiCall(
      {required bool isInitial,
      RxBool? isLoader,
      String? search,
      required String fromdDate,
      required String toDate}) async {
    final OrderManagementController con = Get.find<OrderManagementController>();
    try {
      if (await getConnectivityResult()) {
        con.getOrderHistoryFilterList.clear();
        if (isInitial) {
          con.page.value = 3;
          con.isLoader.value = true;
          con.nextPageStop.value = true;
        }

        dio.FormData formData = dio.FormData.fromMap({
          "search": search ?? "",
          "from_date": fromdDate,
          "to_date": toDate,
        });
        if (con.nextPageStop.isTrue) {
          await APIFunction()
              .postApiCall(
                  apiName:
                      "${ApiUrls.getOrderHistoryFilterUrl}?per_page=${con.page.value}",
                  params: formData)
              .then(
            (response) async {
              printData(
                  key: "get order history filter response", value: response);
              if (!isValEmpty(response) && response["status"] == true) {
                GetOrderHistoryFilterModel getOrderHistoryFiltermodel =
                    GetOrderHistoryFilterModel.fromJson(response);

                getOrderHistoryFiltermodel.data?.data?.forEach((element) {
                  // log("-------------${element.restaurant}");
                  // log("-------------${element.restaurant != null}");
                  if (element != null) {
                    con.getOrderHistoryFilterList.add(element);
                  }
                });

                con.getOrderHistoryFilterList.refresh();
                con.page.value++;
                printData(
                    key: " order history filter length",
                    value: con.getOrderHistoryFilterList.length);
                if (con.getOrderHistoryFilterList.length ==
                    getOrderHistoryFiltermodel.data?.total) {
                  con.nextPageStop.value = false;
                }
              }
              return response;
            },
          );
        }
      }
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 404) {
        printWarning(e.response?.statusCode);
        printError(type: this, errText: "$e");
      }
    } finally {
      isLoader?.value = false;
    }
  }

  Future<dynamic> getEarningApiCall({RxBool? isLoader}) async {
    final con = Get.find<MyEarningController>();

    try {
      isLoader?.value = true;
      await APIFunction()
          .getApiCall(
              apiName: "${ApiUrls.deliverymenUrl}${ApiUrls.getEarningUrl}")
          .then(
        (response) async {
          printData(key: "get earning  response", value: response);
          if (!isValEmpty(response) && response["status"] == true) {
            GetDeliveryManEarningModel data =
                GetDeliveryManEarningModel.fromJson(response);

            con.myEarningData.value = data;
          }
          return response;
        },
      );
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 404) {
        printWarning(e.response?.statusCode);
        printError(type: this, errText: "$e");
      }
      rethrow;
    } finally {
      isLoader?.value = false;
    }
  }
}
