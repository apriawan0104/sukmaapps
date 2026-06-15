import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:sukmaapps/core/core.dart';

import '../adapter/landing.adapter.dart';
import '../page/page.dart';
import '../widget/widget.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({super.key});

  static const int _tabCount = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(landingRiverpodAdapterProvider);
    final ctrl = ref.read(landingRiverpodAdapterProvider.notifier);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ctrl.loadInitial,
        child: IndexedStack(
          index: state.indexNav.clamp(0, _tabCount - 1),
          sizing: StackFit.expand,
          children: [
            const HomePage(),
            const HistoryPage(),
            const SizedBox.expand(),
            const InformationPage(),
            ProfilePage(ctrl: ctrl),
          ],
        ),
      ).withSafeArea(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingButtonWidget(),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
