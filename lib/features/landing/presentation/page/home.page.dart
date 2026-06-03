import 'package:flutter/material.dart';

import '../../../../common/common.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIAppBar.appBar(context, title: 'Home'),
      body: Column(
        children: [
          Text('Home'),
        ],
      ),
    );
  }
}
