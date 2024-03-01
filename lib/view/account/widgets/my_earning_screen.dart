import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodfestadeliverymen/common_widgets/custom_earning_container.dart';
import 'package:foodfestadeliverymen/controller/setting/components/my_earning_controller.dart';
import 'package:foodfestadeliverymen/repositories/desktop_repository.dart';
import 'package:foodfestadeliverymen/res/app_appbar.dart';
import 'package:foodfestadeliverymen/res/app_assets.dart';
import 'package:foodfestadeliverymen/res/app_colors.dart';
import 'package:foodfestadeliverymen/res/app_loader.dart';
import 'package:foodfestadeliverymen/res/app_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyEarningScreen extends StatelessWidget {
  MyEarningScreen({super.key});
  final MyEarningController con = Get.put(MyEarningController());
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
                    Image.asset(
                      AppAssets.appbarBgImage,
                      fit: BoxFit.fill,
                      width: Get.width,
                      height: Get.height,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 16.sp,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          Text(
                            "My Earning",
                            style: AppStyle.customAppBarTitleStyle().copyWith(
                                color: AppColors.black, fontSize: 16.sp),
                          ),
                          const Text("Aboutus",
                              style: TextStyle(color: Colors.transparent)),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.1),
                        child: Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await DesktopRepository()
                                  .getEarningApiCall(isLoader: con.isLoader);
                            },
                            child: Obx(() => con.isLoader.value
                                ? const AppLoader()
                                : ListView(padding: EdgeInsets.zero, children: [
                                    Row(
                                      children: [
                                        CustomEarningContainer(
                                          title: con.myEarningData.value.wallet
                                                  ?.collectedCash
                                                  .toString() ??
                                              "",
                                          subTitle: "Collected Cash",
                                          image: AppAssets.cashImg,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        CustomEarningContainer(
                                          title: con.myEarningData.value.wallet
                                                  ?.totalEarning
                                                  .toString() ??
                                              "",
                                          subTitle: "Total Earning",
                                          image: AppAssets.earningImg,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        CustomEarningContainer(
                                          title: con.myEarningData.value.wallet
                                                  ?.totalWithdrawn
                                                  .toString() ??
                                              "",
                                          subTitle: "Total Withdraw",
                                          image: AppAssets.totalWithdrawImg,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        CustomEarningContainer(
                                          title: con.myEarningData.value.wallet
                                                  ?.pendingWithdraw
                                                  .toString() ??
                                              "",
                                          subTitle: "Pending Withdraw",
                                          image: AppAssets.penWithdrawImg,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 15.w),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 2.w),
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Payment Withdrawal Records",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Payment Type",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "Date",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "	Amount",
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   height: 7.h,
                                          // ),
                                          Divider(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          _paymentRecodeModule()
                                        ],
                                      ),
                                    )
                                  ]).paddingSymmetric(horizontal: 10.w)),
                          ),
                        )),
                  ],
                ),
              );
            }));
  }

  Widget _paymentRecodeModule() {
    return ListView.builder(
        shrinkWrap: true,
        // padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: con.myEarningData.value.data?.length,
        itemBuilder: (BuildContext context, int index) {
          var item = con.myEarningData.value.data?[index];
          return Row(
            children: [
              Expanded(
                child: Text(
                  item?.paymentType?.paymentTypeName ?? "",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                DateFormat('dd MMM yyyy hh:mm')
                    .format(item?.createdAt ?? DateTime.now()),
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                child: Text(
                  "${item?.disbursementAmount ?? ""}",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ).paddingSymmetric(vertical: 3.h);
        });
  }
}
