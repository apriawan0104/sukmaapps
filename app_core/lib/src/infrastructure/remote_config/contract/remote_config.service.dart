import 'package:dartz/dartz.dart';

import '../../../errors/remote_config_failure.dart';

/// Generic remote config service contract.
///
/// Wraps Firebase Remote Config (or any provider) without exposing SDK types.
abstract class RemoteConfigService {
  /// Applies [RemoteConfigConfig], sets defaults, and fetches remote values.
  Future<Either<RemoteConfigFailure, void>> initialize();

  /// Fetches and activates the latest remote config values.
  Future<Either<RemoteConfigFailure, void>> fetchAndActivate();

  /// Reads a string parameter by [key].
  Future<Either<RemoteConfigFailure, String>> getString(String key);

  /// Reads a bool parameter by [key].
  Future<Either<RemoteConfigFailure, bool>> getBool(String key);

  /// Reads an int parameter by [key].
  Future<Either<RemoteConfigFailure, int>> getInt(String key);

  /// Reads a double parameter by [key].
  Future<Either<RemoteConfigFailure, double>> getDouble(String key);
}
