import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UIButtonBottomWidget extends StatelessWidget {
  const UIButtonBottomWidget({
    super.key,
    this.widgetInfo,
    required this.titleButton,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF164994),
    this.foregroundColor = Colors.white,
  });

  final Widget? widgetInfo;
  final String titleButton;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              padding: REdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6).w),
              minimumSize: Size.fromHeight(48.h),
              side: const BorderSide(
                color: Color(0xFF164994),
                style: BorderStyle.solid,
                width: 2.0,
              ),
            ),
            onPressed: onPressed,
            child: Text(
              titleButton,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
