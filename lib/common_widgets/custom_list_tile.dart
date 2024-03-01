import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodfestadeliverymen/res/app_colors.dart';
import 'package:foodfestadeliverymen/res/app_style.dart';
import 'package:get/get.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? child;
  final bool? isChildShow;
  final void Function()? onPressed;

  const CustomListTile(
      {super.key,
      required this.icon,
      required this.title,
      this.onPressed,
      this.child,
      this.isChildShow = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 2.h),
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor, width: 2),
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.white),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
              Icon(
                Icons.arrow_right,
                size: 30.h,
                color:   Theme.of(context).primaryColor,
              ),
            ]).paddingSymmetric(horizontal: defaultPadding, vertical: 4),
            isChildShow == true ? child ?? const SizedBox() : const SizedBox()
          ],
        ),
      ),
    );
  }
}
