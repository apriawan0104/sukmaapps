import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/common.dart';
import '../../../../../core/core.dart';
import '../../controller/convert_pulsa.controller.dart';

class ChangeNominalBottomSheetWidget {
  static Future<void> show({
    required BuildContext context,
    required WidgetRef ref,
    required ConvertPulsaController ctrl,
    required String initialNominal,
    required String providerName,
    required String rate,
  }) async {
    final GlobalKey builderKey = GlobalKey();
    final txtNominal = TextEditingController(text: initialNominal);
    final indexCard = ValueNotifier<int>(0);
    final nominalReceived = ValueNotifier<double>(
      CalcNominalHelper.fromRate(
        rate: rate,
        nominal: CalcNominalHelper.parseNominal(initialNominal),
      ),
    );

    void calculateNominal() {
      if (txtNominal.text.isEmpty) {
        txtNominal.text = '0';
      }
      final nominal =
          CalcNominalHelper.parseNominal(txtNominal.text.replaceAll('.', ''));
      nominalReceived.value = CalcNominalHelper.fromRate(
        rate: rate,
        nominal: nominal,
      );
    }

    Widget cardNominal({required String nominal, required int indexId}) {
      return UICardPrimaryWidget(
        width: 103.67.w,
        color: (indexCard.value == indexId) ? const Color(0xFFEFEFF7) : null,
        colorSide: (indexCard.value == indexId) ? const Color(0xFF164994) : null,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            nominal,
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF101828),
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    Widget section() {
      return Padding(
        padding: const REdgeInsets.all(16),
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
                calculateNominal();
              },
            ),
          ],
        ),
      );
    }

    Widget infoBox() {
      return UICardInfobox(
        colorBorder: const Color(0xFF175CD3),
        colorBg: const Color(0xFFD1E9FF),
        widget: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info,
                  size: 18.sp,
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    'Rate $providerName $rate',
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF101828),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            ValueListenableBuilder<double>(
              valueListenable: nominalReceived,
              builder: (context, value, child) {
                return Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Anda akan mendapatkan uang sebesar ',
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF344054),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: FormatHelper.formatThousandFromNumber(value),
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF344054),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    Widget sectionListNominal() {
      return ValueListenableBuilder<int>(
        valueListenable: indexCard,
        builder: (context, value, child) {
          return Padding(
            padding: const REdgeInsets.all(16),
            child: Column(
              children: [
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 2,
                  children: [
                    InkWell(
                      onTap: () {
                        txtNominal.text = '25.000';
                        indexCard.value = 1;
                        calculateNominal();
                      },
                      child: cardNominal(nominal: '25.000', indexId: 1),
                    ),
                    InkWell(
                      onTap: () {
                        txtNominal.text = '50.000';
                        indexCard.value = 2;
                        calculateNominal();
                      },
                      child: cardNominal(nominal: '50.000', indexId: 2),
                    ),
                    InkWell(
                      onTap: () {
                        txtNominal.text = '100.000';
                        indexCard.value = 3;
                        calculateNominal();
                      },
                      child: cardNominal(nominal: '100.000', indexId: 3),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ValueListenableBuilder<double>(
                  valueListenable: nominalReceived,
                  builder: (context, received, child) {
                    if (indexCard.value <= 0 && received <= 0) {
                      return const SizedBox.shrink();
                    }
                    return infoBox();
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    final item = Wrap(
      children: [
        StatefulBuilder(
          key: builderKey,
          builder: (context, setStateBuilder) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  SizedBox(
                    height: 0.4.sh,
                    child: ListView(
                      children: [
                        section(),
                        const UIKeyPairWidget(),
                        sectionListNominal(),
                      ],
                    ),
                  ),
                  UIButtonBottomWidget(
                    titleButton: 'Simpan Nominal',
                    onPressed: () {
                      if (txtNominal.text != '0' &&
                          txtNominal.text.isNotEmpty) {
                        ctrl.saveNominal(txtNominal.text);
                        ctrl.calcNominal(txtNominal.text);
                        context.pop();
                      } else {
                        StaticWidget.msgToast(
                          'Pilih Nominal terlebih dahulu',
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );

    await StaticWidget.modalBottomWidget(
      context: context,
      widget: item,
    );

    txtNominal.dispose();
    indexCard.dispose();
    nominalReceived.dispose();
  }
}
