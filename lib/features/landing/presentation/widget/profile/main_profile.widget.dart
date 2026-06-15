import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sukmaapps/core/core.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../auth/domain/entity/local_user.entity.dart';
import '../../adapter/landing.adapter.dart';

class MainProfileWidget extends ConsumerWidget {
  const MainProfileWidget({
    super.key,
    required this.onPressLogout,
    required this.onPressDeleteAccount,
  });

  final VoidCallback onPressLogout;
  final VoidCallback onPressDeleteAccount;

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
        onPressLogout();
      };
    }
    if (typeDialog == 'delete_account') {
      title = 'Hapus Akun User';
      subtitle =
          'Jika kamu menghapus akun, kamu tidak akan dapat melakukan pendaftaran kembali';
      iconDialog = IconSharedConstant.dialogDeleteAccount;
      textBtn = 'Ya, Hapus';
      onPressConfirm = () {
        onPressDeleteAccount();
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
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(landingRiverpodAdapterProvider).localUser;
    final ctrl = ref.read(landingRiverpodAdapterProvider.notifier);

    return AsyncValueWidget<LocalUserEntity>(
      value: localUser,
      onRetry: ctrl.getLocalUser,
      errorWidget: (_, __) => const SizedBox.shrink(),
      onSuccess: (user) {
        final fotoUrl = user.foto.isNotEmpty
            ? user.foto
            : 'https://via.placeholder.com/150';

        return Padding(
          padding: const REdgeInsets.fromLTRB(16, 16, 16, 0),
          child: SizedBox(
            width: double.infinity,
            height: 96.h,
            child: Row(
              children: [
                SizedBox(
                  height: 64.h,
                  width: 64.w,
                  child: CircleAvatar(
                    backgroundColor: AppColor.brPrimaryStrong,
                    backgroundImage: NetworkImage(fotoUrl),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UITextPrimaryWidget(
                        title: user.fullname,
                        fontSize: 14.sp,
                        color: const Color(0xFF19202D),
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    dialogMessage(context: context, typeDialog: 'logout');
                  },
                  child: SvgPicture.asset(
                    IconSharedConstant.logout,
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
