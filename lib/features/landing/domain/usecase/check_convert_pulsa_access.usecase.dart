import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/common.dart';
import '../entity/entity.dart';
import 'check_status_app.usecase.dart';

@lazySingleton
class CheckConvertPulsaAccessUseCase
    extends UseCaseAsync<ConvertPulsaAccessResult, NoParams> {
  CheckConvertPulsaAccessUseCase(
    this._checkStatusAppUseCase,
    this._getOutstandingUseCase,
  );

  final CheckStatusAppUseCase _checkStatusAppUseCase;
  final GetOutstandingUseCase _getOutstandingUseCase;

  @override
  Future<ValueGuard<ConvertPulsaAccessResult>> call(NoParams params) async {
    final statusResult = await _checkStatusAppUseCase(params);

    if (statusResult.isFailure) {
      return ValueGuards.failure(statusResult.failureOrNull!);
    }

    final statusBlock = statusResult.valueOrNull!.statusBlockReason;
    if (statusBlock != null) {
      return ValueGuards.success(statusBlock);
    }

    final outstandingResult = await _getOutstandingUseCase(params);
    if (outstandingResult.isFailure) {
      return ValueGuards.failure(outstandingResult.failureOrNull!);
    }

    return ValueGuards.success(
      outstandingResult.valueOrNull != null
          ? ConvertPulsaAccessResult.hasOutstanding
          : ConvertPulsaAccessResult.allowed,
    );
  }
}
