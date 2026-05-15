import '../core.dart';

class IconProviderHelper {
  IconProviderHelper(this.nameProvider);
  final String nameProvider;

  String getIconProvider() {
    if (nameProvider.toLowerCase() == 'telkomsel') {
      return IconProviderConstant.telkomsel_40;
    }
    if (nameProvider.toLowerCase() == 'xl') {
      return IconProviderConstant.xl_40;
    }
    if (nameProvider.toLowerCase() == 'indosat') {
      return IconProviderConstant.indosat_40;
    }
    if (nameProvider.toLowerCase() == 'axis') {
      return IconProviderConstant.axis_40;
    }
    if (nameProvider.toLowerCase() == 'three') {
      return IconProviderConstant.three_40;
    }
    if (nameProvider.toLowerCase() == 'smartfren') {
      return IconProviderConstant.smartfren_40;
    }
    return IconProviderConstant.three_40;
  }
}
