import 'dart:convert';

import 'package:app_core/app_core.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../domain/entity/notification_route.entity.dart';

NotificationRouteEntity? parseNotificationRoute(
  Map<String, dynamic>? data,
) {
  final resolvedData = _resolveNotificationData(data);
  if (resolvedData == null || resolvedData.isEmpty) {
    return null;
  }

  final layoutRaw = resolvedData[FirebaseConstant.layout];
  if (layoutRaw == null) {
    return null;
  }

  try {
    final layoutMap = layoutRaw is String
        ? json.decode(layoutRaw) as Map<String, dynamic>
        : Map<String, dynamic>.from(layoutRaw as Map);

    final routeName = layoutMap[FirebaseConstant.routeName] as String?;
    if (routeName == null || routeName.isEmpty) {
      return null;
    }

    final pathParameters = <String, String>{};
    final queryParameters = <String, String>{};

    final pathData = layoutMap[FirebaseConstant.pathParameter];
    if (pathData is Map) {
      pathData.forEach((key, value) {
        if (value != null) {
          pathParameters['$key'] = '$value';
        }
      });
    }

    final queryData = layoutMap[FirebaseConstant.queryParameter];
    if (queryData is Map) {
      queryData.forEach((key, value) {
        if (value != null) {
          queryParameters['$key'] = '$value';
        }
      });
    }

    return NotificationRouteEntity(
      routeName: routeName,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
    );
  } catch (_) {
    return null;
  }
}

void navigateFromNotification(NotificationDataEntity notification) {
  final route = parseNotificationRoute(notification.data);
  if (route == null) {
    return;
  }

  appRouter.goNamed(
    route.routeName,
    pathParameters: route.pathParameters,
    queryParameters: route.queryParameters,
  );
}

Map<String, dynamic>? _resolveNotificationData(Map<String, dynamic>? data) {
  if (data == null || data.isEmpty) {
    return null;
  }

  final payload = data['payload'];
  if (payload is String && payload.isNotEmpty) {
    try {
      final decoded = json.decode(payload);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
    } catch (_) {
      return null;
    }
  }

  return data;
}
