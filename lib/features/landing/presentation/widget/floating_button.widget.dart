import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sukmaapps/core/core.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      width: 48.w,
      child: FloatingActionButton(
        onPressed: () {
          context.pushNamed(RouteNames.phone);
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
