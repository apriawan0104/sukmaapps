import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:sukmaapps/core/core.dart';

import '../../../../common/common.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key, required this.mdFileName});

  final String mdFileName;

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late final Future<String> _mdFuture;

  @override
  void initState() {
    super.initState();
    _mdFuture = rootBundle.loadString('assets/${widget.mdFileName}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIAppBar.appBar(context, title: 'Kebijakan Privasi'),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<String>(
              future: _mdFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Markdown(data: snapshot.data!);
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Gagal memuat konten'));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ).withSafeArea(),
    );
  }
}
