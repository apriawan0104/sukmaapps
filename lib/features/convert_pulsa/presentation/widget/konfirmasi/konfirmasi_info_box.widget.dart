import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/common.dart';

class KonfirmasiInfoBoxWidget extends StatelessWidget {
  const KonfirmasiInfoBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return UICardInfobox(
      colorBorder: const Color(0xFFB54708),
      colorBg: const Color(0xFFFEF0C7),
      widget: Row(
        children: [
          Icon(
            Icons.warning_rounded,
            size: 24.sp,
            color: const Color(0xFFB54708),
          ),
          SizedBox(width: 8.w),
          SizedBox(
            width: 283.w,
            child: Text(
              'Sukma Convert tidak menerima pulsa yang berasal dari kegiatan illegal, judi online, kriminal, dll',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFFB54708),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
