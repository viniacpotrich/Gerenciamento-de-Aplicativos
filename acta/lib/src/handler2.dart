import 'dart:async';
import 'package:acta/acta.dart';
import 'package:acta/src/utils/utils.dart';
import 'package:flutter/foundation.dart';

class Handler2 {
  static final List<Reporter> _reporters = [];
  static late HandlerOptions _options;
  static BeforeSend? _beforeSend;
  static OnCaptured? _onCaptured;
  static Map<String, dynamic> _globalContext = {};
  static final List<Map<String, dynamic>> _breadcrumbs = [];

  static void initialize({
    required List<Reporter> reporters,
    HandlerOptions options = const HandlerOptions(),
    BeforeSend? beforeSend,
    OnCaptured? onCaptured,
    Map<String, dynamic>? initialContext,
    required void Function() appRunner,
    ZoneSpecification? zoneSpecification,
  }) {
    _reporters
      ..clear()
      ..addAll(reporters);
    _options = options;
    _beforeSend = beforeSend;
    _onCaptured = onCaptured;
    _globalContext = {...?initialContext};

    if (_options.logFlutterErrors) {
      final prev = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails details) {
        capture(
          message: "FlutterError caught",
          exception: details.exception,
          stackTrace: details.stack,
          severity: Severity.critical,
        );
        prev?.call(details);
      };
    }

    if (_options.logPlatformErrors) {
      PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
        capture(
          message: "Platform error caught",
          exception: error,
          stackTrace: stack,
          severity: Severity.critical,
        );
        return true;
      };
    }

    if (_options.catchAsyncErrors) {
      // WidgetsFlutterBinding.ensureInitialized();

      runZonedGuarded(appRunner, (Object error, StackTrace stack) {
        capture(
          message: "Async error caught",
          exception: error,
          stackTrace: stack,
          severity: Severity.critical,
        );
      }, zoneSpecification: zoneSpecification);
    } else {
      appRunner();
    }
  }

  /// Adiciona/atualiza contexto global
  static void setContext(Map<String, dynamic> context) {
    _globalContext = Map<String, dynamic>.from(context);
  }

  static void setContextKey(String key, Object? value) {
    _globalContext[key] = value;
  }

  /// Breadcrumb (log leve de navegação/interações)
  static void addBreadcrumb(String message, {Map<String, dynamic>? data}) {
    final bc = {
      'message': message,
      'timestamp': DateTime.now().toIso8601String(),
      if (data != null) ...data,
    };
    _breadcrumbs.add(bc);
    if (_breadcrumbs.length > _options.maxBreadcrumbs) {
      _breadcrumbs.removeRange(
        0,
        _breadcrumbs.length - _options.maxBreadcrumbs,
      );
    }
  }

  static Future<void> capture({
    required String message,
    Object? exception,
    StackTrace? stackTrace,
    Severity severity = Severity.info,
    Map<String, dynamic>? meta,
  }) async {
    if (severity.index < _options.minSeverity.index) return;
    final fingerprint = generateFingerprint(exception, stackTrace);
    final event = Event(
      message: message,
      exception: exception,
      stackTrace: stackTrace,
      severity: severity,
      metadata: {..._globalContext, ...?meta},
      breadcrumbs: List<Map<String, dynamic>>.from(_breadcrumbs),
      fingerPrint: fingerprint,
    );

    final maybe = await Future.value(_beforeSend?.call(event) ?? event);
    if (maybe == null) return;

    for (final r in _reporters) {
      try {
        await r.report(maybe);

        // Callback de notificação externa (UI, snackbars etc)
        _onCaptured?.call(maybe);
      } catch (e, s) {
        debugPrint('[ErrorKit] reporter ${r.runtimeType} failed: $e\n$s');
      }
    }
  }
}
