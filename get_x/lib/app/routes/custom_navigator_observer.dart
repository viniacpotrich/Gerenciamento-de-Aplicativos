import 'package:acta/acta.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/observers/route_observer.dart';

class CustomNavigatorObserver extends GetObserver {
  bool _isDialog(Route route) => route is PopupRoute;
  @override
  void didPush(Route route, Route? previousRoute) {
    if (!_isDialog(route)) {
      ActaJournal.addBreadcrumb('Route pushed: ${route.settings.name}');
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (!_isDialog(route)) {
      ActaJournal.addBreadcrumb('Route popped: ${route.settings.name}');
    }
    super.didPop(route, previousRoute);
  }
}
