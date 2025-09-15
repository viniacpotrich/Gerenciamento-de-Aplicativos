import 'dart:async';
import 'dart:developer' as developer;

import 'package:acta/acta.dart';
import 'package:clean_arch/presentation/code_errors/view_models/code_errors_controller.dart';
import 'package:clean_arch/presentation/code_errors/views/code_errors_view.dart';
import 'package:clean_arch/presentation/connection_errors/view_models/connection_errors_view_model.dart';
import 'package:clean_arch/presentation/connection_errors/views/connection_error_screen.dart';
import 'package:clean_arch/presentation/db_errors/view_models/db_errors_view_model.dart';
import 'package:clean_arch/presentation/db_errors/views/db_errors_view.dart';
import 'package:clean_arch/presentation/home/view_models/home_view_model.dart';
import 'package:clean_arch/presentation/home/views/home_view.dart';
import 'package:clean_arch/presentation/key_errors/view_models/key_errors_view_model.dart';
import 'package:clean_arch/presentation/key_errors/views/key_errors_view.dart';
import 'package:clean_arch/presentation/memory_leak/view_models/memory_leak_view_model.dart';
import 'package:clean_arch/presentation/memory_leak/views/memory_leak_view.dart';
import 'package:clean_arch/routes/routes.dart';
import 'package:clean_arch/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          lazy: false,
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider<CodeErrorsViewModel>(
          lazy: false,
          create: (_) => CodeErrorsViewModel(),
        ),
        ChangeNotifierProvider<ConnectionErrorsViewModel>(
          lazy: false,
          create: (_) => ConnectionErrorsViewModel(),
        ),
        ChangeNotifierProvider<DbErrorsViewModel>(
          lazy: false,
          create: (_) => DbErrorsViewModel(),
        ),
        ChangeNotifierProvider<KeyErrorsViewModel>(
          lazy: false,
          create: (_) => KeyErrorsViewModel(),
        ),
        ChangeNotifierProvider<MemoryLeakViewModel>(
          lazy: false,
          create: (_) => MemoryLeakViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) => HomeView(viewModel: context.watch()),
          Routes.codeErrorScreen:
              (context) => CodeErrorsView(viewModel: context.watch()),
          Routes.connectionErrorScreen:
              (context) => ConnectionErrorsView(viewModel: context.watch()),
          Routes.keyErrorScreen:
              (context) => KeyErrorView(viewModel: context.watch()),
          Routes.memoryLeakScreen:
              (context) => MemoryLeakView(viewModel: context.watch()),
          Routes.dbErrors: (context) => DbErrorView(viewModel: context.watch()),
        },
        navigatorKey: navigatorKey,
      ),
    );
  }
}
