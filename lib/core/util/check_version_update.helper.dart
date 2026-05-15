// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sukmaapps/core/configs/firebase/remote_config.service.dart';

// import '../../../core/configs/config.dart';
// import '../presentation/page/partial_update.page.dart';
// import '../presentation/widget/statics/static.dart';
// import 'package:go_router/go_router.dart';

// Future<void> checkAppVersion(WidgetRef ref) async {
//   try {
//     if (globalkey.currentContext == null) return;

//     final needsUpdate = await ref.read(remoteConfigServiceProvider.notifier).checkForUpdate();
//     if (needsUpdate) {
//       final isMajor = await ref.read(remoteConfigServiceProvider.notifier).isMajorUpdate();

//       if (globalkey.currentContext == null) return;

//       if (isMajor) {
//         globalkey.currentContext!.goNamed(Routes.forceUpdate);
//       } else {
//         StaticWidget.showDialogCustom(context: globalkey.currentContext!, widget: const PartialUpdatePage(), padding: EdgeInsets.all(23.5.w));
//       }
//     }
//   } catch (e) {
//     print('Version check error: $e');
//   }
// }
