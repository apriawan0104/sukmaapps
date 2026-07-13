import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sukmaapps/core/core.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';

enum ProfileDialogType {
  logout,
  deleteAccount,
}

class ProfileDialogWidget {
  static Future<dynamic> show({
    required BuildContext context,
    required ProfileDialogType type,
    required Future<void> Function() onConfirm,
  }) {
    final config = _configFor(type);

    return StaticWidget.modalBottomWidget(
      context: context,
      widget: _ProfileDialogContent(
        title: config.title,
        subtitle: config.subtitle,
        icon: config.icon,
        confirmText: config.confirmText,
        onConfirm: onConfirm,
      ),
    );
  }

  static _ProfileDialogConfig _configFor(ProfileDialogType type) {
    switch (type) {
      case ProfileDialogType.logout:
        return _ProfileDialogConfig(
          title: 'Keluar dari Aplikasi?',
          subtitle:
              'Kamu perlu masuk kembali saat mau melakukan\nconvert pulsa',
          icon: IconSharedConstant.dialogLogout,
          confirmText: 'Ya, Keluar',
        );
      case ProfileDialogType.deleteAccount:
        return _ProfileDialogConfig(
          title: 'Hapus Akun User',
          subtitle:
              'Jika kamu menghapus akun, kamu tidak akan dapat melakukan pendaftaran kembali',
          icon: IconSharedConstant.dialogDeleteAccount,
          confirmText: 'Ya, Hapus',
        );
    }
  }
}

class _ProfileDialogConfig {
  const _ProfileDialogConfig({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.confirmText,
  });

  final String title;
  final String subtitle;
  final String icon;
  final String confirmText;
}

class _ProfileDialogContent extends StatefulWidget {
  const _ProfileDialogContent({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.confirmText,
    required this.onConfirm,
  });

  final String title;
  final String subtitle;
  final String icon;
  final String confirmText;
  final Future<void> Function() onConfirm;

  @override
  State<_ProfileDialogContent> createState() => _ProfileDialogContentState();
}

class _ProfileDialogContentState extends State<_ProfileDialogContent> {
  bool _isLoading = false;

  Future<void> _handleConfirm() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);
    LoadingOverlay.show(context);
    try {
      await widget.onConfirm();
    } finally {
      LoadingOverlay.hide();
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                SvgPicture.asset(
                  widget.icon,
                  width: 160.w,
                  height: 160.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: UITextPrimaryWidget(
                    title: widget.title,
                    fontSize: 14.sp,
                    color: AppColor.blackMassive,
                    fontWeight: FontWeight.w700,
                    align: TextAlign.start,
                  ),
                ),
                UITextPrimaryWidget(
                  align: TextAlign.center,
                  title: widget.subtitle,
                  fontSize: 12.sp,
                  color: AppColor.blackFair,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          UIButtonBottomMultipleWidget(
            leftTitleButton: 'Tidak, Batalkan',
            leftOnPressed: context.pop,
            isLeftEnable: !_isLoading,
            rightBgColor: AppColor.brPrimaryStrong,
            rightColor: Colors.white,
            rightTitleButton: widget.confirmText,
            rightOnPressed: _handleConfirm,
            isRightEnable: !_isLoading,
          ),
        ],
      ),
    );
  }
}
