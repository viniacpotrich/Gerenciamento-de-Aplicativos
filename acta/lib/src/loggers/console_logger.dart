import 'package:flutter/foundation.dart';

import '../event.dart';

class ConsoleLogger {
  void log(Event event) {
    debugPrint(
      '[${event.severity}] ${event.timestamp.toIso8601String()}: ${event.message}',
    );
    if (event.exception != null) debugPrint('Exception: ${event.exception}');
    if (event.stackTrace != null) debugPrint('StackTrace: ${event.stackTrace}');
  }
}
