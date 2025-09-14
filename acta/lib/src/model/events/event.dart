import 'dart:convert';
import 'package:acta/src/model/severity.dart';

class Event {
  late String fingerPrint;
  final String message;
  final Severity severity;
  final String? tag;

  /// Dados adicionais passados no evento
  Map<String, dynamic>? metadata;

  /// Breadcrumbs (ex: lista de passos/ações antes do erro)
  List<Map<String, dynamic>> breadcrumbs;
  DateTime timestamp;

  Event({
    required this.message,
    this.severity = Severity.info,
    this.metadata,
    this.tag,
    List<Map<String, dynamic>>? breadcrumbs,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now(),
       breadcrumbs = breadcrumbs ?? [];

  void calculateFingerprint() {
    fingerPrint =
        '${message.replaceAll(RegExp(r'\d+'), '#')}|${severity.name}|${tag ?? ''}';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'fingerPrint': fingerPrint,
      'severity': severity.toMap(),
      'tag': tag,
      'metadata': metadata,
      'breadcrumbs': breadcrumbs,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      message: map['message'] as String,
      severity: SeverityMapper.fromMap(map['severity'] as String),
      tag: map['tag'] != null ? map['tag'] as String : null,
      metadata:
          map['metadata'] != null
              ? Map<String, dynamic>.from(
                map['metadata'] as Map<String, dynamic>,
              )
              : null,
      breadcrumbs:
          map['breadcrumbs'] != null
              ? List<Map<String, dynamic>>.from(map['breadcrumbs'] as List)
              : [],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    )..fingerPrint = map['fingerPrint'] as String;
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Event($getContentToString)';

  String getContentToString() {
    return 'fingerPrint: $fingerPrint, message: $message, severity: $severity, tag: $tag, metadata: $metadata, breadcrumbs: $breadcrumbs, timestamp: $timestamp';
  }
}
