import 'dart:async';
import 'dart:developer';
import 'dart:developer' as developer;

import 'package:acta/acta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:very_good/utils/error_dialog.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();
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
      final context2 = navigatorKey.currentState?.context;
      if (context2 != null) {
        showDialog(
          context: context2,
          builder: (_) => ErrorDialog(
            title: 'Oops Algum erro ocorreu!',
            message: '$event',
          ),
        );
      }
    },
    appRunner: () async {
      runApp(await builder());
    },
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        developer.log('[PRINT] $line');
        parent.print(zone, line);
      },
      createTimer: (self, parent, zone, duration, callback) {
        developer.log('[TIMER] Scheduled for $duration');
        return parent.createTimer(zone, duration, callback);
      },
      scheduleMicrotask: (self, parent, zone, task) {
        developer.log('[MICROTASK] New microtask scheduled');
        parent.scheduleMicrotask(zone, task);
      },
    ),
  );
}
