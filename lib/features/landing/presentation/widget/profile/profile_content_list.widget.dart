import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';

class ProfileContentListWidget extends StatelessWidget {
  const ProfileContentListWidget(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.title,
      this.isDivider = true});
  final VoidCallback onTap;
  final String icon;
  final String title;
  final bool? isDivider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: REdgeInsets.all(16.0),
            child: SizedBox(
              child: Row(
                children: [
                  SvgPicture.asset(
                    icon,
                    height: 24.h,
                    width: 24.w,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                      child: UITextPrimaryWidget(
                          title: title,
                          fontSize: 14.sp,
                          color: AppColor.blackFair,
                          fontWeight: FontWeight.w400)),
                  SizedBox(width: 8.w),
                  Icon(Icons.chevron_right,
                      size: 24.sp, color: AppColor.blackFair),
                  SizedBox(width: 24.w),
                ],
              ),
            ),
          ),
          if (isDivider!)
            Row(
              children: [
                SizedBox(width: 40.w),
                SizedBox(width: 8.w),
                Expanded(child: Divider(color: AppColor.whiteSoft)),
              ],
            )
        ],
      ),
    );
  }
}
