import 'package:acta/acta.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/error_screen.dart';
import 'package:flutter_base/home_screen.dart';
import 'package:flutter_base/routes.dart';
// import 'package:flutter_base/firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Handler.initialize(
    // Handler2.initialize(
    strategies: [
      ConsoleStrategy(),
      GitHubIssueStrategy(
        owner: 'meuUser',
        repo: 'meuRepo',
        token: 'meuToken',
        minSeverity: Severity.critical,
      ),
    ],
    storage: CompositeStorage([
      MongoStorage(
        connectionString:
            'mongodb://root:example@127.0.0.1:27017/error_logs?authSource=admin',
        dbName: 'error_logs',
        collection: 'logs',
      ),
      FirebaseStorage(),
    ]),
    // reporters: [ConsoleReporter(),],
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
    onCaptured: (event) {
      var context2 = navigatorKey.currentState?.context;
      if (context2 != null) {
        ScaffoldMessenger.of(
          context2,
        ).showSnackBar(debugSnackBar(event, context2));
      }
    },
    appRunner: () {
      runApp(const MyApp());
    },
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
        Routes.errorScreenCast:
            (_) => const ErrorScreen(
              title: 'Error Cast',
              breadcrumbName: 'Pressionou Trigger()',
              triggerError: methodErrorCast,
            ),
      },
    );
  }
}

void methodErrorCast() {
  int inteiro = 0.0 as int; // Força um erro de tipo
}
