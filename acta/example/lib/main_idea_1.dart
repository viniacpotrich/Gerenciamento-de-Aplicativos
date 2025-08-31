import 'package:acta/acta.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  final logBox = await Hive.openBox('bugkit_logs');

  ErrorHandler.initialize(
    strategies: [ConsoleStrategy()],
    storage: CompositeStorage([
      MongoStorage(
        connectionString: 'mongodb://localhost:27017',
        dbName: 'error_logs',
        collection: 'logs',
      ),
      // FirebaseStorage(),
    ]),
    options: const HandlerOptions(
      catchAsyncErrors: true,
      logFlutterErrors: true,
      logPlatformErrors: true,
      minSeverity: Severity.info,
      maxBreadcrumbs: 50,
    ),
    initialContext: {'appVersion': '1.0.0', 'build': 1, 'env': 'dev'},
    beforeSend: (report) {
      // Example: drop noisy debug logs in release
      // if (kReleaseMode && report.level == BugLevel.debug) return null;
      return report;
    },
    appRunner: () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('BugKit demo')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Handler2.addBreadcrumb('Pressed INFO');
                  Handler2.capture(
                    message: 'User pressed info',
                    severity: Severity.info,
                    meta: {'screen': 'home'},
                  );
                },
                child: const Text('Log info'),
              ),
              ElevatedButton(
                onPressed: () {
                  Handler2.addBreadcrumb('Pressed ERROR');
                  throw Exception('Boom!');
                },
                child: const Text('Throw error'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
