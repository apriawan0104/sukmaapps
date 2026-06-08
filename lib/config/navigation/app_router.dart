import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

late GoRouter appRouter;

GoRouter createAppRouter({
  List<NavigatorObserver> observers = const [],
}) {
  return GoRouter(
    initialLocation: '/',
    routes: routes,
    observers: observers,
  );
}
