import 'dart:async';
import 'dart:developer' as developer;

import 'package:acta/acta.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_x/app/data/services/info_service.dart';
import 'package:get_x/app/routes/custom_navigator_observer.dart';
import 'package:get_x/utils/error_dialog.dart';

import 'app/routes/app_pages.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
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
    initialContext: await InfoService.collectAsJson(),
    beforeSend: (Event event) => event,
    onCaptured: (Event? event) {
      var context2 = navigatorKey.currentState?.context;
      if (context2 != null) {
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
      runApp(
        GetMaterialApp(
          title: "Application",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          navigatorObservers: [CustomNavigatorObserver()],
          navigatorKey: navigatorKey,
        ),
      );
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
