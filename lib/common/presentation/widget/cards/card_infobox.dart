import 'package:flutter/material.dart';
import 'package:app_core/app_core.dart';

class UICardInfobox extends StatelessWidget {
  const UICardInfobox(
      {super.key,
      required this.colorBorder,
      required this.colorBg,
      required this.widget});
  final Color colorBorder;
  final Color colorBg;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colorBg,
        borderRadius: BorderRadius.all(const Radius.circular(4).w),
        border: Border(
          left: BorderSide(
            color: colorBorder,
            width: 4.w,
          ),
        ),
      ),
      child: Padding(padding: const REdgeInsets.all(12), child: widget),
    );
  }
}
