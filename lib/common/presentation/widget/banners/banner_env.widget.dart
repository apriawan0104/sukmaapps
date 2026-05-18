import 'package:flutter/material.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';

class UIBannerEnv {
  static Widget banner(FlavorType env, Widget child) {
    if (!env.showsEnvBanner) {
      return SizedBox(child: child);
    }

    return Banner(
      location: BannerLocation.topEnd,
      message: env.bannerLabel,
      color: env == FlavorType.uat ? AppColor.bannerUat : AppColor.bannerDev,
      child: child,
    );
  }
}
