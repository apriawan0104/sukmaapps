import '../constants/constants.dart';

/// Runtime network settings supplied by the host app before DI init.
class NetworkConfig {
  const NetworkConfig({
    required this.baseUrl,
    this.enableLogging = false,
    this.enableHttpInspector = false,
    this.headers,
    this.connectTimeout = NetworkConstants.defaultConnectTimeout,
    this.receiveTimeout = NetworkConstants.defaultReceiveTimeout,
    this.sendTimeout = NetworkConstants.defaultSendTimeout,
  });

  final String baseUrl;
  final bool enableLogging;
  final bool enableHttpInspector;
  final Map<String, dynamic>? headers;
  final int connectTimeout;
  final int receiveTimeout;
  final int sendTimeout;
}
