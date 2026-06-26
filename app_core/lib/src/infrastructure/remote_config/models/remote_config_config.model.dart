import 'package:equatable/equatable.dart';

/// Runtime configuration for [RemoteConfigService].
///
/// Host apps provide this via DI to customize fetch behavior and defaults.
class RemoteConfigConfig extends Equatable {
  const RemoteConfigConfig({
    this.fetchTimeout = const Duration(minutes: 1),
    this.minimumFetchInterval = Duration.zero,
    this.defaults = const {},
  });

  /// Maximum time to wait for a fetch request.
  final Duration fetchTimeout;

  /// Minimum interval between fetch requests.
  final Duration minimumFetchInterval;

  /// Default parameter values applied before the first fetch.
  final Map<String, Object> defaults;

  RemoteConfigConfig copyWith({
    Duration? fetchTimeout,
    Duration? minimumFetchInterval,
    Map<String, Object>? defaults,
  }) {
    return RemoteConfigConfig(
      fetchTimeout: fetchTimeout ?? this.fetchTimeout,
      minimumFetchInterval:
          minimumFetchInterval ?? this.minimumFetchInterval,
      defaults: defaults ?? this.defaults,
    );
  }

  @override
  List<Object?> get props => [
        fetchTimeout,
        minimumFetchInterval,
        defaults,
      ];
}
