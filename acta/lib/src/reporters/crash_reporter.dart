import 'package:acta/acta.dart';

/// Implement this to send reports somewhere (console, DB, cloud, etc.)
abstract class Reporter {
  Future<void> report(Event report);
}
