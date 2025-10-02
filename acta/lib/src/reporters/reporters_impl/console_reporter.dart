import 'package:acta/acta.dart';
import 'package:flutter/foundation.dart';

class ConsoleReporter implements Reporter {
  final bool pretty;
  ConsoleReporter({this.pretty = true});

  @override
  Future<void> report(Event r) async {
    if (pretty) {
      debugPrint(r.prettyPrinter());
    } else {
      debugPrint(r.toString());
    }
  }
}
