import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../text/text_primary.widget.dart';
import 'card_primary.widget.dart';

class UICardChargeWidget extends StatelessWidget {
  const UICardChargeWidget({super.key, required this.charge});
  final int charge;
  @override
  Widget build(BuildContext context) {
    return UICardPrimaryWidget(
      padding: REdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: (charge == 0) ? AppColor.infoRoot : const Color(0xFFFEF0C7),
      colorSide: (charge == 0) ? AppColor.infoRoot : const Color(0xFFFEF0C7),
      child: Center(
        child: UITextPrimaryWidget(
            title: (charge == 0)
                ? 'Gratis Admin'
                : 'Biaya Rp${FormatHelper.formatThousandFromNumber(charge)}',
            fontSize: 12.sp,
            color: (charge == 0) ? AppColor.infoHeavy : const Color(0xFFB54708),
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
