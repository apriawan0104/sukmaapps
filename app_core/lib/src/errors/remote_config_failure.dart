import 'failures.dart';

/// Base class for remote config failures.
class RemoteConfigFailure extends Failure {
  const RemoteConfigFailure({
    required super.message,
    super.code,
    super.details,
  });
}

/// Failed to initialize remote config.
class RemoteConfigInitializationFailure extends RemoteConfigFailure {
  const RemoteConfigInitializationFailure({
    super.message = 'Failed to initialize remote config.',
    super.code,
    super.details,
  });
}

/// Failed to fetch or activate remote config values.
class RemoteConfigFetchFailure extends RemoteConfigFailure {
  const RemoteConfigFetchFailure({
    super.message = 'Failed to fetch remote config.',
    super.code,
    super.details,
  });
}

/// Failed to read a remote config value.
class RemoteConfigReadFailure extends RemoteConfigFailure {
  const RemoteConfigReadFailure({
    super.message = 'Failed to read remote config value.',
    super.code,
    super.details,
  });
}
