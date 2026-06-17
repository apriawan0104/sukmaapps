import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';
import '../../controller/convert_pulsa.controller.dart';

class NominalInputWidget extends StatelessWidget {
  const NominalInputWidget({
    super.key,
    required this.formKey,
    required this.txtNominal,
    required this.ctrl,
    required this.minConv,
    required this.maxConv,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController txtNominal;
  final ConvertPulsaController ctrl;
  final int minConv;
  final int maxConv;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const REdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nominal Pulsa',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF101828),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            UITextFormFieldWidget(
              messageValidator:
                  'Nominal yang diperbolehkan ${FormatHelper.formatThousandFromNumber(minConv)}\nsampai ${FormatHelper.formatThousandFromNumber(maxConv)}',
              customValidator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nominal harus di isi';
                }
                final pulsa =
                    CalcNominalHelper.parseNominal(txtNominal.text);
                if (pulsa < minConv || pulsa > maxConv) {
                  return 'Nominal yang diperbolehkan ${FormatHelper.formatThousandFromNumber(minConv)}\nsampai ${FormatHelper.formatThousandFromNumber(maxConv)}';
                }
                return null;
              },
              controller: txtNominal,
              hintText: 'Isi Nominal Pulsa',
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                var parsedValue = 0.0;
                if (value.isNotEmpty) {
                  parsedValue = double.parse(value);
                }
                txtNominal.text =
                    FormatHelper.formatThousandFromNumber(parsedValue);
                ctrl.calcNominal(txtNominal.text);
              },
            ),
            SizedBox(height: 4.h),
            UITextPrimaryWidget(
              title: 'Contoh: 100.000',
              fontSize: 12.sp,
              color: AppColor.blackFair,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
