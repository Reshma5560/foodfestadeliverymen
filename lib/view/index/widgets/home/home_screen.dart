// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodfestadeliverymen/common_widgets/row_module.dart';
import 'package:foodfestadeliverymen/common_widgets/simmer_tile.dart';
import 'package:foodfestadeliverymen/controller/home_controller.dart';
import 'package:foodfestadeliverymen/repositories/desktop_repository.dart';
import 'package:foodfestadeliverymen/res/app_appbar.dart';
import 'package:foodfestadeliverymen/res/app_assets.dart';
import 'package:foodfestadeliverymen/res/app_colors.dart';
import 'package:foodfestadeliverymen/res/app_strings.dart';
import 'package:foodfestadeliverymen/res/app_style.dart';
import 'package:foodfestadeliverymen/res/widgets/empty_element.dart';
import 'package:foodfestadeliverymen/route/app_routes.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController con = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterTop,
        resizeToAvoidBottomInset: true,
        body: Column(children: [
          CommonAppBar(
            title: "Orders",
            onPressed: () {
              Get.back();
            },
          ),
          TabBar(
            physics: const NeverScrollableScrollPhysics(),
            automaticIndicatorColorAdjustment: false,
            controller: con.tabController,
            tabs: con.orderTabList,
            onTap: (value) {
              con.tabIndex.value = value;
              log(con.tabIndex.value.toString());
              if (con.tabIndex.value == 0) {
                DesktopRepository().getCurrentOrderListAPI(isInitial: true);
              } else if (con.tabIndex.value == 1) {
                DesktopRepository().getRequestOrderListAPI(isInitial: true);
              } else if (con.tabIndex.value == 2) {
                DesktopRepository().getPastOrderListAPI(isInitial: true);
              }
            },
          ),
          Expanded(
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: con.tabController,
                children: con.orderTabList.map((e) {
                  return e.text == "Current Order"
                      ? _currentOrderModule()
                      : e.text == "Request Order"
                          ? _requestOrderModule()
                          : _pastOrderModule();
                }).toList()),
          ),
        ]));
  }

  Widget _currentOrderModule() {
    return Obx(() => con.isLoading.value
        ? ListView.builder(
            padding: const EdgeInsets.all(defaultPadding)
                .copyWith(bottom: MediaQuery.of(Get.context!).padding.bottom),
            shrinkWrap: true,
            itemCount: 8,
            itemBuilder: (BuildContext context, index) => const SimmerTile(),
          )
        : con.currentOrderListData.value.isEmpty
            ? EmptyElement(
                imagePath: AppAssets.noData,
                height: Get.height / 1.8,
                imageHeight: Get.width / 2.4,
                imageWidth: Get.width / 2,
                spacing: 0,
                title: AppStrings.recordNotFound,
                subtitle: "",
              )
            : ListView.builder(
                itemCount: con.currentOrderListData.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = con.currentOrderListData[index];
                  return InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.orderDetailScreen,
                          arguments: {'orderId': item.id});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: AppStyle.boxShadow(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.invoiceNumber.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp),
                          ),
                          Divider(
                            color: AppColors.greyBorderColor,
                          ),
                          RowModule(
                            title: "Receiver Name",
                            subTitle:
                                ": ${item.user?.firstName} ${item.user?.lastName}",
                          ),
                          RowModule(
                            title: "Receiver Contact No.",
                            subTitle: ": ${item.user?.phone}",
                          ),
                          RowModule(
                            title: "Order Status",
                            subTitle: ": ${item.orderStatus?.statusName}",
                            customTextStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     ElevatedButton(
                          //       style: ButtonStyle(
                          //         shape: MaterialStateProperty.all<
                          //             RoundedRectangleBorder>(
                          //           RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(5.0),
                          //           ),
                          //         ),
                          //       ),
                          //       onPressed: () {
                          //         var params = {
                          //           "order_id": item.id,
                          //           "status":
                          //               "2" // 1-pending BYDEFAULT | 2-ACCEPT | 3 -REJECT
                          //         };
                          //         DesktopRepository().acceptOrderApiCall(
                          //             isLoader: con.isLoading, params: params);
                          //       },
                          //       child: const Text("Accept"),
                          //     ),
                          //     SizedBox(
                          //       width: 5.w,
                          //     ),
                          //     ElevatedButton(
                          //       style: ButtonStyle(
                          //         shape: MaterialStateProperty.all<
                          //             RoundedRectangleBorder>(
                          //           RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(5.0),
                          //           ),
                          //         ),
                          //       ),
                          //       onPressed: () {
                          //         var params = {
                          //           "order_id": item.id,
                          //           "status":
                          //               "3" // 1-pending BYDEFAULT | 2-ACCEPT | 3 -REJECT
                          //         };
                          //         DesktopRepository().acceptOrderApiCall(
                          //             isLoader: con.isLoading, params: params);
                          //       },
                          //       child: const Text("Reject"),
                          //     ),
                          //   ],
                          // )
                          // Text(item.orderStatus?.statusName ?? ""),
                          // Text(item.orderType ?? ""),
                          // Text(item.orderAmount.toString()),
                          // Text(item.orderDetail![index].quantity.toString()),
                          // Text(item.paymentStatus?.statusName ?? ""),
                          // Text(DateFormat("DD MM yyyy, HH:mma")
                          //     .format(item.createdAt!))
                        ],
                      ).paddingSymmetric(vertical: 10, horizontal: 10),
                    ),
                  );
                },
              ).paddingSymmetric(horizontal: 10.w, vertical: 5));
  }

  Widget _requestOrderModule() {
    return Obx(() => con.isLoading.value
        ? ListView.builder(
            padding: const EdgeInsets.all(defaultPadding)
                .copyWith(bottom: MediaQuery.of(Get.context!).padding.bottom),
            shrinkWrap: true,
            itemCount: 8,
            itemBuilder: (BuildContext context, index) => const SimmerTile(),
          )
        : con.requestOrderListData.isEmpty
            ? EmptyElement(
                imagePath: AppAssets.noData,
                height: Get.height / 1.8,
                imageHeight: Get.width / 2.4,
                imageWidth: Get.width / 2,
                spacing: 0,
                title: AppStrings.recordNotFound,
                subtitle: "",
              )
            : ListView.builder(
                itemCount: con.requestOrderListData.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = con.requestOrderListData[index];

                  RxBool isAccept = false.obs;
                  return InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.orderDetailScreen, arguments: {
                        'orderId': item.id,
                        'isAccept': isAccept.value
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: AppStyle.boxShadow(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.invoiceNumber.toString(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp),
                          ),
                          Divider(
                            color: AppColors.greyBorderColor,
                          ),
                          RowModule(
                            title: "Receiver Name",
                            subTitle:
                                ": ${item.user?.firstName} ${item.user?.lastName}",
                          ),
                          RowModule(
                            title: "Receiver Contact No.",
                            subTitle: ": ${item.user?.phone}",
                          ),
                          RowModule(
                            title: "Order Status",
                            subTitle: ": ${item.orderStatus?.statusName}",
                            customTextStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  var params = {
                                    "order_id": item.id,
                                    "status":
                                        "2" // 1-pending BYDEFAULT | 2-ACCEPT | 3 -REJECT
                                  };
                                  DesktopRepository()
                                      .acceptOrderApiCall(
                                          isLoader: con.isLoading,
                                          params: params)
                                      .then((value) => isAccept.value = true);
                                },
                                child: const Text("Accept"),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                                onPressed: isAccept.value == true
                                    ? null
                                    : () {
                                        var params = {
                                          "order_id": item.id,
                                          "status":
                                              "3" // 1-pending BYDEFAULT | 2-ACCEPT | 3 -REJECT
                                        };
                                        DesktopRepository().acceptOrderApiCall(
                                            isLoader: con.isLoading,
                                            params: params);
                                      },
                                child: const Text("Reject"),
                              ),
                            ],
                          )
                        ],
                      ).paddingSymmetric(vertical: 10, horizontal: 10),
                    ),
                  );
                },
              ).paddingSymmetric(horizontal: 10.w, vertical: 5));
  }

  Widget _pastOrderModule() {
    return Obx(() => con.isLoading.value
        ? ListView.builder(
            padding: const EdgeInsets.all(defaultPadding)
                .copyWith(bottom: MediaQuery.of(Get.context!).padding.bottom),
            shrinkWrap: true,
            itemCount: 8,
            itemBuilder: (BuildContext context, index) => const SimmerTile(),
          )
        : con.pastOrderListData.isEmpty
            ? EmptyElement(
                imagePath: AppAssets.noData,
                height: Get.height / 1.8,
                imageHeight: Get.width / 2.4,
                imageWidth: Get.width / 2,
                spacing: 0,
                title: AppStrings.recordNotFound,
                subtitle: "",
              )
            : ListView.builder(
                itemCount: con.pastOrderListData.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = con.pastOrderListData[index];
                  return Container(
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: AppStyle.boxShadow(),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.invoiceNumber.toString(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp),
                        ),
                        Divider(
                          color: AppColors.greyBorderColor,
                        ),
                        RowModule(
                          title: "Receiver Name",
                          subTitle:
                              ": ${item.user?.firstName} ${item.user?.lastName}",
                        ),
                        RowModule(
                          title: "Receiver Contact No.",
                          subTitle: ": ${item.user?.phone}",
                        ),
                        RowModule(
                          title: "Order Status",
                          subTitle: ": ${item.orderStatus?.statusName}",
                          customTextStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     ElevatedButton(
                        //       style: ButtonStyle(
                        //         shape: MaterialStateProperty.all<
                        //             RoundedRectangleBorder>(
                        //           RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(5.0),
                        //           ),
                        //         ),
                        //       ),
                        //       onPressed: () {},
                        //       child: const Text("Accept"),
                        //     ),
                        //     SizedBox(
                        //       width: 5.w,
                        //     ),
                        //     ElevatedButton(
                        //       style: ButtonStyle(
                        //         shape: MaterialStateProperty.all<
                        //             RoundedRectangleBorder>(
                        //           RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(5.0),
                        //           ),
                        //         ),
                        //       ),
                        //       onPressed: () {},
                        //       child: const Text("Reject"),
                        //     ),
                        //   ],
                        // )
                      ],
                    ).paddingSymmetric(vertical: 10, horizontal: 10),
                  );
                },
              ).paddingSymmetric(horizontal: 10.w, vertical: 5));
  }
}
