import 'package:app_core/app_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/landing/presentation/adapter/landing.adapter.dart';
import '../adapter/detail_transaksi.adapter.dart';
import '../../domain/usecase/has_active_session.usecase.dart';
import '../../../config/config.dart';

Future<void> refreshDataAfterNotificationOpened(Ref ref) async {
  final useCase = getIt<HasActiveSessionUseCase>();
  final result = await useCase(NoParams());

  final hasSession = result.fold((_) => false, (value) => value);
  if (!hasSession) {
    return;
  }

  ref.invalidate(getDetailTransactionProvider);

  if (ref.exists(landingRiverpodAdapterProvider)) {
    await ref.read(landingRiverpodAdapterProvider.notifier).getHistoryConvert();
  }
}
