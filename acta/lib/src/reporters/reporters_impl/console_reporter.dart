import 'package:acta/acta.dart';
import 'package:flutter/foundation.dart';

class ConsoleReporter implements Reporter {
  final bool pretty;
  ConsoleReporter({this.pretty = true});

  @override
  Future<void> report(Event r) async {
    final b = StringBuffer();
    b.writeln(
      '[${r.severity.name.toUpperCase()}] ${r.timestamp.toIso8601String()}',
    );
    b.writeln('content: ${r.message}');
    if (r.stackTrace != null) b.writeln('stack: ${r.stackTrace}');
    if (r.metadata != null) b.writeln('meta: ${r.metadata}');
    if (r.breadcrumbs.isNotEmpty) {
      b.writeln('breadcrumbs:');
      for (final bc in r.breadcrumbs) {
        b.writeln('  - $bc');
      }
    }
    b.writeln('fingerPrint : ${r.fingerPrint}');
    pretty ? debugPrint(b.toString()) : debugPrint(b.toString());
  }
}
