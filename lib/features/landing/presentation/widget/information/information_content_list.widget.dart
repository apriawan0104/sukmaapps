import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

import 'card_info_item.widget.dart';

class InformationContentListWidget extends StatelessWidget {
  const InformationContentListWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap,
      this.secondIcon,
      this.secondTitle,
      this.secondOnTap});
  final String icon;
  final String title;
  final VoidCallback onTap;
  final String? secondIcon;
  final String? secondTitle;
  final VoidCallback? secondOnTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CardInfoItemWidget(
                icon: icon,
                title: title,
                onTap: onTap,
              ),
            ),
            ...(secondIcon != null &&
                    secondTitle != null &&
                    secondOnTap != null)
                ? [
                    SizedBox(width: 16.w),
                    Expanded(
                      child: CardInfoItemWidget(
                        icon: secondIcon ?? '',
                        title: secondTitle ?? '',
                        onTap: secondOnTap ?? () {},
                      ),
                    ),
                  ]
                : [
                    SizedBox(width: 16.w),
                    const Expanded(child: SizedBox()),
                  ],
          ],
        ),
        if (secondIcon != null && secondTitle != null && secondOnTap != null)
          SizedBox(height: 16.h),
      ],
    );
  }
}
