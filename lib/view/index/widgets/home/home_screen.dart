// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodfestadeliverymen/common_widgets/simmer_tile.dart';
import 'package:foodfestadeliverymen/controller/home_controller.dart';
import 'package:foodfestadeliverymen/data/models/current_order_model.dart';
import 'package:foodfestadeliverymen/data/models/current_order_status_model.dart';
import 'package:foodfestadeliverymen/packages/cached_network_image/cached_network_image.dart';
import 'package:foodfestadeliverymen/repositories/desktop_repository.dart';
import 'package:foodfestadeliverymen/res/app_assets.dart';
import 'package:foodfestadeliverymen/res/app_button.dart';
import 'package:foodfestadeliverymen/res/app_colors.dart';
import 'package:foodfestadeliverymen/res/app_strings.dart';
import 'package:foodfestadeliverymen/res/app_style.dart';
import 'package:foodfestadeliverymen/res/widgets/empty_element.dart';
import 'package:foodfestadeliverymen/route/app_routes.dart';
import 'package:foodfestadeliverymen/utils/local_storage.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Image.asset("assets/images/bg_home_image.png", width: Get.width, fit: BoxFit.fill),
          Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Center(
                    child: Obx(
                      () => LocalStorage.userImage.isNotEmpty
                          ? MFNetworkImage(
                              height: 40,
                              width: 40,
                              imageUrl: LocalStorage.userImage.value,
                              fit: BoxFit.cover,
                              shape: BoxShape.circle,
                            )
                          : Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person_2_outlined,
                                color: AppColors.white,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: AppColors.greyFontColor),
                      ),
                      Obx(
                        () => Text(
                          "${LocalStorage.firstName.value} ${LocalStorage.lastName.value}",
                          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: AppColors.black),
                        ),
                      )
                    ],
                  )
                ],
              ).paddingSymmetric(horizontal: 10.w, vertical: 20.h),
              Obx(() => Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            con.tabIndex.value = 0;
                            log(con.tabIndex.value.toString());
                            DesktopRepository().getCurrentOrderListAPI(isInitial: true);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 7.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: Theme.of(context).primaryColor),
                                color: con.tabIndex.value == 0 ? Theme.of(context).primaryColor : AppColors.white),
                            child: Text(
                              "Current Order",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: con.tabIndex.value == 0 ? AppColors.white : Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            con.tabIndex.value = 1;
                            log(con.tabIndex.value.toString());
                            DesktopRepository().getRequestOrderListAPI(isInitial: true);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 7.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: Theme.of(context).primaryColor),
                                color: con.tabIndex.value == 1 ? Theme.of(context).primaryColor : AppColors.white),
                            child: Text(
                              "Request Order",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: con.tabIndex.value == 1 ? AppColors.white : Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 10.w)),
              Obx(
                () => Expanded(
                  child: SizedBox(
                    height: Get.height,
                    width: Get.width,
                    // color: AppColors.white,
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: con.tabController,
                      children: con.orderTabList.map(
                        (e) {
                          return con.tabIndex.value == 0 ? _currentOrderModule() : _requestOrderModule();
                          // : _pastOrderModule();
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _currentOrderModule() {
    return Obx(
      () => con.isLoading.value
          ? ListView.builder(
              // padding: const EdgeInsets.all(defaultPadding)
              //     .copyWith(bottom: MediaQuery.of(Get.context!).padding.bottom),

              // padding: EdgeInsets.symmetric(vertical: 5.h),
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (BuildContext context, index) => const SimmerTile(),
            )
          : con.currentOrderListData.value.isEmpty
              ? RefreshIndicator(
                  onRefresh: () async {
                    DesktopRepository().getCurrentOrderListAPI(isInitial: true);
                  },
                  child: ListView(
                    children: [
                      EmptyElement(
                        imagePath: AppAssets.noData,
                        height: Get.height / 1.8,
                        imageHeight: Get.width / 2.4,
                        imageWidth: Get.width / 2,
                        spacing: 0,
                        title: AppStrings.recordNotFound,
                        subtitle: "",
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    DesktopRepository().getCurrentOrderListAPI(isInitial: true);
                  },
                  child: ListView.builder(
                    controller: con.currentOrderScrollController,
                    itemCount: con.currentOrderListData.length,
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    itemBuilder: (BuildContext context, int index) {
                      var item = con.currentOrderListData[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.orderDetailScreen, arguments: {'orderId': item.id});
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 3.h),
                          decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                              color: AppColors.white,
                              boxShadow: AppStyle.boxShadow(),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "ORDER# ",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w600, fontSize: 14.sp),
                                  ),
                                  Text(
                                    item.invoiceNumber.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600, fontSize: 14.sp),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Status: ",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w600, fontSize: 14.sp),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                                    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                                    child: Text(
                                      item.orderStatus?.statusName ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w500, fontSize: 11.sp),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Theme.of(context).primaryColor,
                              ),
                              Text(
                                "Customer Details",
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                "Name : ${item.user?.firstName} ${item.user?.lastName}",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Text(
                                "Mobile No. : ${item.user?.phone}",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Text(
                                "Address : ${item.deliveryAddress?.address}, ${item.deliveryAddress?.city?.cityName}, ${item.deliveryAddress?.state?.stateName}",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text(
                                "Restaurant Details",
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                "Name : ${item.restaurant?.restaurantName}",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Text(
                                "Mobile No. : ${item.restaurant?.phone}",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Text(
                                "Addres : ${item.restaurant?.address}, ",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              SizedBox(
                                height: 30,
                                child: Row(
                                  children: [Expanded(flex: 2, child: _orderStatusDropDownModule(item)), const Expanded(flex: 1, child: SizedBox())],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ).paddingSymmetric(vertical: 10, horizontal: 10),
                        ),
                      );
                    },
                  ).paddingSymmetric(horizontal: 10.w, vertical: 5.h),
                ),
    );
  }

  Widget _requestOrderModule() {
    return Obx(() => con.isLoading.value
        ? ListView.builder(
            controller: con.requestOrderScrollController,
            padding: const EdgeInsets.all(defaultPadding).copyWith(bottom: MediaQuery.of(Get.context!).padding.bottom),
            shrinkWrap: true,
            itemCount: 8,
            itemBuilder: (BuildContext context, index) => const SimmerTile(),
          )
        : con.requestOrderListData.isEmpty
            ? RefreshIndicator(
                onRefresh: () async {
                  DesktopRepository().getRequestOrderListAPI(isInitial: true);
                },
                child: ListView(
                  children: [
                    EmptyElement(
                      imagePath: AppAssets.noData,
                      height: Get.height / 1.8,
                      imageHeight: Get.width / 2.4,
                      imageWidth: Get.width / 2,
                      spacing: 0,
                      title: AppStrings.recordNotFound,
                      subtitle: "",
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  DesktopRepository().getRequestOrderListAPI(isInitial: true);
                },
                child: ListView.builder(
                  controller: con.requestOrderScrollController,
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  itemCount: con.requestOrderListData.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = con.requestOrderListData[index];

                    RxBool isAccept = false.obs;
                    return InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.orderDetailScreen, arguments: {'orderId': item.id, 'isAccept': isAccept.value});
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 3.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                            color: AppColors.white,
                            boxShadow: AppStyle.boxShadow(),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "ORDER# ",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w600, fontSize: 14.sp),
                                ),
                                Text(
                                  item.invoiceNumber.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600, fontSize: 14.sp),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Status: ",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w600, fontSize: 14.sp),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                                  decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                                  child: Text(
                                    item.orderStatus?.statusName ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w500, fontSize: 11.sp),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              "Customer Details",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              "Name : ${item.user?.firstName} ${item.user?.lastName}",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Text(
                              "Mobile No. : ${item.user?.phone}",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Text(
                              "Address : ${item.deliveryAddress?.address}, ${item.deliveryAddress?.city?.cityName}, ${item.deliveryAddress?.state?.stateName}",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Text(
                              "Restaurant Details",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              "Name : ${item.restaurant?.restaurantName}",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            Text(
                              "Mobile No. : ${item.restaurant?.phone}",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            Text(
                              "Addres : ${item.restaurant?.address}, ",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Expanded(child: SizedBox()),
                                Expanded(
                                  child: AppButton(
                                    height: 25.h,
                                    borderRadius: BorderRadius.circular(5.0),
                                    onPressed: () {
                                      var params = {
                                        "order_id": item.id,
                                        "status": "2" // 1-pending BYDEFAULT | 2-ACCEPT | 3 -REJECT
                                      };
                                      DesktopRepository()
                                          .acceptOrderApiCall(isLoader: con.isLoading, params: params)
                                          .then((value) => con.isAccept.value = true);
                                    },
                                    child: Text(
                                      "Accept",
                                      style: TextStyle(color: AppColors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: AppButton(
                                    height: 25.h,
                                    borderRadius: BorderRadius.circular(5.0),
                                    onPressed:
                                        //  con.isAccept.value == true
                                        //     ? null
                                        // :
                                        () {
                                      var params = {
                                        "order_id": item.id,
                                        "status": "3" // 1-pending BYDEFAULT | 2-ACCEPT | 3 -REJECT
                                      };
                                      DesktopRepository().acceptOrderApiCall(isLoader: con.isLoading, params: params);
                                    },
                                    child: Text(
                                      "Reject",
                                      style: TextStyle(color: AppColors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ).paddingSymmetric(vertical: 10, horizontal: 10),
                      ),
                    );
                  },
                ).paddingSymmetric(horizontal: 10.w, vertical: 5.h),
              ));
  }

  Widget _orderStatusDropDownModule(CurrentOrderDatum item) {
    return Obx(
      () => DropdownButtonFormField<CurrentOrderStatusDatum>(
        decoration: InputDecoration(
          fillColor: Theme.of(Get.context!).primaryColor,
          //AppColors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColors.grey),
          ),
        ),
        hint: const Text("Select Order status"),
        value: con.orderstatusDropDownValue.value,
        icon: Icon(
          Icons.arrow_drop_down,
          color: AppColors.white,
        ),
        items: con.getCurrentOrderStatusListData.map<DropdownMenuItem<CurrentOrderStatusDatum>>((value) {
          // log("value.name ${value.countryName}");
          return DropdownMenuItem<CurrentOrderStatusDatum>(
            value: value,
            child: Text(
              value.statusName ?? "",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 11.sp,
              ),
            ),
          );
        }).toList(),
        isDense: true,
        isExpanded: false,
        dropdownColor: Theme.of(Get.context!).primaryColor,
        // underline: Container(height: 1, color: AppColors.blackColor),
        // borderRadius: const BorderRadius.all(Radius.circular(15)),
        style: TextStyle(
          color: AppColors.grey,
          fontSize: 11.sp,
        ),
        onChanged: (value) async {
          con.isLoading(true);
          con.orderstatusDropDownValue.value = value ?? CurrentOrderStatusDatum();
          // con.stateList.clear();
          // con.stateList.add(StateList(stateName: 'Select state'));

          DesktopRepository().updateOrderStatusApiCall(isLoader: con.isLoading, params: {"order_id": item.id, "order_status_id": value?.id ?? ""});
          con.isLoading(false);
        },
      ),
    );
  }
// Widget _orderStatusDropDownModule(CurrentOrderDatum item) {
//   return Obx(
//     () => DropdownButtonFormField<CurrentOrderStatusDatum>(
//       // menuMaxHeight: 400,
//       dropdownColor: Theme.of(Get.context!).primaryColor,
//       decoration: InputDecoration(
//         fillColor: Theme.of(Get.context!).primaryColor,
//         //AppColors.white,
//         filled: true,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//           borderSide: BorderSide(color: AppColors.grey),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//           borderSide: BorderSide(color: AppColors.grey),
//         ),
//       ),
//       hint: const Text("Select Order status"),
//       value: con.orderstatusDropDownValue.value,
//       icon: Icon(
//         Icons.arrow_drop_down,
//         color: AppColors.white,
//       ),
//       items: con.getCurrentOrderStatusListData.map<DropdownMenuItem<CurrentOrderStatusDatum>>((value) {
//         // log("value.name ${value.countryName}");
//         return DropdownMenuItem<CurrentOrderStatusDatum>(
//           value: value,
//           child: Text(
//             "${value.statusName}",
//             style: TextStyle(
//               color: AppColors.white,
//               fontSize: 11.sp,
//             ),
//           ),
//         );
//       }).toList(),
//       isDense: true,
//       isExpanded: false,
//       // underline: Container(height: 1, color: AppColors.blackColor),
//       // borderRadius: const BorderRadius.all(Radius.circular(15)),
//       style: TextStyle(
//         color: AppColors.grey,
//         fontSize: 11.sp,
//       ),
//       onChanged: (value) async {
//         con.isLoading(true);
//         con.orderstatusDropDownValue.value = value ?? CurrentOrderStatusDatum();
//
//         DesktopRepository().updateOrderStatusApiCall(isLoader: con.isLoading, params: {"order_id": item.id, "status_id": value?.id});
//         con.isLoading(false);
//       },
//     ),
//   );
// }
}
