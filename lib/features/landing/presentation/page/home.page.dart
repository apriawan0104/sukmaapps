import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;

import '../../../../common/common.dart';
import '../adapter/landing.adapter.dart';
import '../widget/widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(landingRiverpodAdapterProvider);
    final ctrl = ref.read(landingRiverpodAdapterProvider.notifier);

    final informationBanners = state.informationBanner.data
        ?.map((item) => item.description ?? '')
        .where((description) => description.isNotEmpty)
        .toList();

    return Scaffold(
      appBar: UIAppBar.appBar(context, title: 'Home'),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            BannerWidget(
              bannerAsync: state.banner,
              onRetry: ctrl.getBanner,
              onOpenBannerUrl: (url) {
                ctrl.openBannerUrl(url);
                return url;
              },
            ),
            Padding(
              padding: REdgeInsets.all(8.0),
              child: Column(
                children: [
                  TransactionOutstandingWidget(
                    transactionOutstandingAsync: state.outstanding,
                    onRetry: ctrl.getOutstanding,
                    onExpired: ctrl.getOutstanding,
                  ),
                  BannerInformationWidget(listInformation: informationBanners),
                  ProviderRateWidget(
                    rateAsync: state.rate,
                    onTapConvert: () {},
                    onRetry: ctrl.getRate,
                  ),
                ],
              ),
            ),
            const UIKeyPairWidget(),
            const StepTutorialWidget(),
          ],
        ),
      ),
    );
  }
}
