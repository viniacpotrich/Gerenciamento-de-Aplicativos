import 'dart:async';
import 'package:flutter/foundation.dart';
import 'event.dart';
import 'strategies/base_strategy.dart';
import 'storage/storage.dart';

typedef BeforeSend = FutureOr<Event?> Function(Event event);

class ErrorHandlerOptions {
  final bool catchAsyncErrors;
  final bool logFlutterErrors;
  final bool logPlatformErrors;
  final Severity minSeverity;
  final int maxBreadcrumbs;

  const ErrorHandlerOptions({
    this.catchAsyncErrors = true,
    this.logFlutterErrors = true,
    this.logPlatformErrors = true,
    this.minSeverity = Severity.info,
    this.maxBreadcrumbs = 50,
  });
}

class ErrorHandler {
  static final List<Strategy> _strategies = [];
  static Storage? _storage;
  static late ErrorHandlerOptions _options;
  static Map<String, dynamic> _globalContext = {};
  static final List<Map<String, dynamic>> _breadcrumbs = [];
  static BeforeSend? _beforeSend;

  /// Inicializa handlers globais e executa seu app.
  static void initialize({
    required List<Strategy> strategies,
    Storage? storage,
    ErrorHandlerOptions options = const ErrorHandlerOptions(),
    BeforeSend? beforeSend,
    Map<String, dynamic>? initialContext,
    required void Function() appRunner,
  }) {
    _strategies
      ..clear()
      ..addAll(strategies);
    _storage = storage;
    _options = options;
    _beforeSend = beforeSend;
    _globalContext = Map<String, dynamic>.from(initialContext ?? {});

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
      runZonedGuarded(appRunner, (Object error, StackTrace stack) {
        capture(
          message: "Async error caught",
          exception: error,
          stackTrace: stack,
          severity: Severity.critical,
        );
      });
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

  /// API manual de log
  static Future<void> capture({
    required String message,
    Object? exception,
    StackTrace? stackTrace,
    Severity severity = Severity.info,
    Map<String, dynamic>? meta,
  }) async {
    if (severity.index < _options.minSeverity.index) return;

    final event = Event(
      message: message,
      exception: exception,
      stackTrace: stackTrace,
      severity: severity,
      metadata: {..._globalContext, ...?meta},
      breadcrumbs: List<Map<String, dynamic>>.from(_breadcrumbs),
    );

    final maybe = await Future.value(_beforeSend?.call(event) ?? event);
    if (maybe == null) return;

    // Estratégias síncronas
    for (var strategy in _strategies) {
      strategy.handle(maybe);
    }

    // Storage persistente
    await _storage?.save(maybe);
  }
}
