import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sukmaapps/core/core.dart';

import '../../../../app/app.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      width: 48.w,
      child: FloatingActionButton(
        onPressed: () {
          // ctrlButton.btnConvert(context);
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
