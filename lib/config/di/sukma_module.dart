import 'package:app_core/app_core.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../core/core.dart';

@module
abstract class SukmaModule {
  bool get _isNonProd => EnvConstant.environment.env != FlavorType.prd.name;

  @lazySingleton
  NetworkConfig get networkConfig => NetworkConfig(
        baseUrl: EnvConstant.baseUrl.env,
        enableLogging: _isNonProd,
        dioInterceptors:
            _isNonProd ? [ChuckerDioInterceptor()] : const [],
      );
}
