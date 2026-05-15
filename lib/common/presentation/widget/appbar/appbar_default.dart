import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app.dart';
import '../text/text_primary.widget.dart';

class UIAppBar {
  static PreferredSizeWidget appBar(
    BuildContext context, {
    required String title,
    Widget? customBackButton,
    Color? backgroundColor,
  }) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: UITextPrimaryWidget(
        title: title,
        fontSize: 16.sp,
        color: const Color(0xFF19202D),
        fontWeight: FontWeight.w700,
      ),
      centerTitle: true,
      leading: (customBackButton != null)
          ? customBackButton
          : IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.pop(),
            ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Container(
          color: AppColor.whiteSoft,
          height: 1.h,
        ),
      ),
    );
  }
}
