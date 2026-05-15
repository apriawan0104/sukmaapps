import 'package:app_core/app_core.dart';

abstract class CommonRepository {
  Future<ValueGuard<String>> getWaNumber(NoParams params);
}
