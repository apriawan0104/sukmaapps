import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:sukmaapps/common/common.dart';

import '../guard/convert_pulsa_navigation.dart';

@LazySingleton(as: ConvertPulsaNavigator)
class ConvertPulsaNavigatorImpl implements ConvertPulsaNavigator {
  @override
  Future<void> goToPhone(BuildContext context) =>
      ConvertPulsaNavigation.goToPhone(context);
}
