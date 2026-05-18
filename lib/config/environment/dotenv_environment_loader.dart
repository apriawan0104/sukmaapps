import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../core/core.dart';
import 'environment_config.dart';

/// Loads [FlavorType] from dotenv. Keep dotenv usage limited to bootstrap code.
FlavorType loadEnvironmentFromDotenv() {
  final raw = dotenv.env[EnvConstant.environment];
  if (raw == null || raw.isEmpty) {
    throw StateError(
      'Missing "${EnvConstant.environment}" in the loaded .env file.',
    );
  }

  final normalized = raw.toLowerCase();
  for (final flavor in FlavorType.values) {
    if (flavor.name == normalized) {
      return flavor;
    }
  }

  throw ArgumentError(
    'Unknown environment "$raw". Expected one of: '
    '${FlavorType.values.map((e) => e.name).join(', ')}.',
  );
}

void configureEnvironmentFromDotenv() {
  EnvironmentConfig.configure(loadEnvironmentFromDotenv());
}
