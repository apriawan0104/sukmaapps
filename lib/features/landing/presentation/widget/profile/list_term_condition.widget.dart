import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import 'profile_content_list.widget.dart';

class ListTermConditionWidget extends StatelessWidget {
  const ListTermConditionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileContentListWidget(
          icon: IconProfileConstant.termCondition,
          title: 'Ketentuan Layanan',
          onTap: () {
            context.pushNamed(RouteNames.termConditionProfile);
          },
        ),
        ProfileContentListWidget(
          icon: IconProfileConstant.privacyPolicy,
          title: 'Kebijakan Privasi',
          isDivider: false,
          onTap: () {
            context.pushNamed(RouteNames.privacyPolicyProfile);
          },
        ),
      ],
    );
  }
}
