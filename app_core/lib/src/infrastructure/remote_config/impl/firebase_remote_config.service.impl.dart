import 'package:dartz/dartz.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../../errors/remote_config_failure.dart';
import '../contract/contracts.dart';
import '../models/models.dart';

/// Firebase Remote Config implementation of [RemoteConfigService].
class FirebaseRemoteConfigServiceImpl implements RemoteConfigService {
  FirebaseRemoteConfigServiceImpl({
    required RemoteConfigConfig config,
    FirebaseRemoteConfig? remoteConfig,
  })  : _config = config,
        _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  final RemoteConfigConfig _config;
  final FirebaseRemoteConfig _remoteConfig;

  @override
  Future<Either<RemoteConfigFailure, void>> initialize() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: _config.fetchTimeout,
          minimumFetchInterval: _config.minimumFetchInterval,
        ),
      );

      if (_config.defaults.isNotEmpty) {
        await _remoteConfig.setDefaults(_config.defaults);
      }

      await _remoteConfig.fetchAndActivate();
      return const Right(null);
    } catch (error) {
      return Left(
        RemoteConfigInitializationFailure(
          message: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<RemoteConfigFailure, void>> fetchAndActivate() async {
    try {
      await _remoteConfig.fetchAndActivate();
      return const Right(null);
    } catch (error) {
      return Left(
        RemoteConfigFetchFailure(
          message: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<RemoteConfigFailure, String>> getString(String key) async {
    return _readValue(() => _remoteConfig.getString(key));
  }

  @override
  Future<Either<RemoteConfigFailure, bool>> getBool(String key) async {
    return _readValue(() => _remoteConfig.getBool(key));
  }

  @override
  Future<Either<RemoteConfigFailure, int>> getInt(String key) async {
    return _readValue(() => _remoteConfig.getInt(key));
  }

  @override
  Future<Either<RemoteConfigFailure, double>> getDouble(String key) async {
    return _readValue(() => _remoteConfig.getDouble(key));
  }

  Future<Either<RemoteConfigFailure, T>> _readValue<T>(T Function() reader) async {
    try {
      return Right(reader());
    } catch (error) {
      return Left(
        RemoteConfigReadFailure(
          message: error.toString(),
        ),
      );
    }
  }
}
