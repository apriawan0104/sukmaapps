import 'package:flutter/material.dart';

import '../../../../app/app.dart';

class UIBannerEnv {
  static Widget banner(String env, Widget child) {
    return env.toUpperCase() != 'PRD'
        ? Banner(
            location: BannerLocation.topEnd,
            message: env.toUpperCase(),
            color: env.toUpperCase() == 'UAT'
                ? AppColor.bannerUat
                : AppColor.bannerDev,
            child: child,
          )
        : SizedBox(child: child);
  }
}
