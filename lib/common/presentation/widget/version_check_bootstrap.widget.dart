import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/version_check.service.dart';

/// Initializes remote config and prompts the user when a newer app version exists.
class VersionCheckBootstrap extends ConsumerWidget {
  const VersionCheckBootstrap({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(versionCheckProvider);
    return child;
  }
}
