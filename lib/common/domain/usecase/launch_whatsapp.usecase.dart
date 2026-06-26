import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import 'package:sukmaapps/core/core.dart';

import '../param/launch_whatsapp.param.dart';
import 'get_wa_number.usecase.dart';

@lazySingleton
class LaunchWhatsappUseCase extends UseCaseAsync<void, LaunchWhatsappParam> {
  LaunchWhatsappUseCase(
    this._getWaNumberUseCase,
    this._urlLauncherService,
  );

  final GetWaNumberUseCase _getWaNumberUseCase;
  final UrlLauncherService _urlLauncherService;

  @override
  Future<ValueGuard<void>> call(LaunchWhatsappParam params) async {
    var waNumber = EnvConstant.csPhone.env;
    if (waNumber == '-') {
      return ValueGuards.success(null);
    }

    final waResult = await _getWaNumberUseCase(NoParams());
    waResult.fold(
      (_) {},
      (number) {
        if (number.isNotEmpty) {
          waNumber = number;
        }
      },
    );

    if (waNumber.startsWith('0')) {
      waNumber = '62${waNumber.substring(1)}';
    }

    final url =
        'https://wa.me/$waNumber?text=${Uri.encodeComponent(params.body)}';
    await _urlLauncherService.launchWebUrl(url);
    return ValueGuards.success(null);
  }
}
