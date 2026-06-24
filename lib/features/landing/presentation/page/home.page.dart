import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/common.dart';
import '../../../../core/core.dart';
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
      appBar: AppBar(
        centerTitle: false,
        leading: Padding(
          padding: REdgeInsets.only(left: 16),
          child: SizedBox(
            height: 40.h,
            width: 40.w,
            child: Padding(
              padding: REdgeInsets.all(4.0),
              child: Image.asset(
                IconSharedConstant.logoPng,
              ),
            ),
          ),
        ),
        title: Text(
          'Sukma Convert Pulsa',
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF164994),
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
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
