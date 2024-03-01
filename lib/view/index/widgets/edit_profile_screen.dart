import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodfestadeliverymen/controller/edit_profile_controller.dart';
import 'package:foodfestadeliverymen/repositories/desktop_repository.dart';
import 'package:foodfestadeliverymen/res/app_appbar.dart';
import 'package:foodfestadeliverymen/res/app_assets.dart';
import 'package:foodfestadeliverymen/res/app_button.dart';
import 'package:foodfestadeliverymen/res/app_colors.dart';
import 'package:foodfestadeliverymen/res/app_style.dart';
import 'package:foodfestadeliverymen/res/app_text_field.dart';
import 'package:get/get.dart';
import 'dart:io' as io;

class EditAccountScreen extends StatelessWidget {
  EditAccountScreen({super.key});

  final editAccountController = Get.put(EditAccountController());
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
                    padding: EdgeInsets.only(top: Get.height * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                             Text(
                          "Edit Account",
                          style: AppStyle.customAppBarTitleStyle().copyWith(
                              color: AppColors.black, fontSize: 16.sp),
                        ),
                        ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.1),
                      child: Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 2),
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  boxShadow: AppStyle.boxShadow(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "MY PROFILE",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  _profileImageWidget(),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  AppTextField(
                                    // titleText: "Full Name",
                                    hintText: "Enter First Name",
                                    controller:
                                        editAccountController.firstNameCon,
                                    errorMessage: editAccountController
                                        .firstNameError.value,
                                    showError: editAccountController
                                        .firstNameValidation.value,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) {
                                      editAccountController
                                          .firstNameValidation.value = false;
                                    },
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14.r)),
                                        borderSide:
                                            BorderSide(color: AppColors.white)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14.r)),
                                        borderSide:
                                            BorderSide(color: AppColors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14.r)),
                                        borderSide:
                                            BorderSide(color: AppColors.white)),
                                  ),
                                  SizedBox(height: 10.w),
                                  AppTextField(
                                    // titleText: "Full Name",
                                    hintText: "Enter Last Name",
                                    controller:
                                        editAccountController.lastNameCon,
                                    errorMessage: editAccountController
                                        .lastNameError.value,
                                    showError: editAccountController
                                        .lastNameValidation.value,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) {
                                      editAccountController
                                          .lastNameValidation.value = false;
                                    },
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14.r)),
                                        borderSide:
                                            BorderSide(color: AppColors.white)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14.r)),
                                        borderSide:
                                            BorderSide(color: AppColors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14.r)),
                                        borderSide:
                                            BorderSide(color: AppColors.white)),
                                  ),
                                  SizedBox(height: 10.w),
                                  AppTextField(
                                    // titleText: "Email",
                                    hintText: "Enter Email", readOnly: true,
                                    controller: editAccountController.emailCon,
                                    errorMessage:
                                        editAccountController.emailError.value,
                                    showError: editAccountController
                                        .emailValidation.value,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      editAccountController
                                          .emailValidation.value = false;
                                    },
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14.r)),
                                        borderSide:
                                            BorderSide(color: AppColors.white)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14.r)),
                                        borderSide:
                                            BorderSide(color: AppColors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14.r)),
                                        borderSide:
                                            BorderSide(color: AppColors.white)),
                                  ),
                                  SizedBox(height: 10.w),
                                  AppTextField(
                                    controller:
                                        editAccountController.mobileNumberCon,
                                    errorMessage:
                                        editAccountController.mobileError.value,
                                    showError: editAccountController
                                        .isMobileValid.value,
                                    // titleText: "Mobile Number",
                                    hintText: "Mobile Number",
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    onChanged: (value) {
                                      if (editAccountController.mobileNumberCon
                                              .value.text.length ==
                                          10) {
                                        FocusScope.of(context).unfocus();
                                      }
                                      editAccountController
                                          .isMobileValid.value = false;
                                    },
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14.r)),
                                        borderSide:
                                            BorderSide(color: AppColors.white)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14.r)),
                                        borderSide:
                                            BorderSide(color: AppColors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14.r)),
                                        borderSide:
                                            BorderSide(color: AppColors.white)),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  AppButton(
                                    height: 30.h,
                                    borderRadius: BorderRadius.circular(12.r),
                                    onPressed: () {
                                      log(editAccountController
                                          .imagePath.value);
                                      DesktopRepository().editProfileApiCall(
                                        isLoader:
                                            editAccountController.isLoader,
                                      );
                                    },
                                    title: "Update",
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  )
                                ],
                              ),
                            )
                          ],
                        ).paddingSymmetric(horizontal: 15.h, vertical: 5.h),
                      )),
                ],
              ),
            );
          }),
    );
  }

  Widget _profileImageWidget() {
    return Stack(children: [
      Positioned(
        // left: 20,
        // top: 20,
        // right: 20,
        // bottom: 20,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
            child: Container(
              height: 70.h,
              width: 70.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                // shape: BoxShape.circle,
              ),
              child: Obx(
                () => editAccountController.imagePath.isNotEmpty
                    ? Image.file(
                        io.File(editAccountController.imagePath.value),
                        fit: BoxFit.cover,
                      )
                    : editAccountController.image.value.isNotEmpty
                        ? Image.network(
                            editAccountController.image.value,
                            fit: BoxFit.cover,
                          )
                        //  LocalStorage.userImage.value.contains("https://") || LocalStorage.userImage.value.contains("http://")
                        //     ? MFNetworkImage(
                        //         imageUrl: LocalStorage.userImage.value,
                        //         fit: BoxFit.cover,
                        //       )
                        : Image.network(
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                            fit: BoxFit.cover,
                          ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
          bottom: 10.h,
          right: 100.w,
          child: Center(
            child: GestureDetector(
              onTap: () {
                editAccountController.showImagePickerBottomSheet();
              },
              child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(Get.context!).primaryColor,
                    // colorScheme.background,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(7),
                    ),
                  ),
                  child: Icon(
                    Icons.edit,
                    // AppIcons.cameraIcon,\
                    color: AppColors.white,
                    //  Theme.of(Get.context!).primaryColor,
                    // height: 25,
                    // width: 25,
                    size: 18,
                  )),
            ),
          ))
    ]);
  }
  // Widget _profileImageWidget() {
  //   return Stack(children: [
  //     Positioned(
  //       // left: 20,
  //       // top: 20,
  //       // right: 20,
  //       // bottom: 20,
  //       child: Center(
  //         child: ClipRRect(
  //           borderRadius: const BorderRadius.all(
  //             Radius.circular(200),
  //           ),
  //           child: editAccountController.selectedProfileImage != null
  //               ? Container(
  //                   height: 180,
  //                   width: 180,
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey,
  //                     shape: BoxShape.circle,
  //                     image: DecorationImage(
  //                       image: FileImage(
  //                         editAccountController.selectedProfileImage!,
  //                       ),
  //                       onError: (exception, stackTrace) =>
  //                           // Image.asset(AppImages.appLogoImage),
  //                           Image.network(
  //                               "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 )
  //               : Container(
  //                   height: 180,
  //                   width: 180,
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey,
  //                     shape: BoxShape.circle,
  //                     image: DecorationImage(
  //                         image: const NetworkImage(
  //                             'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'), //userProfileImage),
  //                         fit: BoxFit.cover,
  //                         onError: (exception, stackTrace) =>
  //                             // Image.asset(AppImages.appLogoImage),
  //                             Image.network(
  //                                 "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")),
  //                   ),
  //                 ),
  //         ),
  //       ),
  //     ),
  //     Positioned(
  //         bottom: 20,
  //         right: 100,
  //         child: Center(
  //           child: GestureDetector(
  //             onTap: () {
  //               editAccountController.showImagePickerBottomSheet();
  //             },
  //             child: Container(
  //                 padding: const EdgeInsets.all(4),
  //                 decoration: BoxDecoration(
  //                   color: Theme.of(Get.context!).primaryColor,
  //                   // colorScheme.background,
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(7),
  //                   ),
  //                 ),
  //                 child: Icon(
  //                   Icons.camera,
  //                   // AppIcons.cameraIcon,
  //                   color: AppColors.white,
  //                   //  Theme.of(Get.context!).primaryColor,
  //                   // height: 25,
  //                   // width: 25,
  //                   size: 25,
  //                 )),
  //           ),
  //         ))
  //   ]);
  // }
}
