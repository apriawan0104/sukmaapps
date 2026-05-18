import 'package:app_core/app_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/config.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Dengan masuk, anda menyetujui ',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFFA3ACC6),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: 'Ketentuan Layanan',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.goNamed(RouteNames.termCondition);
              },
          ),
          TextSpan(
            text: ' dan ',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFFA3ACC6),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: 'Kebijakan Privasi',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.goNamed(RouteNames.privacyPolicy);
              },
          ),
          TextSpan(
            text: '  yang berlaku',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFFA3ACC6),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
