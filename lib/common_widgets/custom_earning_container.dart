import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodfestadeliverymen/res/app_colors.dart';

class CustomEarningContainer extends StatelessWidget {
  final Color? bgColor;
  final String title;
  final String subTitle;
  final String image;
  const CustomEarningContainer(
      {super.key,
      this.bgColor,
      required this.title,
      required this.subTitle,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
      decoration: BoxDecoration(
          color: bgColor ?? Theme.of(context).colorScheme.background,
          border: Border.all(color: Theme.of(context).primaryColor, width: 2.w),
          borderRadius: BorderRadius.circular(14.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                subTitle,
                style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          Image.asset(
            image,
            height: 25.w,
          ),
        ],
      ),
    ));
  }
}
