import 'package:flutter/material.dart';

import '../../../../config/navigation/app_router.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void show([BuildContext? context]) {
    if (_overlayEntry != null) return;

    final overlayContext = context ?? rootNavigatorKey.currentContext;
    if (overlayContext == null) return;

    final overlay = Overlay.of(overlayContext, rootOverlay: true);
    _overlayEntry = OverlayEntry(
      builder: (context) => AbsorbPointer(
        child: ColoredBox(
          color: Colors.black.withValues(alpha: 0.3),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
    overlay.insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
