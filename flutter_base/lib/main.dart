import 'dart:async';
import 'dart:developer' as developer;

import 'package:acta/acta.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/screens/code_errors/code_errors_screen.dart';
import 'package:flutter_base/navigation/custom_navigator_observer.dart';
import 'package:flutter_base/screens/connection_errors/connection_error_screen.dart';
import 'package:flutter_base/screens/db_errors/db_errors_screen.dart';
import 'package:flutter_base/utils/error_dialog.dart';
import 'package:flutter_base/screens/home/home_screen.dart';
import 'package:flutter_base/navigation/routes.dart';
import 'package:flutter_base/screens/key_errors/key_error.dart';
import 'package:flutter_base/screens/memory_leak/memory_leak.dart';
// import 'package:flutter_base/firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  Handler.initialize(
    reporters: [
      ConsoleReporter(),
      MongoReporter(
        connectionString:
            'mongodb://root:example@127.0.0.1:27017/error_logs?authSource=admin',
        dbName: 'error_logs',
        collection: 'logs',
        // compactMode: true,
      ),
      ElasticsearchReporter(
        connectionString: 'http://localhost:9200',
        indexPattern: 'logs',
      ),
      // Fire
    ],
    options: const HandlerOptions(
      catchAsyncErrors: true,
      logFlutterErrors: true,
      logPlatformErrors: true,
      minSeverity: Severity.info,
      maxBreadcrumbs: 50,
    ),
    initialContext: {'appVersion': '1.0.0', 'build': 1, 'env': 'dev'},
    beforeSend: (Event event) {
      // Example: drop noisy debug logs in release
      // if (kReleaseMode && report.level == BugLevel.debug) return null;
      return event;
    },
    onCaptured: (Event? event) {
      var context2 = navigatorKey.currentState?.context;
      if (context2 != null) {
        // ScaffoldMessenger.of(
        //   context2,
        // ).showSnackBar(debugSnackBar(event, context2));
        showDialog(
          context: context2,
          builder:
              (_) => ErrorDialog(
                title: '${event?.message}',
                message: '${event?.exception}',
              ),
        );
      }
    },
    appRunner: () {
      runApp(const MyApp());
    },
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        developer.log("[PRINT] $line");
        parent.print(zone, line);
      },
      createTimer: (self, parent, zone, duration, callback) {
        developer.log("[TIMER] Scheduled for $duration");
        return parent.createTimer(zone, duration, callback);
      },
      scheduleMicrotask: (self, parent, zone, task) {
        developer.log("[MICROTASK] New microtask scheduled");
        parent.scheduleMicrotask(zone, task);
      },
    ),
  );
}

SnackBar debugSnackBar(Event? event, BuildContext context2) {
  return SnackBar(
    content: ListTile(
      title: Text(
        event?.message ?? '',
        style: TextStyle(color: Theme.of(context2).colorScheme.onPrimary),
      ),
      subtitle: Text(
        event?.exception.toString() ?? '',
        style: TextStyle(color: Theme.of(context2).colorScheme.onPrimary),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Erro Test App',
      home: const HomeScreen(),
      routes: {
        Routes.codeErrorScreen: (_) => const CodeErrorsScreen(),
        Routes.keyErrorScreen: (_) => const KeyErrorScreen(),
        Routes.memoryLeakScreen: (_) => const MemoryLeakScreen(),
        Routes.dbErrors: (_) => const DbErrorScreen(),
        Routes.connectionErrorScreen: (_) => const ConnectionErrorScreen(),
      },
      navigatorObservers: [CustomNavigatorObserver()],
    );
  }
}
