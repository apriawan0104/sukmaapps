import 'package:equatable/equatable.dart';

class NotificationRouteEntity extends Equatable {
  const NotificationRouteEntity({
    required this.routeName,
    this.pathParameters = const {},
    this.queryParameters = const {},
  });

  final String routeName;
  final Map<String, String> pathParameters;
  final Map<String, String> queryParameters;

  @override
  List<Object?> get props => [routeName, pathParameters, queryParameters];
}
