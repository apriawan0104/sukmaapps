import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sukmaapps/core/core.dart';

import '../../../../app/app.dart';
import '../../../../common/common.dart';
import '../adapter/auth.adapter.dart';

class TermConditionScreen extends StatefulWidget {
  const TermConditionScreen(
      {super.key, required this.mdFileName, this.isButton = false});

  final String mdFileName;
  final bool? isButton;

  @override
  State<TermConditionScreen> createState() => _TermConditionScreenState();
}

class _TermConditionScreenState extends State<TermConditionScreen> {
  final ScrollController _controller = ScrollController();
  late final Future<String> _mdFuture;
  var reachEnd = false;
  var _didCheckScroll = false;

  void _markReachEnd() {
    if (reachEnd || !mounted) return;
    setState(() => reachEnd = true);
  }

  void _listener() {
    if (reachEnd || !_controller.hasClients) return;
    final maxScroll = _controller.position.maxScrollExtent;
    if (_controller.offset >= maxScroll) {
      _markReachEnd();
    }
  }

  // ponytail: short md never scrolls — enable Setuju after first layout if already at end
  void _checkIfAlreadyAtEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_controller.hasClients) return;
      if (_controller.position.maxScrollExtent <= 0) {
        _markReachEnd();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _mdFuture = rootBundle.loadString('assets/${widget.mdFileName}');
    _controller.addListener(_listener);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_listener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIAppBar.appBar(context, title: 'Ketentuan Layanan'),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<String>(
              future: _mdFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (!_didCheckScroll) {
                    _didCheckScroll = true;
                    _checkIfAlreadyAtEnd();
                  }
                  return Markdown(
                    data: snapshot.data!,
                    controller: _controller,
                  );
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
      bottomNavigationBar: (widget.isButton == true)
          ? Consumer(
              builder: (context, ref, child) {
                final ctrl = ref.read(authAdapterProvider.notifier);
                return UIButtonBottomMultipleWidget(
                  leftTitleButton: 'Batal',
                  rightTitleButton: 'Setuju',
                  leftOnPressed: () {
                    Navigator.pop(context);
                  },
                  rightBgColor: AppColor.brPrimaryStrong,
                  rightColor: Colors.white,
                  rightOnPressed: () {
                    ctrl.readTerm();
                  },
                  isRightEnable: reachEnd,
                );
              },
            ).withSafeArea()
          : null,
    );
  }
}
