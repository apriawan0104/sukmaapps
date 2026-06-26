import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../common/common.dart';
import '../../../domain/entity/entity.dart';
import 'history_card.widget.dart';

class HistoryListWidget extends StatelessWidget {
  const HistoryListWidget({
    super.key,
    required this.historyAsync,
    required this.onRetry,
    required this.onHoldTap,
    required this.onDetailTap,
  });

  final AsyncValue<List<HistoryConvertEntity>> historyAsync;
  final VoidCallback onRetry;
  final Future<void> Function() onHoldTap;
  final void Function(String transNo) onDetailTap;

  Widget _loadingWidget() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFDFD9D9),
      highlightColor: const Color(0xFFF2F2FF),
      child: Padding(
        padding: const REdgeInsets.only(bottom: 16),
        child: SizedBox(
          width: double.infinity,
          height: 72.h,
        ),
      ),
    );
  }

  Widget _historyList(BuildContext context, List<HistoryConvertEntity> data) {
    if (data.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [EmptyScreen()],
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final history = data[index];
        return HistoryCardWidget(
          history: history,
          onTap: () async {
            if (history.isHold == true) {
              await onHoldTap();
              return;
            }

            final transNo = history.noTrans;
            if (transNo == null || transNo.isEmpty) return;
            onDetailTap(transNo);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AsyncValueWidget<List<HistoryConvertEntity>>(
      value: historyAsync,
      loadingWidget: _loadingWidget(),
      errorWidget: (error, stackTrace) => Container(),
      onRetry: onRetry,
      onSuccess: (data) => _historyList(context, data),
    );
  }
}
