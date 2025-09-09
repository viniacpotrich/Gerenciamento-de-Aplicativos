import 'package:acta/acta.dart';
import 'package:flutter/material.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  //Ignorando Dialog
  bool _isDialog(Route route) => route is PopupRoute;
  @override
  void didPush(Route route, Route? previousRoute) {
    if (!_isDialog(route)) {
      Handler.addBreadcrumb('Route pushed: ${route.settings.name}');
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (!_isDialog(route)) {
      Handler.addBreadcrumb('Route popped: ${route.settings.name}');
    }
    super.didPop(route, previousRoute);
  }
}
