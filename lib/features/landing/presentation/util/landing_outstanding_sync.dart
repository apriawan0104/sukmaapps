import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../adapter/landing.adapter.dart';

/// Refreshes outstanding from API when landing is still mounted
/// (e.g. back from transfer opened via [pushNamed]).
Future<void> syncLandingOutstandingIfActive(Ref ref) async {
  if (!ref.exists(landingRiverpodAdapterProvider)) return;
  await ref.read(landingRiverpodAdapterProvider.notifier).refreshOutstanding();
}

/// Clears outstanding locally — no API after cancel/submit success.
void clearLandingOutstandingIfActive(Ref ref) {
  if (!ref.exists(landingRiverpodAdapterProvider)) return;
  ref.read(landingRiverpodAdapterProvider.notifier).clearOutstanding();
}
