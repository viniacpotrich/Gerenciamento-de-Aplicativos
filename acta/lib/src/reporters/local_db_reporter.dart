import 'package:acta/acta.dart';
import 'package:hive/hive.dart';

/// Stores reports locally for offline-first flows.
class LocalDbReporter implements Reporter {
  final Box box;
  LocalDbReporter(this.box);

  @override
  Future<void> report(Event r) async {
    await box.add({
      'level': r.severity.name,
      'timestamp': r.timestamp.toIso8601String(),
      'content': r.message.toString(),
      'stack': r.stackTrace?.toString(),
      'meta': r.metadata,
      'breadcrumbs': r.breadcrumbs,
      'fingerPrint': r.fingerPrint,
    });
  }
}
