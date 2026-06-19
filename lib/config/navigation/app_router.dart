import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_redirect.dart';
import 'routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

late GoRouter appRouter;

GoRouter createAppRouter({
  List<NavigatorObserver> observers = const [],
}) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: routes,
    observers: observers,
    redirect: (context, state) => resolveAuthRedirect(state),
  );
}
