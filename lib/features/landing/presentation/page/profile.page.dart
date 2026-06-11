import 'package:app_core/app_core.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app.dart';
import '../../../../common/common.dart';
import '../../../../core/core.dart';
import '../controller/landing.controller.dart';
import '../widget/widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.ctrl});
  final LandingController ctrl;

  Future<dynamic> dialogMessage({
    required BuildContext context,
    required String typeDialog,
  }) async {
    String title = '';
    String subtitle = '';
    String iconDialog = '';
    String textBtn = '';
    VoidCallback onPressConfirm = () {};
    if (typeDialog == 'logout') {
      title = 'Keluar dari Aplikasi?';
      subtitle = 'Kamu perlu masuk kembali saat mau melakukan\nconvert pulsa';
      iconDialog = IconSharedConstant.dialogLogout;
      textBtn = 'Ya, Keluar';
      onPressConfirm = () {
        ctrl.logout();
      };
    }
    if (typeDialog == 'delete_account') {
      title = 'Hapus Akun User';
      subtitle =
          'Jika kamu menghapus akun, kamu tidak akan dapat melakukan pendaftaran kembali';
      iconDialog = IconSharedConstant.dialogDeleteAccount;
      textBtn = 'Ya, Hapus';
      onPressConfirm = () {
        ctrl.deleteAccount();
      };
    }
    Widget item = Container(
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
                    fontWeight: FontWeight.w400)
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
            rightOnPressed: onPressConfirm,
          )
        ],
      ),
    );
    StaticWidget.modalBottomWidget(
      context: context,
      widget: item,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIAppBar.appBar(
        context,
        title: 'Akun',
        customBackButton: const SizedBox(),
      ),
      body: ListView(
        children: [
          MainProfileWidget(onPressLogout: () {}, onPressDeleteAccount: () {}),
          const UIKeyPairWidget(),
          ListProfileWidget(),
          const UIKeyPairWidget(),
          ListTermConditionWidget(),
          const UIKeyPairWidget(),
          // contentListMedsos(),
          // const UIKeyPairWidget(),
          ProfileContentListWidget(
            icon: IconProfileConstant.deleteAccount,
            title: 'Hapus Akun',
            onTap: () {
              dialogMessage(context: context, typeDialog: 'delete_account');
            },
          ),
          VersionWidget(
              icon: IconProfileConstant.setting,
              title: 'Versi Aplikasi',
              subtitle: 'Versi',
              onTap: () {}),
          ChuckerFlutter.chuckerButton
        ],
      ),
    );
  }
}
