import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:go_router/go_router.dart';

import '../../../../common/common.dart';
import '../../../../config/config.dart';
import '../adapter/convert_pulsa.adapter.dart';
import '../widget/konfirmasi/konfirmasi.widget.dart';

class KonfirmasiPage extends ConsumerWidget {
  const KonfirmasiPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(convertPulsaRiverpodAdapterProvider);
    final ctrl = ref.read(convertPulsaRiverpodAdapterProvider.notifier);
    final provider = state.chooseProviderName;
    final nominalTerima = state.calcNominalValue?.value ?? 0;

    ref.listen(
      convertPulsaRiverpodAdapterProvider.select(
        (value) => value.saveTransKonfirmValue,
      ),
      (previous, next) {
        if (next?.hasError == true) {
          StaticWidget.msgToast(next?.error.toString() ?? 'Terjadi kesalahan');
        }
      },
    );

    Future<void> onSaveTrans() async {
      await ctrl.saveTransKonfirm();
      if (!context.mounted) return;

      final updated = ref.read(convertPulsaRiverpodAdapterProvider);
      if (updated.transferData != null) {
        context.go(RouteNames.transfer);
      }
    }

    return Scaffold(
      appBar: UIAppBar.appBar(context, title: 'Konfirmasi'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                KonfirmasiPhoneWidget(
                  choosePhone: state.choosePhone,
                  providerName: provider?.name,
                ),
                const UIKeyPairWidget(),
                KonfirmasiPulsaWidget(
                  nominalPulsa: state.nominalPulsa,
                  nominalTerima: nominalTerima,
                ),
                const UIKeyPairWidget(),
                KonfirmasiRekeningWidget(
                  chooseBankName: state.chooseBankName,
                  chooseOtherBankName: state.chooseOtherBankName,
                  chooseBankCharge: state.chooseBankCharge,
                  chooseAccountName: state.chooseAccountName,
                  chooseAccountNumber: state.chooseAccountNumber,
                  nominalTerima: nominalTerima,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: AsyncValueWidget<void>(
          value: state.saveTransKonfirmValue ?? const AsyncValue.data(null),
          loadingWidget: RPadding.all(
            16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  height: 1.h,
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: 16.h),
                SizedBox(height: 16.h),
                Container(
                  color: Colors.white,
                  child: RPadding.all(
                    16,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          onSuccess: (_) {
            return UIButtonBottomWidget(
              widgetInfo: const KonfirmasiInfoBoxWidget(),
              titleButton: 'Lanjutkan Transfer Pulsa',
              onPressed: onSaveTrans,
            );
          },
          onRetry: onSaveTrans,
        ),
      ),
    );
  }
}
