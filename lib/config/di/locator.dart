import 'package:app_core/app_core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'locator.config.dart';

/// Same [GetIt] singleton as the host app. Registrations run in the shell
/// (`configureDependencies` / injectable), this package only resolves types.
final getIt = GetIt.instance;

@InjectableInit(
  externalPackageModulesBefore: [
    ExternalModule(AppCorePackageModule),
  ],
)
Future<void> configureDependencies() => getIt.init();
