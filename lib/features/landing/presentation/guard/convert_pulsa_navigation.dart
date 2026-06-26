import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sukmaapps/config/config.dart';

import 'convert_pulsa_access.guard.dart';

abstract final class ConvertPulsaNavigation {
  /// Replaces current stack with the phone route (e.g. "Convert Lagi").
  static Future<void> goToPhone(BuildContext context) async {
    if (!await getIt<ConvertPulsaAccessGuard>().ensureAccess()) return;
    if (!context.mounted) return;
    context.goNamed(RouteNames.phone, extra: true);
  }

  /// Pushes phone on top of current stack (e.g. FAB from landing).
  static Future<void> pushPhone({BuildContext? context}) async {
    if (!await getIt<ConvertPulsaAccessGuard>().ensureAccess()) return;
    if (context != null) {
      if (!context.mounted) return;
      context.pushNamed(RouteNames.phone, extra: true);
      return;
    }
    appRouter.pushNamed(RouteNames.phone, extra: true);
  }
}
