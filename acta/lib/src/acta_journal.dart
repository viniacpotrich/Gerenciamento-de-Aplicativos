import 'dart:async';
// import 'dart:isolate';
import 'package:acta/acta.dart';
import 'package:acta/src/model/defines.dart';
import 'package:flutter/foundation.dart';

class ActaJournal {
  static final List<Reporter> _reporters = [];
  static late HandlerOptions _options;
  static BeforeSend? _beforeSend;
  static OnCaptured? _onCaptured;
  static Map<String, dynamic> _globalContext = {};
  static final List<Map<String, dynamic>> _breadcrumbs = [];

  static void initialize({
    required void Function() appRunner,
    required List<Reporter> reporters,
    HandlerOptions options = const HandlerOptions(),
    BeforeSend? beforeSend,
    OnCaptured? onCaptured,
    Map<String, dynamic>? initialContext,
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
        report(
          event: ErrorEvent(
            message: "FlutterError caught",
            exception: details.exception,
            stackTrace: details.stack,
            severity: Severity.critical,
          ),
        );
        prev?.call(details);
      };
    }

    if (_options.logPlatformErrors) {
      PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
        report(
          event: ErrorEvent(
            message: "Platform error caught",
            exception: error,
            stackTrace: stack,
            severity: Severity.critical,
          ),
        );
        return true;
      };
    }

    if (_options.catchAsyncErrors) {
      runZonedGuarded(appRunner, (Object error, StackTrace stack) {
        report(
          event: ErrorEvent(
            message: "Async error caught",
            exception: error,
            stackTrace: stack,
            severity: Severity.critical,
          ),
        );
      }, zoneSpecification: zoneSpecification);
    } else {
      appRunner();
    }
  }

  static void setContext(Map<String, dynamic> context) {
    _globalContext = Map<String, dynamic>.from(context);
  }

  static void setContextKey(String key, Object? value) {
    _globalContext[key] = value;
  }

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

  static Future<void> report({
    required Event event,
    Map<String, dynamic>? meta,
  }) async {
    if (event.severity.index < _options.minSeverity.index) return;
    event
      ..metadata = {..._globalContext, ...?meta}
      ..breadcrumbs = List<Map<String, dynamic>>.from(_breadcrumbs);
    event.calculateFingerprint();

    final maybe = await Future.value(_beforeSend?.call(event) ?? event);
    if (maybe == null) return;

    for (final r in _reporters) {
      try {
        _reportEventMethod(r, maybe);
        // ========================================================================
        // Pass only serializable data
        // await compute(_isolateEntry, {
        //   'reporterType': r.runtimeType.toString(),
        //   'event': maybe.toJson(), // <- you need toJson()
        // });
        // ========================================================================
        // final receivePort = ReceivePort();
        // await Isolate.spawn(_isolateWorker, {
        //   'sendPort': receivePort.sendPort,
        //   'reporterType': r.runtimeType.toString(),
        //   'event': maybe.toJson(), // <- again must be serializable
        // });
        // // optional: wait for completion
        // await for (var message in receivePort) {
        //   if (message == 'done') {
        //     receivePort.close();
        //     break;
        //   }
        // }
        // ========================================================================
      } catch (e, s) {
        debugPrint('[ACTA] reporter ${r.runtimeType} failed: $e\n$s');
      }
    }
    _onCaptured?.call(maybe);
  }

  static _reportEventMethod(Reporter r, Event event) async =>
      await r.report(event);

  //TODO colocar como pontos futuros
  // // isolate function (must be top-level or static)
  // static Future<void> _isolateEntry(Map<String, dynamic> args) async {
  //   final String reporterType = args['reporterType'];
  //   final event = Event.fromJson(args['event']); // <- you need fromJson()
  //   // Recreate reporter based on type
  //   final Reporter r = Reporter.create(reporterType);
  //   await _reportEventMethod(r, event);
  // }

  // static Future<void> _isolateWorker(Map<String, dynamic> args) async {
  //   final sendPort = args['sendPort'] as SendPort;
  //   final String reporterType = args['reporterType'];
  //   final event = Event.fromJson(args['event']);
  //   final Reporter r = Reporter.create(reporterType);
  //   await _reportEventMethod(r, event);
  //   sendPort.send('done');
  // }
}


// TODO 
// metodo channel kotlin
// Documentar o TCC
//    BPM => pesquisar notações (LOOP) na vdd sao assim, só que seria o modo tradicional (não achei o loopzinho novo no drawio)
            //Capturou rever => ajustado
//    Fluxograma
//      Cada diagrama um exemplo
//    Criar um expecifico para user

//    Exemplos de json, repostas, FERRAMENTAS 
//    Pacote
//    Apps exemplos para uso do pacote
// Erro de tela
// chamar toast Funcional
// cojitar colocar no pub dev //https://dart.dev/tools/dart-doc
// Sentry Firebase
// Melhorar erros de network (nas camadas)
// ElasticSearch levantar docker 
// Ferramentas existentes
// Id de app





// METADATA AINDA TA IGUAL
// Talvez por tudo em pt-BR?
// Passar para .env antes de pensar em publicar
// lifecycle