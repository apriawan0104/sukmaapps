import 'env.constant.dart';
import 'env.extension.dart';
import 'enum.constant.dart';

extension FlavorTypeEnvironment on FlavorType {
  bool get showsEnvBanner => this != FlavorType.prd;

  String get bannerLabel => EnvConstant.environment.env.toUpperCase();
}
