// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodfestadeliverymen/common_widgets/simmer_tile.dart';
import 'package:foodfestadeliverymen/controller/order_management_detail_controller.dart';
import 'package:foodfestadeliverymen/res/app_appbar.dart';
import 'package:foodfestadeliverymen/res/app_colors.dart';
import 'package:foodfestadeliverymen/res/app_style.dart';
import 'package:get/get.dart';

class OrderManagementDetailScreen extends StatelessWidget {
  OrderManagementDetailScreen({super.key});
  final OrderManagementDetailController con =
      Get.put(OrderManagementDetailController());
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
                  child: Stack(
                    children: [
                      Image.asset("assets/images/appbar_bg_img.png"),
                      Column(children: [
                        CommonAppBar(
                          title: "Invoice",
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        Expanded(
                          child: Obx(
                            () => con.isLoading.isTrue
                                ? ListView.builder(
                                    padding: EdgeInsets.zero,
                                    // padding: const EdgeInsets.all(defaultPadding)
                                    //     .copyWith(bottom: MediaQuery.of(Get.context!).padding.bottom),

                                    // padding: EdgeInsets.symmetric(vertical: 5.h),
                                    shrinkWrap: true,
                                    itemCount: 8,
                                    itemBuilder:
                                        (BuildContext context, index) =>
                                            const SimmerTile(),
                                  )
                                : ListView(padding: EdgeInsets.zero, children: [
                                    Container(
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
                                                        "Restaurant: ",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.black,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 13.sp),
                                                      ),
                                                      Text(
                                                        con
                                                                .getOrderDataModel
                                                                .value
                                                                .data
                                                                ?.restaurant
                                                                ?.restaurantName ??
                                                            "",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
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
                                                      var fileName =
                                                          "Food fiesta ${con.getOrderDataModel.value.data?.id ?? ""}";
                                                      con.downloadFile(
                                                          url: con
                                                                  .getOrderDataModel
                                                                  .value
                                                                  .data
                                                                  ?.downloadInvoice ??
                                                              "",
                                                          fileName: fileName,
                                                          isDownload: true);
                                                    },
                                                    child: Icon(
                                                      Icons.download,
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13.sp),
                                                ),
                                                Text(
                                                  "Status: ",
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13.sp),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  child: Text(
                                                    con
                                                            .getOrderDataModel
                                                            .value
                                                            .data
                                                            ?.orderStatus
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13.sp),
                                                ),
                                                Text(
                                                  "Status: ",
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13.sp),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  child: Text(
                                                    con
                                                            .getOrderDataModel
                                                            .value
                                                            .data
                                                            ?.paymentStatus
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
                                            con.getOrderDataModel.value.data
                                                        ?.comments?.rating !=
                                                    null
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Order Rating ",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 13.sp),
                                                      ),
                                                      RatingBar.builder(
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemSize: 18,
                                                        initialRating:
                                                            double.parse(con
                                                                .getOrderDataModel
                                                                .value
                                                                .data!
                                                                .comments!
                                                                .rating
                                                                .toString()),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Icon(
                                                          Icons.star_rounded,
                                                          color:
                                                              AppColors.yellow,
                                                        ),
                                                        ignoreGestures: true,
                                                        onRatingUpdate:
                                                            (double value) {},
                                                      ),
                                                    ],
                                                  )
                                                : Container(),
                                            Divider(
                                              color: AppColors.greyBorderColor,
                                            ),
                                            SizedBox(
                                              height: 14.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "Item",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: AppColors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 11.sp),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "Price",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: AppColors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 11.sp),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "Quantity",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: AppColors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 11.sp),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "Subtotal",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: AppColors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 11.sp),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            _OrderModule(),
                                            Divider(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Subtotal",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 11.sp),
                                                ),
                                                Text(
                                                  "\$ ${con.getOrderDataModel.value.data?.orderAmount ?? "0"}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 11.sp),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 6.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Tax",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 11.sp),
                                                ),
                                                Text(
                                                  "\$ ${con.getOrderDataModel.value.data?.totalTaxAmount ?? "0"}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 11.sp),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 6.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Discount",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 11.sp),
                                                ),
                                                Text(
                                                  "\$ ${con.getOrderDataModel.value.data?.discountTotal ?? "0"}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 11.sp),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 6.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Delivery Charge",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 11.sp),
                                                ),
                                                Text(
                                                  "\$ ${con.getOrderDataModel.value.data?.deliveryCharge ?? "0"}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 11.sp),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Divider(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Grand Total",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13.sp),
                                                ),
                                                Text(
                                                  "\$ ${con.getOrderDataModel.value.data?.orderAmount ?? "0"}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 11.sp),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                          ]).paddingSymmetric(
                                          vertical: 10.h, horizontal: 10.w),
                                    ).paddingSymmetric(
                                        vertical: 3.h, horizontal: 10.w),
                                  ]),
                          ),
                        )
                      ]),
                    ],
                  ));
            }));
  }

  Widget _OrderModule() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: con.getOrderDataModel.value.data?.orderDetail?.length,
      itemBuilder: (BuildContext context, int index) {
        var item = con.getOrderDataModel.value.data?.orderDetail![index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "${index + 1}. ${item?.food?.foodName ?? ""}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp),
              ),
            ),
            Expanded(
              child: Text(
                "${item?.price ?? ""}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp),
              ),
            ),
            Expanded(
              child: Text(
                "${item?.quantity ?? ""}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp),
              ),
            ),
            Expanded(
              child: Text(
                item?.totalAmount ?? "",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp),
              ),
            ),
          ],
        );
      },
    );
  }
}
// ₹