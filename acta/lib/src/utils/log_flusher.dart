import 'package:acta/acta.dart';
import 'package:acta/src/utils/utils.dart';
import 'package:hive/hive.dart';

/// Replays locally stored logs to an uploader reporter, then clears the box.
class LogFlusher {
  final Box box;
  final Reporter uploader;

  LogFlusher({required this.box, required this.uploader});

  Future<void> flush() async {
    final items = box.values.toList().cast<Map>();
    for (final m in items) {
      final report = Event(
        message: m['content'] ?? 'unknown',
        exception: (m['exception'] != null) ? m['exception'] : null,
        stackTrace:
            (m['stack'] != null)
                ? StackTrace.fromString(m['stack'] as String)
                : null,
        severity: _parseLevel(m['level'] as String?),
        timestamp:
            DateTime.tryParse((m['timestamp'] ?? '') as String) ??
            DateTime.now(),
        metadata: Map<String, dynamic>.from(m['meta'] as Map? ?? const {}),
        breadcrumbs: (m['breadcrumbs'] as List?)?.cast<Map<String, dynamic>>(),
        fingerPrint: generateFingerprint(
          (m['exception'] != null) ? m['exception'] : null,
          (m['stack'] != null)
              ? StackTrace.fromString(m['stack'] as String)
              : null,
        ),
      );
      await uploader.report(report);
    }
    await box.clear();
  }

  Severity _parseLevel(String? s) {
    switch (s) {
      // case 'debug':
      //   return ErrorSeverity.debug;
      case 'info':
        return Severity.info;
      case 'warning':
        return Severity.warning;
      // case 'fatal':
      //   return ErrorSeverity.fatal;
      case 'error':
      default:
        return Severity.critical;
      // return ErrorSeverity.error;
    }
  }
}
