import '../../core/core.dart';

/// Runtime environment resolved at app startup (from `.env` via [DotenvEnvironmentLoader]).
class EnvironmentConfig {
  EnvironmentConfig._();

  static FlavorType? _current;

  static FlavorType get current {
    final environment = _current;
    if (environment == null) {
      throw StateError(
        'EnvironmentConfig is not initialized. '
        'Call EnvironmentConfig.configure() during app bootstrap.',
      );
    }
    return environment;
  }

  static void configure(FlavorType environment) {
    _current = environment;
  }
}
