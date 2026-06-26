import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:go_router/go_router.dart';

import '../../../../common/common.dart';
import '../../../../config/config.dart';
import '../../../landing/presentation/adapter/landing.adapter.dart';
import '../adapter/convert_pulsa.adapter.dart';
import '../widget/transfer/transfer.widget.dart';

class TransferPage extends ConsumerStatefulWidget {
  const TransferPage({super.key});

  @override
  ConsumerState<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends ConsumerState<TransferPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(convertPulsaRiverpodAdapterProvider.notifier).loadTransferData();
    });
  }

  Future<void> _onLeaveTransfer() async {
    await ref
        .read(landingRiverpodAdapterProvider.notifier)
        .refreshOutstanding();
    if (!mounted) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(convertPulsaRiverpodAdapterProvider);
    final ctrl = ref.read(convertPulsaRiverpodAdapterProvider.notifier);
    final transferLoadValue =
        state.transferLoadValue ?? const AsyncValue.loading();

    ref.listen(
      convertPulsaRiverpodAdapterProvider.select(
        (value) => value.uploadImageValue,
      ),
      (previous, next) {
        if (next?.hasError == true) {
          StaticWidget.msgToast(next?.error.toString() ?? 'Terjadi kesalahan');
        }
      },
    );

    ref.listen(
      convertPulsaRiverpodAdapterProvider.select(
        (value) => value.deleteImageValue,
      ),
      (previous, next) {
        if (next?.hasError == true) {
          StaticWidget.msgToast(next?.error.toString() ?? 'Terjadi kesalahan');
        }
      },
    );

    Future<void> onDial(TransferEntity transfer) async {
      final dialupCode = transfer.dialupCode;
      if (dialupCode == null || dialupCode.isEmpty) return;

      final urlLauncher = getIt<UrlLauncherService>();
      await urlLauncher.launchPhone(dialupCode.replaceAll('#', '%23'));
    }

    void onCopy(TransferEntity transfer) {
      final dialupCode = transfer.dialupCode ?? '';
      Clipboard.setData(ClipboardData(text: dialupCode));
      StaticWidget.msgToast('Kode Dialup berhasil di copy');
    }

    Future<void> onSubmitEvidence() async {
      await ctrl.submitTransEvidence();
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _onLeaveTransfer();
      },
      child: Scaffold(
        appBar: UIAppBar.appBar(
          context,
          title: 'Transfer Pulsa ke Sukma',
          customBackButton: IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: _onLeaveTransfer,
          ),
        ),
      body: AsyncValueWidget<TransferEntity>(
        value: transferLoadValue,
        onSuccess: (transfer) {
          return Stack(
            children: [
              ListView(
                children: [
                  TransferCodeSectionWidget(
                    transfer: transfer,
                    onDial: () => onDial(transfer),
                    onCopy: () => onCopy(transfer),
                  ),
                  const TransferUploadSectionWidget(),
                  const TransferCancelButtonWidget(),
                  SizedBox(height: 48.h),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: TransferCountdownBarWidget(
                  expiredAt: transfer.expiredAt,
                  onExpired: () {
                    if (!context.mounted) return;
                    context.goNamed(RouteNames.landing);
                  },
                ),
              ),
            ],
          );
        },
        onRetry: ctrl.refreshTransferData,
      ),
      bottomNavigationBar: SafeArea(
        child: AsyncValueWidget<void>(
          value: state.transEvidenceValue ?? const AsyncValue.data(null),
          loadingWidget: Container(
            color: Colors.white,
            child: RPadding.all(
              16,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          onSuccess: (_) {
            return UIButtonBottomWidget(
              titleButton: 'Kirim Bukti Transfer',
              onPressed: onSubmitEvidence,
            );
          },
          onRetry: onSubmitEvidence,
        ),
      ),
      ),
    );
  }
}
