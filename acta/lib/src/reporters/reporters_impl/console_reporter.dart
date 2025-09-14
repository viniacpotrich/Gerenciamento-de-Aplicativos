import 'package:acta/acta.dart';
import 'package:acta/src/model/events/error_event.dart';
import 'package:flutter/foundation.dart';

class ConsoleReporter implements Reporter {
  final bool pretty;
  ConsoleReporter({this.pretty = true});

  @override
  Future<void> report(Event r) async {
    final b = StringBuffer();

    // Basic info
    b.writeln(
      '[${r.severity.name.toUpperCase()}] ${r.timestamp.toIso8601String()}',
    );
    b.writeln('Message: ${r.message}');
    b.writeln('FingerPrint: ${r.fingerPrint}');

    // Optional metadata
    if (r.metadata != null && r.metadata!.isNotEmpty) {
      b.writeln('Metadata: ${r.metadata}');
    }

    // Breadcrumbs
    if (r.breadcrumbs.isNotEmpty) {
      b.writeln('Breadcrumbs:');
      for (final bc in r.breadcrumbs) {
        b.writeln('  - $bc');
      }
    }

    // If it's an ErrorEvent, print exception and stackTrace
    if (r is ErrorEvent) {
      if (r.exception != null) b.writeln('Exception: ${r.exception}');
      if (r.stackTrace != null) b.writeln('StackTrace: ${r.stackTrace}');
    }

    // Print to console
    debugPrint(b.toString());
  }
}
