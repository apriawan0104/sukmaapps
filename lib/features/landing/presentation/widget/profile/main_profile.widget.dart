import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sukmaapps/core/core.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../auth/domain/entity/local_user.entity.dart';
import '../../adapter/landing.adapter.dart';
import 'profile_action_dialog.widget.dart';

class MainProfileWidget extends ConsumerWidget {
  const MainProfileWidget({
    super.key,
    required this.onPressLogout,
  });

  final Future<void> Function() onPressLogout;

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
                    showProfileActionDialog(
                      context: context,
                      typeDialog: 'logout',
                      onConfirm: onPressLogout,
                    );
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
