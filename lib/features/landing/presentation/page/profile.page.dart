import 'package:flutter/material.dart';

import '../../../../common/common.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../controller/landing.controller.dart';
import '../widget/widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.ctrl});
  final LandingController ctrl;

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
          MainProfileWidget(
            onPressLogout: ctrl.logout,
          ),
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
              ProfileDialogWidget.show(
                context: context,
                type: ProfileDialogType.deleteAccount,
                onConfirm: ctrl.deleteAccount,
              );
            },
          ),
          VersionWidget(
              icon: IconProfileConstant.setting,
              title: 'Versi Aplikasi',
              subtitle: 'Versi',
              onTap: () {}),
          ChuckerConfig.button
        ],
      ),
    );
  }
}
