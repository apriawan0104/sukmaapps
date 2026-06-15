import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

import '../widget/statics/static.widget.dart';
import 'failure_display_mode.dart';

class FailurePresenter {
  const FailurePresenter._();

  static void show(
    Object error, {
    FailureDisplayMode mode = FailureDisplayMode.toast,
    BuildContext? context,
  }) {
    final message = FailureMessageResolver.userMessage(error);
    if (message == null) return;

    switch (mode) {
      case FailureDisplayMode.toast:
        StaticWidget.msgToast(message);
      case FailureDisplayMode.dialog:
        StaticWidget.showErrorDialog(message: message, context: context);
    }
  }
}
