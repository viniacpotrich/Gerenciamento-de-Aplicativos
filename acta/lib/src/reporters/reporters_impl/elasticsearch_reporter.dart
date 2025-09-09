import 'package:acta/acta.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ElasticsearchReporter implements Reporter {
  final String connectionString;
  final String indexPattern;

  ElasticsearchReporter({
    required this.connectionString,
    required this.indexPattern,
  });

  @override
  Future<void> report(Event event) async {
    final url = Uri.parse(
      "$connectionString/$indexPattern/_doc/", // "http://localhost:9200/events/_doc",
    ); // index = events
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "message": event.message,
        "severity": event.severity.toString(),
        "timestamp": event.timestamp.toIso8601String(),
        "exception": event.exception?.toString(),
        "stackTrace": event.stackTrace?.toString(),
        "metadata": event.metadata,
        "breadcrumbs": event.breadcrumbs,
        "fingerPrint": event.fingerPrint,
        "tag": event.tag,
      }),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("Saved to Elasticsearch: ${response.body}");
    } else {
      print("Failed to save: ${response.statusCode} ${response.body}");
    }
  }
}
