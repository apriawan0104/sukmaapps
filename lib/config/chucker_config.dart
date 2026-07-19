import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ChuckerConfig {
  ChuckerConfig._();

  static bool _enabled = false;
  static const Duration _globalLongPressDuration = Duration(seconds: 2);

  static void configure({required bool enabled}) {
    _enabled = enabled;
    ChuckerFlutter.isDebugMode = enabled && kDebugMode;
    ChuckerFlutter.showOnRelease = enabled;
    ChuckerFlutter.showNotification = enabled;
  }

  static List<NavigatorObserver> get navigatorObservers =>
      _enabled ? [ChuckerFlutter.navigatorObserver] : const [];

  static List<ChuckerDioInterceptor> get dioInterceptors =>
      _enabled ? [ChuckerDioInterceptor()] : const [];

  static Widget get button => ChuckerFlutter.chuckerButton;

  static Widget enableGlobalLongPress({required Widget child}) {
    if (!_enabled) {
      return child;
    }

    return RawGestureDetector(
      behavior: HitTestBehavior.translucent,
      gestures: {
        LongPressGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
          () => LongPressGestureRecognizer(
            duration: _globalLongPressDuration,
          ),
          (recognizer) {
            recognizer.onLongPress = ChuckerFlutter.showChuckerScreen;
          },
        ),
      },
      child: child,
    );
  }
}
