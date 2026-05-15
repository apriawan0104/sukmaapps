import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

class UICardPrimaryWidget extends StatelessWidget {
  const UICardPrimaryWidget({
    super.key,
    this.width,
    this.height,
    this.padding,
    required this.child,
    this.color = Colors.white,
    this.colorSide,
    this.borderRadius,
  });

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final Color? color;
  final Color? colorSide;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? REdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.w, color: colorSide ?? const Color(0xFFDADCE9)),
          borderRadius: borderRadius ?? BorderRadius.circular(10).w,
        ),
      ),
      child: child,
    );
  }
}
