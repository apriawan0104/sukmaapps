import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../app/app.dart';
import '../../../../config/navigation/app_router.dart';
import '../buttons/button_primary.widget.dart';
import '../text/text_primary.widget.dart';

class StaticWidget {
  static Future<dynamic> modalBottomWidget({
    required BuildContext context,
    required Widget widget,
    bool isDismissible = true,
    bool isShowDragHandling = true,
  }) async {
    dynamic returnData;
    await showModalBottomSheet(
        enableDrag: isShowDragHandling,
        isScrollControlled: true,
        isDismissible: isDismissible,
        showDragHandle: false,
        useSafeArea: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(0.w),
            topStart: Radius.circular(0.w),
          ),
        ),
        builder: (context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ColoredBox(
                    color: AppColor.whiteMassive,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          top: 20.w),
                      child: widget,
                    ),
                  ),
                  if (isShowDragHandling)
                    Positioned(
                      top: 8.w,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        width: 32.w,
                        height: 4.w,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFE7E8F3),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.w, color: const Color(0xFFE7E8F3)),
                            borderRadius: BorderRadius.circular(2).w,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }).then((value) {
      returnData = value;
    });
    return returnData;
  }

  static Future<bool?> msgToast(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2);
  }

  static void showErrorDialog({
    required String message,
    BuildContext? context,
    String title = 'Terjadi Kesalahan',
    String buttonText = 'OK',
  }) {
    final dialogContext = context ?? rootNavigatorKey.currentContext;
    if (dialogContext == null) {
      msgToast(message);
      return;
    }

    showDialogCustom(
      context: dialogContext,
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UITextPrimaryWidget(
            title: title,
            fontSize: 16.sp,
            color: AppColor.blackMassive,
            fontWeight: FontWeight.w700,
            align: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          UITextPrimaryWidget(
            title: message,
            fontSize: 14.sp,
            color: AppColor.blackFair,
            fontWeight: FontWeight.w400,
            align: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          UIButtonPrimaryWidget(
            titleButton: buttonText,
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
        ],
      ),
    );
  }

  static void showDialogCustom(
      {required BuildContext context,
      required Widget widget,
      bool canPop = true,
      EdgeInsets? padding}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return PopScope(
            canPop: canPop,
            child: Dialog(
              child: Container(
                color: Colors.white,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Padding(
                      padding: padding ?? REdgeInsets.all(16.w),
                      child: widget,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
