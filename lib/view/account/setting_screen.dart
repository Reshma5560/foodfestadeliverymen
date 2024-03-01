import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodfestadeliverymen/common_widgets/custom_list_tile.dart';
import 'package:foodfestadeliverymen/controller/setting/setting_controller.dart';
import 'package:foodfestadeliverymen/res/app_appbar.dart';
import 'package:foodfestadeliverymen/res/app_assets.dart';
import 'package:foodfestadeliverymen/res/app_button.dart';
import 'package:foodfestadeliverymen/res/app_colors.dart';
import 'package:foodfestadeliverymen/res/app_style.dart';
import 'package:foodfestadeliverymen/route/app_routes.dart';
import 'package:foodfestadeliverymen/utils/local_storage.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  final SettingController con = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  icon: Icon(Icons.arrow_back_ios,
                      size: 16.sp, color: Colors.transparent),
                  onPressed: () {
                    Get.back();
                  },
                ),
                Text(
                  "Setting",
                  style: AppStyle.customAppBarTitleStyle()
                      .copyWith(color: AppColors.black, fontSize: 16.sp),
                ),
                const Text("Aboutus",
                    style: TextStyle(color: Colors.transparent)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.1),
            child: _bodyWidget(),
          ),
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return Column(
      children: [
        CustomListTile(
          icon: Icons.star,
          title: 'Deliveryman Rating',
          onPressed: () {
            con.isRating.value = !con.isRating.value;
          },
          isChildShow: true,
          child: Obx(() => con.isRating.value == true
              ? con.getReviewData.value.ratingCount != null
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 9.h),
                      margin:
                          EdgeInsets.symmetric(horizontal: 50.w, vertical: 8.h),
                      decoration: BoxDecoration(
                          color: Theme.of(Get.context!).colorScheme.background,
                          borderRadius: BorderRadius.circular(15.h)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RatingBar.builder(
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemSize: 18,
                            initialRating: double.parse(
                                con.getReviewData.value.ratingCount.toString()),
                            itemBuilder: (context, _) => Icon(
                              Icons.star_rounded,
                              color: AppColors.yellow,
                            ),
                            ignoreGestures: true,
                            onRatingUpdate: (double value) {},
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            "${con.getReviewData.value.ratingCount.toString()} out of 5.0",
                            style: TextStyle(
                                color: AppColors.greyFontColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp),
                          ),
                        ],
                      ),
                    )
                  : Container()
              : Container()),
        ),
        SizedBox(
          height: 13.h,
        ),
        CustomListTile(
          icon: Icons.money,
          title: 'My Earning',
          onPressed: () {
            Get.toNamed(AppRoutes.myEarningScreen);
          },
        ),
        SizedBox(
          height: 13.h,
        ),
        CustomListTile(
          icon: Icons.password,
          title: 'Change password',
          onPressed: () {
            Get.toNamed(AppRoutes.updatePasswordScreen);
          },
        ),
        SizedBox(
          height: 13.h,
        ),
        CustomListTile(
          icon: Icons.logout,
          title: 'Logout',
          onPressed: () {
            _logoutWidget();
          },
        ),
        SizedBox(
          height: 13.h,
        ),
      ],
    ).paddingSymmetric(horizontal: 10.w);
  }

  _logoutWidget() {
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "Logout",
                            style: TextStyle(
                              // fontFamily: FontFamilyText.sFProDisplayRegular,
                              color: Theme.of(Get.context!).primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Are you sure you want logout ?",
                            style: TextStyle(
                              // fontFamily: FontFamilyText.sFProDisplayRegular,
                              color: Theme.of(Get.context!).primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  height: 30.h,
                                  borderRadius: BorderRadius.circular(10),
                                  onPressed: () {
                                    con.isLoader.value = true;

                                    LocalStorage.clearLocalStorage()
                                        .then((value) {
                                      Get.offAllNamed(AppRoutes.loginScreen);
                                    });
                                  },
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 14.sp),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: AppButton(
                                  height: 30.h,
                                  borderRadius: BorderRadius.circular(10),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
        barrierDismissible: false);
  }
}
