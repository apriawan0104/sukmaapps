import 'package:app_core/app_core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../../../app/app.dart';

class UICardDottedWidget extends StatelessWidget {
  const UICardDottedWidget({
    super.key,
    this.width,
    this.height,
    this.padding,
    required this.child,
    this.color = Colors.white,
    this.colorSide,
    this.dottedBorder = false,
  });

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final Color? color;
  final Color? colorSide;
  final bool dottedBorder;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: colorSide ?? AppColor.dottedBorder,
      strokeWidth: 2.w,
      dashPattern: const [3, 3],
      radius: const Radius.circular(10).w,
      padding: EdgeInsets.zero,
      borderType: BorderType.RRect,
      child: Container(
        width: width,
        height: height,
        padding: padding ?? REdgeInsets.all(16),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(const Radius.circular(10).w)),
        child: child,
      ),
    );
  }
}
