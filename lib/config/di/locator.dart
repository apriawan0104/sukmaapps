import 'package:get_it/get_it.dart';

/// Same [GetIt] singleton as the host app. Registrations run in the shell
/// (`configureDependencies` / injectable), this package only resolves types.
final getIt = GetIt.instance;
