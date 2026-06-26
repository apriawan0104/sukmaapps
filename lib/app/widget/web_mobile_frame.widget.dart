import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Constrains [child] to a fixed mobile viewport on web.
///
/// The browser area outside the frame is filled with [backgroundColor] so the
/// in-app UI matches mobile layout while the page background stays covered.
class WebMobileFrame extends StatelessWidget {
  const WebMobileFrame({
    required this.child,
    required this.frameSize,
    this.backgroundColor = const Color(0xFFF8F8FC),
    super.key,
  });

  final Widget child;
  final Size frameSize;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scale = math
            .min(
              constraints.maxWidth / frameSize.width,
              constraints.maxHeight / frameSize.height,
            )
            .clamp(0.0, 1.0);

        return ColoredBox(
          color: backgroundColor,
          child: Center(
            child: Transform.scale(
              scale: scale,
              child: SizedBox(
                width: frameSize.width,
                height: frameSize.height,
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    size: frameSize,
                    textScaler: TextScaler.noScaling,
                    padding: EdgeInsets.zero,
                    viewPadding: EdgeInsets.zero,
                  ),
                  child: ClipRect(child: child),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
