import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../../core/core.dart';

@module
abstract class SukmaModule {
  bool get _isNonProd => EnvConstant.environment.env != FlavorType.prd.name;

  @lazySingleton
  NetworkConfig get networkConfig => NetworkConfig(
        baseUrl: EnvConstant.baseUrl.env,
        enableLogging: _isNonProd,
        enableHttpInspector: _isNonProd,
      );
}
