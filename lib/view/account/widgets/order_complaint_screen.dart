import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodfestadeliverymen/controller/account/components/complaint_controller.dart';
import 'package:foodfestadeliverymen/repositories/desktop_repository.dart';
import 'package:foodfestadeliverymen/res/app_appbar.dart';
import 'package:foodfestadeliverymen/res/app_button.dart';
import 'package:foodfestadeliverymen/res/app_loader.dart';
import 'package:foodfestadeliverymen/res/app_style.dart';
import 'package:foodfestadeliverymen/res/app_text_field.dart';
import 'package:get/get.dart';

class OrderComplaintScreen extends StatelessWidget {
  OrderComplaintScreen({super.key});

  final OrderComplaintController con = Get.put(OrderComplaintController());
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
                      title: "Complaint",
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    Expanded(
                        child: Obx(
                      () => con.isLoading.value
                          ? const AppLoader()
                          : ListView(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding.w, vertical: 10),
                              children: [
                                AppTextField(
                                  titleText: "Complaint Message",
                                  hintText: "Enter complaint message",
                                  controller: con.complaintMessageCon,
                                  errorMessage: con.complaintMessageError.value,
                                  showError:
                                      con.complaintMessageValidation.value,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    // con.complaintMessageValidation.value =
                                    //     false;
                                  },
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                AppButton(
                                    onPressed: () async {
                                      //complaint message
                                      if (con.complaintMessageCon.value.text
                                          .isEmpty) {
                                        con.complaintMessageError.value =
                                            "Please enter complaint message";
                                        con.complaintMessageValidation.value =
                                            false;
                                        FocusScope.of(context).unfocus();
                                      } else {
                                        con.complaintMessageValidation.value =
                                            false;
                                        con.complaintMessageError.value = "";
                                      }

                                      if (con
                                          .complaintMessageValidation.isFalse) {
                                        await DesktopRepository()
                                            .complaintOrderApiCall(
                                                isLoader: con.isLoading,
                                                params: {
                                              "complaint":
                                                  con.complaintMessageCon.text,
                                              "order_id":
                                                  "9b38d4c7-eacf-42da-b80e-bf4ea84cf335"
                                            });
                                      }
                                    },
                                    title: "Submit")
                              ],
                            ),
                    ))
                  ]));
            }));
  }
}
