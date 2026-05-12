import 'package:app_core/app_core.dart';
import '../model/model.dart';

abstract class CommonRemoteDataSource {
  Future<ValueGuard<TransferModel>> getListTransfer(NoParams params);
}
