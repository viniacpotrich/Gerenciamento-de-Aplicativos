import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:very_good/code_errors/view/code_errors_view.dart';
import 'package:very_good/connection_errors/views/connection_error_screen.dart';
import 'package:very_good/db_errors/views/db_errors_view.dart';
import 'package:very_good/home/views/home_view.dart';
import 'package:very_good/key_errors/views/key_errors_view.dart';
import 'package:very_good/memory_leak/views/memory_leak_view.dart';
import 'package:very_good/native_error/views/native_error_view.dart';
import 'package:very_good/routes/custom_navigator_observer.dart';
import 'package:very_good/routes/routes.dart';
import 'package:very_good/screen_error/views/screen_error_view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  debugLogDiagnostics: true,
  observers: [
    CustomNavigatorObserver(),
  ],
  routes: <GoRoute>[
    GoRoute(
      name: 'home',
      path: Routes.home,
      builder: (BuildContext context, GoRouterState state) => const HomePage(),
      routes: <RouteBase>[
        GoRoute(
          path: Routes.codeErrorScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const CodeErrorsPage();
          },
        ),
        GoRoute(
          path: Routes.keyErrorScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const KeyErrorsPage();
          },
        ),
        GoRoute(
          path: Routes.memoryLeakScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const MemoryLeakPage();
          },
        ),
        GoRoute(
          path: Routes.dbErrors,
          builder: (BuildContext context, GoRouterState state) {
            return const DbErrorsPage();
          },
        ),
        GoRoute(
          path: Routes.connectionErrorScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const ConnectionErrorsPage();
          },
        ),
        GoRoute(
          path: Routes.nativeError,
          builder: (BuildContext context, GoRouterState state) {
            return const NativeErrorPage();
          },
        ),
        GoRoute(
          path: Routes.screenError,
          builder: (BuildContext context, GoRouterState state) {
            return const ScreenErrorPage();
          },
        ),
      ],
    ),
  ],
);
