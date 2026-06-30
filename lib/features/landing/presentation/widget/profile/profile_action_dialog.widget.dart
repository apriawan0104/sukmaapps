import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';

Future<void> showProfileActionDialog({
  required BuildContext context,
  required String typeDialog,
  required VoidCallback onConfirm,
}) async {
  String title = '';
  String subtitle = '';
  String iconDialog = '';
  String textBtn = '';

  if (typeDialog == 'logout') {
    title = 'Keluar dari Aplikasi?';
    subtitle = 'Kamu perlu masuk kembali saat mau melakukan\nconvert pulsa';
    iconDialog = IconSharedConstant.dialogLogout;
    textBtn = 'Ya, Keluar';
  } else if (typeDialog == 'delete_account') {
    title = 'Hapus Akun User';
    subtitle =
        'Jika kamu menghapus akun, kamu tidak akan dapat melakukan pendaftaran kembali';
    iconDialog = IconSharedConstant.dialogDeleteAccount;
    textBtn = 'Ya, Hapus';
  }

  final item = Container(
    color: Colors.white,
    child: Wrap(
      alignment: WrapAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              SvgPicture.asset(
                iconDialog,
                width: 160.w,
                height: 160.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: UITextPrimaryWidget(
                  title: title,
                  fontSize: 14.sp,
                  color: AppColor.blackMassive,
                  fontWeight: FontWeight.w700,
                  align: TextAlign.start,
                ),
              ),
              UITextPrimaryWidget(
                align: TextAlign.center,
                title: subtitle,
                fontSize: 12.sp,
                color: AppColor.blackFair,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
        UIButtonBottomMultipleWidget(
          leftTitleButton: 'Tidak, Batalkan',
          leftOnPressed: () {
            context.pop();
          },
          rightBgColor: AppColor.brPrimaryStrong,
          rightColor: Colors.white,
          rightTitleButton: textBtn,
          rightOnPressed: onConfirm,
        ),
      ],
    ),
  );

  await StaticWidget.modalBottomWidget(
    context: context,
    widget: item,
  );
}
