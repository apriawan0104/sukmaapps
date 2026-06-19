import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:go_router/go_router.dart';

import '../../../../common/common.dart';
import '../../../../config/config.dart';
import '../adapter/convert_pulsa.adapter.dart';
import '../widget/widget.dart';

class RekeningPage extends ConsumerStatefulWidget {
  const RekeningPage({super.key});

  @override
  ConsumerState<RekeningPage> createState() => _RekeningPageState();
}

class _RekeningPageState extends ConsumerState<RekeningPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(convertPulsaRiverpodAdapterProvider.notifier).getRekeningFav();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(convertPulsaRiverpodAdapterProvider);
    final ctrl = ref.read(convertPulsaRiverpodAdapterProvider.notifier);

    return Scaffold(
      appBar: UIAppBar.appBar(context, title: 'Isi Penerima Dana'),
      body: Column(
        children: [
          AddRekeningReceiverWidget(
            ctrl: ctrl,
            chooseBankId: state.chooseBankId,
            chooseBankName: state.chooseBankName,
            chooseBankCharge: state.chooseBankCharge,
            chooseOtherBankName: state.chooseOtherBankName,
            chooseAccountNumber: state.chooseAccountNumber,
            chooseAccountName: state.chooseAccountName,
          ),
          const UIKeyPairWidget(),
          Expanded(
            child: ListView(
              children: [
                RekeningFavoriteWidget(
                  ctrl: ctrl,
                  rekeningFavValue:
                      state.rekeningFavValue ?? const AsyncValue.loading(),
                  chooseBankId: state.chooseBankId,
                  chooseBankName: state.chooseBankName,
                  chooseBankCharge: state.chooseBankCharge,
                  chooseOtherBankName: state.chooseOtherBankName,
                  chooseAccountNumber: state.chooseAccountNumber,
                  chooseAccountName: state.chooseAccountName,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: UIButtonBottomWidget(
          titleButton: 'Lanjutkan',
          onPressed: () {
            if (state.chooseBankId == null) {
              StaticWidget.msgToast('Pilih rekening terlebih dahulu');
            } else {
              context.goNamed(RouteNames.konfirmasi);
            }
          },
        ),
      ),
    );
  }
}
