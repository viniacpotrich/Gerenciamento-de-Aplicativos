enum Severity { info, warning, critical }
//{ debug, info, warning, error, fatal }

class Event {
  final String message;
  final Object? exception;
  final StackTrace? stackTrace;
  final Severity severity;
  final DateTime timestamp;

  /// Dados adicionais passados no evento
  final Map<String, dynamic>? metadata;

  /// Breadcrumbs (ex: lista de passos/ações antes do erro)
  final List<Map<String, dynamic>> breadcrumbs;

  final String fingerPrint;

  final String? tag;

  Event({
    required this.message,
    this.exception,
    this.stackTrace,
    this.severity = Severity.info,
    DateTime? timestamp,
    this.metadata,
    List<Map<String, dynamic>>? breadcrumbs,
    required this.fingerPrint,
    this.tag,
  }) : timestamp = timestamp ?? DateTime.now(),
       breadcrumbs = breadcrumbs ?? [];
}
