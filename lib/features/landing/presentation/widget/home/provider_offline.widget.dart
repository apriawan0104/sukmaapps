import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';

class ProviderOfflineWidget extends StatelessWidget {
  const ProviderOfflineWidget({super.key, required this.listProvider});
  final String listProvider;

  @override
  Widget build(BuildContext context) {
    return UICardInfobox(
      colorBorder: AppColor.orangeInfoBoxAccent,
      colorBg: AppColor.orangeInfoBoxServiceOffline,
      widget: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info,
            color: AppColor.orangeFontServiceOffline,
          ),
          SizedBox(
            width: 8.w,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Provider sedang tidak aktif',
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColor.orangeFontServiceOffline,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  listProvider,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColor.dottedBorder,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.3,
                    height: 1.4,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
