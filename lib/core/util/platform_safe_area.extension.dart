import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Platform-aware [SafeArea] wrapper for any [Widget].
///
/// Applies [SafeArea] on Android only. On iOS and other platforms, returns
/// [this] unchanged so layout stays under your control.
///
/// ```dart
/// Column(
///   children: [...],
/// ).withSafeArea()
///
/// Center(child: Text('Hello')).withSafeArea(bottom: false)
/// ```
extension PlatformSafeAreaExtension on Widget {
  /// Wraps [this] with [SafeArea] when running on Android.
  ///
  /// Set [enabled] to `false` to skip wrapping on any platform.
  /// Other parameters mirror [SafeArea] and only apply on Android.
  Widget withSafeArea({
    bool enabled = true,
    bool top = true,
    bool left = true,
    bool right = true,
    bool bottom = true,
    EdgeInsets minimum = EdgeInsets.zero,
    bool maintainBottomViewPadding = false,
  }) {
    if (!enabled || defaultTargetPlatform != TargetPlatform.android) {
      return this;
    }

    return SafeArea(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      minimum: minimum,
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: this,
    );
  }
}
