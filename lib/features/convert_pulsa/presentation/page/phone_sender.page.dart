import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:go_router/go_router.dart';

import '../../../../common/common.dart';
import '../../../../config/config.dart';
import '../adapter/convert_pulsa.adapter.dart';
import '../widget/widget.dart';

class PhoneSenderPage extends ConsumerWidget {
  const PhoneSenderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(convertPulsaRiverpodAdapterProvider);
    final ctrl = ref.read(convertPulsaRiverpodAdapterProvider.notifier);

    return Scaffold(
      appBar: UIAppBar.appBar(context, title: 'Isi Nomor Pengirim'),
      body: Column(
        children: [
          AddPhoneSenderWidget(
            ctrl: ctrl,
            choosePhone: state.choosePhone,
            chooseProviderName: state.chooseProviderName?.name,
          ),
          const UIKeyPairWidget(),
          Expanded(
            child: ListView(
              children: [
                PhoneFavoriteWidget(
                  ctrl: ctrl,
                  phoneFavValue:
                      state.phoneFavValue ?? const AsyncValue.loading(),
                  choosePhone: state.choosePhone,
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
            if (state.choosePhone == null) {
              StaticWidget.msgToast('Pilih No Pengirim terlebih dahulu');
            } else {
              context.go(RouteNames.nominal);
            }
          },
        ),
      ),
    );
  }
}
