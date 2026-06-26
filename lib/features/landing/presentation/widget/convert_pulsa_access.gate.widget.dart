import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/di/locator.dart';
import '../guard/convert_pulsa_access.guard.dart';

/// Validates convert access before showing [child].
///
/// Pass [accessPreValidated] when the caller already ran [ConvertPulsaAccessGuard]
/// (e.g. landing FAB) to skip a duplicate API round-trip.
class ConvertPulsaAccessGate extends ConsumerStatefulWidget {
  const ConvertPulsaAccessGate({
    super.key,
    required this.child,
    this.accessPreValidated = false,
  });

  final Widget child;
  final bool accessPreValidated;

  @override
  ConsumerState<ConvertPulsaAccessGate> createState() =>
      _ConvertPulsaAccessGateState();
}

class _ConvertPulsaAccessGateState extends ConsumerState<ConvertPulsaAccessGate> {
  bool _accessGranted = false;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _validateAccess());
  }

  Future<void> _validateAccess() async {
    if (widget.accessPreValidated) {
      if (!mounted) return;
      setState(() {
        _accessGranted = true;
        _isChecking = false;
      });
      return;
    }

    final isAllowed = await getIt<ConvertPulsaAccessGuard>().ensureAccess();

    if (!mounted) return;

    if (!isAllowed) {
      context.pop();
      return;
    }

    setState(() {
      _accessGranted = true;
      _isChecking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking || !_accessGranted) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return widget.child;
  }
}
