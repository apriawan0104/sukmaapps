import 'enum.constant.dart';

extension FlavorTypeEnvironment on FlavorType {
  bool get showsEnvBanner => this != FlavorType.prd;

  String get bannerLabel => name.toUpperCase();
}
