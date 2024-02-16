import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodfestadeliverymen/controller/order_management_controller.dart';
import 'package:foodfestadeliverymen/repositories/desktop_repository.dart';
import 'package:foodfestadeliverymen/res/app_appbar.dart';
import 'package:foodfestadeliverymen/res/app_button.dart';
import 'package:foodfestadeliverymen/res/app_colors.dart';
import 'package:foodfestadeliverymen/res/app_loader.dart';
import 'package:foodfestadeliverymen/res/app_style.dart';
import 'package:foodfestadeliverymen/res/app_text_field.dart';
import 'package:foodfestadeliverymen/route/app_routes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderManagementScreen extends StatelessWidget {
  OrderManagementScreen({super.key});

  final OrderManagementController con = Get.put(OrderManagementController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeOutCubic,
            tween: Tween(begin: 20.0, end: 1.0),
            builder: (context, value, child) {
              return AnimatedOpacity(
                  opacity: value == 20 ? 0 : 1,
                  duration: const Duration(milliseconds: 700),
                  child: Column(children: [
                    CommonAppBar(
                      title: "Order Management",
                      isLeadingShow: false,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    Expanded(
                        child: Obx(() => con.isLoader.isTrue
                            ? const AppLoader()
                            : ListView.builder(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                itemCount: con.getOrderHistoryFilterList.length,
                                // padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, int index) {
                                  var item =
                                      con.getOrderHistoryFilterList[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                          AppRoutes.orderManagementDetailScreen,
                                          arguments: {'orderId': item.id});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 2),
                                          color: AppColors.white,
                                          boxShadow: AppStyle.boxShadow(),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Order No.# ",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 13.sp),
                                                    ),
                                                    Text(
                                                      item.invoiceNumber ?? "",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 13.sp),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        AppRoutes
                                                            .orderManagementDetailScreen,
                                                        arguments: {
                                                          'orderId': item.id
                                                        });
                                                  },
                                                  child: Icon(
                                                    Icons.arrow_forward,
                                                    size: 18.sp,
                                                  ))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Order ",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13.sp),
                                              ),
                                              Text(
                                                "Status: ",
                                                style: TextStyle(
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13.sp),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                child: Text(
                                                  item.orderStatus
                                                          ?.statusName ??
                                                      "",
                                                  style: TextStyle(
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 8.sp),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Payment ",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13.sp),
                                              ),
                                              Text(
                                                "Status: ",
                                                style: TextStyle(
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13.sp),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                child: Text(
                                                  item.paymentStatus
                                                          ?.statusName ??
                                                      "",
                                                  style: TextStyle(
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 8.sp),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Divider(
                                            color: AppColors.greyBorderColor,
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            "Date : ${DateFormat("DD MMM,yyyy").format(item.createdAt!)}",
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            "Restaurant Name : ${item.restaurant?.restaurantName}",
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            "Customer Name : ${item.user?.firstName} ${item.user?.lastName}",
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            "Customer Name : ${item.user?.firstName} ${item.user?.lastName}",
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            "Amount : ${item.orderAmount}",
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                              onTap: () {
                                                _deliveryManComplaintdialog(
                                                    item.id);
                                              },
                                              child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor)),
                                                  child: Text(
                                                    "Compaint",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  )),
                                            ),
                                          )
                                        ],
                                      ).paddingSymmetric(
                                          vertical: 10.h, horizontal: 10.w),
                                    ).paddingSymmetric(
                                        vertical: 3.h, horizontal: 10.w),
                                  );
                                },
                              )))
                  ]));
            }));
  }

  _deliveryManComplaintdialog(String? id) {
    return Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(Get.context!).colorScheme.background,
                border: Border.all(
                    width: 3, color: Theme.of(Get.context!).primaryColor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  color: Theme.of(Get.context!).colorScheme.background,
                  child: Column(children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "DeliveryMan Complaint",
                          style: TextStyle(
                            // fontFamily: FontFamilyText.sFProDisplayRegular,
                            color: Theme.of(Get.context!).primaryColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(Get.context!).primaryColor),
                            child: Icon(
                              Icons.close,
                              color: AppColors.white,
                              size: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    AppTextField(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide(color: AppColors.white)),
                      controller: con.complaintMessageCon,
                      errorMessage: con.complaintMessageError.value,
                      showError: con.complaintMessageValidation.value,
                      hintText: "Enter your complaint here",
                      hintStyle: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.hintColor),
                      onChanged: (value) {
                        con.complaintMessageValidation.value = false;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AppButton(
                        height: 30.h,
                        borderRadius: BorderRadius.circular(10),
                        onPressed: () async {
                          //complaint message
                          if (con.complaintMessageCon.value.text.isEmpty) {
                            con.complaintMessageError.value =
                                "Please enter complaint message";
                            con.complaintMessageValidation.value = false;
                            FocusScope.of(Get.context!).unfocus();
                          } else {
                            con.complaintMessageValidation.value = false;
                            con.complaintMessageError.value = "";
                          }

                          if (con.complaintMessageValidation.isFalse) {
                            await DesktopRepository().complaintOrderApiCall(
                                isLoader: con.isLoader,
                                params: {
                                  "complaint": con.complaintMessageCon.text,
                                  "order_id": id
                                  // "9b38d4c7-eacf-42da-b80e-bf4ea84cf335"
                                });
                          }
                        },
                        child: Text(
                          "Update Me!",
                          style: TextStyle(
                              color: AppColors.white, fontSize: 14.sp),
                        )),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
