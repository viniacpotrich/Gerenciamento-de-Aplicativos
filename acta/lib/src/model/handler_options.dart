import 'package:acta/acta.dart';

class HandlerOptions {
  final bool catchAsyncErrors;
  final bool logFlutterErrors;
  final bool logPlatformErrors;
  final Severity minSeverity;
  final int maxBreadcrumbs;

  const HandlerOptions({
    this.catchAsyncErrors = true,
    this.logFlutterErrors = true,
    this.logPlatformErrors = true,
    this.minSeverity = Severity.info,
    this.maxBreadcrumbs = 50,
  });
}
