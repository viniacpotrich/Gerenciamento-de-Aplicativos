import 'dart:async';
import 'dart:developer' as developer;

import 'package:acta/acta.dart';
import 'package:clean_arch/app.dart';
import 'package:clean_arch/utils/error_dialog.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  ActaJournal.initialize(
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
                title: 'Oops Algum erro ocorreu!',
                message: '${event?.toString()}',
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
