import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:sukmaapps/core/core.dart';

import '../adapter/landing.adapter.dart';
import '../widget/widget.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(landingRiverpodAdapterProvider);
    final ctrl = ref.read(landingRiverpodAdapterProvider.notifier);
    ctrl.getBanner();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          return Future.value();
        },
        child: SizedBox(
          child: Column(
            children: [
              BannerWidget(
                bannerAsync: state.banner,
                onRetry: () {
                  ctrl.getBanner();
                },
                onOpenBannerUrl: (url) {
                  ctrl.openBannerUrl(url);
                },
              ),
            ],
          ),
        ),
      ).withSafeArea(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingButtonWidget(),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
