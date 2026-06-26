import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../adapter/landing.adapter.dart';

class FloatingButtonWidget extends ConsumerWidget {
  const FloatingButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 48.h,
      width: 48.w,
      child: FloatingActionButton(
        onPressed: () {
          ref.read(landingRiverpodAdapterProvider.notifier).convertPulsa();
        },
        tooltip: 'Convert',
        elevation: 6.0,
        backgroundColor: AppColor.brPrimaryStrong,
        child: SvgPicture.asset(
          IconBottomNavConstant.union,
          width: 26.w,
          height: 26.h,
        ),
      ),
    );
  }
}
