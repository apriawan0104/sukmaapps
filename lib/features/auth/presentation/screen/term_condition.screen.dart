import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  var reachEnd = false;

  _listener() {
    final maxScroll = _controller.position.maxScrollExtent;
    if (_controller.offset >= maxScroll) {
      setState(() {
        reachEnd = true;
      });
    }
  }

  @override
  void initState() {
    _controller.addListener(_listener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIAppBar.appBar(context, title: 'Ketentuan Layanan'),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future:
                Future.delayed(const Duration(milliseconds: 150)).then((value) {
              return rootBundle.loadString('assets/${widget.mdFileName}');
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Markdown(
                  data: snapshot.data.toString(),
                  controller: _controller,
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ))
        ],
      ),
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
            )
          : null,
    );
  }
}
