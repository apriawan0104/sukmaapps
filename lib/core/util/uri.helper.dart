import 'dart:io' show Platform;

import 'package:app_core/app_core.dart';

import '../../config/di/locator.dart';
import '../constant/constant.dart';

abstract final class UriHelper {
  static Future<void> goToStore() async {
    final url = Platform.isIOS
        ? EnvConstant.appStoreUrl.env
        : EnvConstant.playStoreUrl.env;

    if (url.isEmpty || url == '-') {
      return;
    }

    await getIt<UrlLauncherService>().launchWebUrl(url);
  }
}
