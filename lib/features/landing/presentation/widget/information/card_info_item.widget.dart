import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';

class CardInfoItemWidget extends StatelessWidget {
  const CardInfoItemWidget(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.title});
  final VoidCallback onTap;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: UICardPrimaryWidget(
        color: const Color(0xFFF7F7FC),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    icon,
                    fit: BoxFit.fitHeight,
                    height: 28.h,
                  ),
                  SizedBox(width: 16.w),
                  SvgPicture.asset(IconProfileConstant.dotAccent,
                      height: 28.h, width: 28.w),
                ],
              ),
              SizedBox(height: 8.h),
              UITextPrimaryWidget(
                title: title,
                fontSize: 12.sp,
                color: AppColor.blackFair,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
