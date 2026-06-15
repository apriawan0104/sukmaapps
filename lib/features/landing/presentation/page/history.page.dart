import 'package:flutter/material.dart';

import '../../../../common/common.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIAppBar.appBar(
        context,
        title: 'Riwayat',
        customBackButton: const SizedBox(),
      ),
      body: const SizedBox.expand(),
    );
  }
}
