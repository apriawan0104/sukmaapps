import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

import '../../../../app/app.dart';
import '../text/text_primary.widget.dart';

class UIButtonBottomMultipleWidget extends StatelessWidget {
  const UIButtonBottomMultipleWidget({
    super.key,
    this.widgetInfo,
    required this.leftTitleButton,
    required this.leftOnPressed,
    required this.rightTitleButton,
    required this.rightOnPressed,
    this.leftBgColor,
    this.rightBgColor,
    this.leftColor,
    this.rightColor,
    this.isLeftEnable = true,
    this.isRightEnable = true,
  });

  final Widget? widgetInfo;
  final String leftTitleButton;
  final VoidCallback leftOnPressed;
  final String rightTitleButton;
  final VoidCallback rightOnPressed;
  final Color? leftBgColor;
  final Color? rightBgColor;
  final Color? leftColor;
  final Color? rightColor;
  final bool isLeftEnable;
  final bool isRightEnable;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.w, color: Colors.grey.shade300),
          ),
          color: Colors.white),
      padding: REdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widgetInfo ?? Container(),
          widgetInfo != null
              ? SizedBox(height: 16.h)
              : const SizedBox(height: 0),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFF164994)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      backgroundColor:
                          (isLeftEnable) ? leftBgColor : AppColor.blackRoot,
                      minimumSize: Size.fromHeight(48.h)),
                  onPressed: (isLeftEnable) ? leftOnPressed : () {},
                  child: UITextPrimaryWidget(
                    title: leftTitleButton,
                    fontSize: 14.sp,
                    color: (isLeftEnable)
                        ? leftColor ?? AppColor.brPrimaryStrong
                        : Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFF164994)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      backgroundColor:
                          (isRightEnable) ? rightBgColor : AppColor.blackRoot,
                      minimumSize: Size.fromHeight(48.h)),
                  onPressed: (isRightEnable) ? rightOnPressed : () {},
                  child: UITextPrimaryWidget(
                    title: rightTitleButton,
                    fontSize: 14.sp,
                    color: (isRightEnable)
                        ? rightColor ?? AppColor.brPrimaryStrong
                        : Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
