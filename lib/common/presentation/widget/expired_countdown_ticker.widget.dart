import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/core.dart';
import 'statics/transaction_expired_dialog.widget.dart';

typedef ExpiredCountdownBuilder = Widget Function(
  BuildContext context,
  Duration remaining,
);

class ExpiredCountdownTicker extends StatefulWidget {
  const ExpiredCountdownTicker({
    super.key,
    required this.expiredAt,
    required this.builder,
    this.onExpired,
    this.showExpiredDialog = true,
  });

  final DateTime? expiredAt;
  final ExpiredCountdownBuilder builder;
  final VoidCallback? onExpired;
  final bool showExpiredDialog;

  @override
  State<ExpiredCountdownTicker> createState() => _ExpiredCountdownTickerState();
}

class _ExpiredCountdownTickerState extends State<ExpiredCountdownTicker> {
  Timer? _timer;
  Duration _remaining = Duration.zero;
  bool _hasNotifiedExpired = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant ExpiredCountdownTicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expiredAt != widget.expiredAt) {
      _timer?.cancel();
      _hasNotifiedExpired = false;
      _startTimer();
    }
  }

  void _startTimer() {
    _tick();

    if (CountdownHelper.toLocalExpiredAt(widget.expiredAt) == null) {
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      _tick();
    });
  }

  void _tick() {
    final remaining = CountdownHelper.remainingUntil(widget.expiredAt);

    setState(() => _remaining = remaining);

    if (remaining > Duration.zero || _hasNotifiedExpired) return;

    _hasNotifiedExpired = true;
    _timer?.cancel();
    _handleExpired();
  }

  void _handleExpired() {
    if (!mounted) return;

    if (!widget.showExpiredDialog) {
      widget.onExpired?.call();
      return;
    }

    TransactionExpiredDialog.show(
      context: context,
      onDismissed: widget.onExpired,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _remaining);
  }
}
