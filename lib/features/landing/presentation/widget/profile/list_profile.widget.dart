import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import 'profile_content_list.widget.dart';

class ListProfileWidget extends StatelessWidget {
  const ListProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileContentListWidget(
          icon: IconProfileConstant.call,
          title: 'Nomor Favorit',
          onTap: () {
            context.pushNamed(RouteNames.phoneFav);
          },
        ),
        ProfileContentListWidget(
          icon: IconProfileConstant.bookmark,
          title: 'Rekening Favorit',
          isDivider: false,
          onTap: () {
            context.pushNamed(RouteNames.rekeningFav);
          },
        ),
      ],
    );
  }
}
