import 'package:flutter/material.dart';
import 'package:sukmaapps/core/core.dart';

import '../widget/widget.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          return Future.value();
        },
        child: SizedBox(
          child: Column(
            children: [
              Text('Home'),
            ],
          ),
        ),
      ).withSafeArea(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingButtonWidget().withSafeArea(),
      bottomNavigationBar: const BottomNavigationWidget().withSafeArea(),
    );
  }
}
