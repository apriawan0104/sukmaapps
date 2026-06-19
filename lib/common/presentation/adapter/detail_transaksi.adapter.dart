import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/config.dart';
import '../../domain/domain.dart';
import '../controller/detail_transaksi.controller.dart';

part 'detail_transaksi.adapter.g.dart';

@riverpod
Future<TransferEntity?> getDetailTransaction(
  GetDetailTransactionRef ref, {
  required String transNo,
}) async {
  final useCase = getIt<GetDetailTransactionUseCase>();
  final result = await useCase(GetDetailTransactionParam(transNo: transNo));

  return result.fold(
    (failure) => throw failure.message,
    (entity) => entity,
  );
}

@riverpod
class DetailTransactionController extends _$DetailTransactionController
    implements DetailTransaksiController {
  @override
  FutureOr<void> build() {}

  @override
  Future<void> refreshDetailTrans({required String transNo}) async {
    ref.invalidate(getDetailTransactionProvider(transNo: transNo));
  }
}
