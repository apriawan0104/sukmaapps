import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:go_router/go_router.dart';

import '../../../../app/app.dart';
import '../../../../common/common.dart';
import '../../../../config/config.dart';
import '../adapter/landing.adapter.dart';
import '../widget/history/history_list.widget.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(landingRiverpodAdapterProvider);
    final ctrl = ref.read(landingRiverpodAdapterProvider.notifier);

    return Scaffold(
      appBar: UIAppBar.appBar(
        context,
        title: 'History Transaction',
        customBackButton: const SizedBox(),
      ),
      backgroundColor: AppColor.whiteHeavy,
      body: RPadding.all(
        16,
        child: HistoryListWidget(
          historyAsync: state.historyConvert,
          onRetry: ctrl.getHistoryConvert,
          onHoldTap: () async {
            await context.pushNamed(RouteNames.statusTransaksi);
            if (!context.mounted) return;
            await ctrl.getHistoryConvert();
          },
          onDetailTap: (transNo) {
            context.goNamed(
              RouteNames.detailHistory,
              extra: DetailTransaksiArg(
                transNo: transNo,
                isFromHistory: true,
              ),
            );
          },
        ),
      ),
    );
  }
}