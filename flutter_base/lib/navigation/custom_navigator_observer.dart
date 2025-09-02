import 'package:acta/acta.dart';
import 'package:flutter/material.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    Handler.addBreadcrumb('Route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    Handler.addBreadcrumb('Route popped: ${route.settings.name}');
  }
}
