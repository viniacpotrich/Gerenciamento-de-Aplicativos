import 'dart:async';
import 'dart:developer' as developer;

import 'package:acta/acta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/screens/code_errors/code_errors_screen.dart';
import 'package:flutter_base/navigation/custom_navigator_observer.dart';
import 'package:flutter_base/screens/connection_errors/connection_error_screen.dart';
import 'package:flutter_base/screens/db_errors/db_errors_screen.dart';
import 'package:flutter_base/screens/native_error/native_error.dart';
import 'package:flutter_base/screens/screen_error/screen_error_view.dart';
import 'package:flutter_base/utils/error_dialog.dart';
import 'package:flutter_base/screens/home/home_screen.dart';
import 'package:flutter_base/navigation/routes.dart';
import 'package:flutter_base/screens/key_errors/key_error.dart';
import 'package:flutter_base/screens/memory_leak/memory_leak.dart';
// import 'package:flutter_base/utils/firebase_custom.dart';
import 'package:flutter_base/utils/info_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // runnable();
  ActaJournal.initialize(
    reporters: [
      // ConsoleReporter(),
      // MongoReporter(
      //   connectionString:
      //       'mongodb://root:example@127.0.0.1:27017/error_logs?authSource=admin',
      //   dbName: 'error_logs',
      //   collection: 'logs',
      //   // compactMode: true,
      // ),
      ElasticsearchReporter(
        connectionString:
            //'http://localhost:9200',
            'http://192.168.3.4:9200',
        indexPattern: 'logs',
      ),
      // FirebaseCustomReporter(),
    ],
    options: const HandlerOptions(
      catchAsyncErrors: false,
      logFlutterErrors: true,
      logPlatformErrors: true,
      minSeverity: Severity.info,
      maxBreadcrumbs: 50,
    ),
    initialContext: await InfoService.collectAsJson(),
    beforeSend: (Event event) {
      // Example: drop noisy debug logs in release
      // if (kReleaseMode && report.level == BugLevel.debug) return null;
      return event;
    },
    onCaptured: (Event? event) {
      var context2 = navigatorKey.currentState?.context;
      if (context2 != null) {
        // Snack Bar
        // ScaffoldMessenger.of(
        //   context2,
        // ).showSnackBar(debugSnackBar(event, context2));
        showDialog(
          context: context2,
          builder:
              (_) => ErrorDialog(
                title: 'Oops Algum erro ocorreu!',
                message: '', //'${event?.toString()}',
              ),
        ).then((_) {
          if (context2.mounted) {
            Navigator.popUntil(
              context2,
              (route) => route.settings.name == Routes.home,
            );
          }
        });
      }
    },
    appRunner: () async => runnable(),
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

void runnable() {
  // final prev = FlutterError.onError;
  // FlutterError.onError = (FlutterErrorDetails details) {
  //   prev?.call(details);
  //   goHome();
  // };
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

void goHome() {
  var context2 = navigatorKey.currentState?.context;
  if (context2 != null && context2.mounted) {
    Future.delayed(
      Duration(seconds: 1),
      () => Navigator.popUntil(
        context2,
        (route) => route.settings.name == Routes.home,
      ),
    );
  }
}

// https://www.youtube.com/watch?v=XmnX4vRpPvM
SnackBar debugSnackBar(Event? event, BuildContext context2) {
  return SnackBar(
    content: ListTile(
      title: Text(
        'Oops Algum erro ocorreu!',
        style: TextStyle(color: Theme.of(context2).colorScheme.onPrimary),
      ),
      subtitle: Text(
        '${event?.toString()}',
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
      title: 'Test Flutter Base',
      home: const HomeScreen(),
      routes: {
        Routes.codeErrorScreen: (_) => const CodeErrorsScreen(),
        Routes.keyErrorScreen: (_) => const KeyErrorScreen(),
        Routes.memoryLeakScreen: (_) => const MemoryLeakScreen(),
        Routes.dbErrors: (_) => const DbErrorScreen(),
        Routes.connectionErrorScreen: (_) => const ConnectionErrorScreen(),
        Routes.nativeError: (_) => const NativeErrorScreen(),
        Routes.screenError: (_) => const ScreenErrorView(),
      },
      navigatorObservers: [CustomNavigatorObserver()],
    );
  }
}
