import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:go_router/go_router.dart';

import '../../../../common/common.dart';
import '../../../../config/config.dart';
import '../adapter/convert_pulsa.adapter.dart';
import '../widget/top_up_credit/nominal_info.widget.dart';
import '../widget/top_up_credit/nominal_input.widget.dart';

class TopUpCreditPage extends ConsumerStatefulWidget {
  const TopUpCreditPage({super.key});

  @override
  ConsumerState<TopUpCreditPage> createState() => _TopUpCreditPageState();
}

class _TopUpCreditPageState extends ConsumerState<TopUpCreditPage> {
  final TextEditingController _txtNominal = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _txtNominal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(convertPulsaRiverpodAdapterProvider);
    final ctrl = ref.read(convertPulsaRiverpodAdapterProvider.notifier);
    final provider = state.chooseProviderName;

    return Scaffold(
      appBar: UIAppBar.appBar(context, title: 'Isi Nominal Pulsa'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            NominalInputWidget(
              formKey: _formKey,
              txtNominal: _txtNominal,
              ctrl: ctrl,
              minConv: provider?.minConvert ?? 0,
              maxConv: provider?.maksConvert ?? 0,
            ),
            const UIKeyPairWidget(),
            NominalInfoWidget(
              ctrl: ctrl,
              calcNominalValue:
                  state.calcNominalValue ?? const AsyncValue.data(0),
              providerName: provider?.name ?? '',
              rate: provider?.rate ?? '',
              nominalText: _txtNominal.text,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: UIButtonBottomWidget(
          titleButton: 'Lanjutkan',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (_txtNominal.text != '0' && _txtNominal.text.isNotEmpty) {
                ctrl.saveNominal(_txtNominal.text);
                context.goNamed(RouteNames.rekening);
              } else {
                StaticWidget.msgToast('Pilih Nominal terlebih dahulu');
              }
            }
          },
        ),
      ),
    );
  }
}
