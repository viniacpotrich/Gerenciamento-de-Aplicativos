import 'package:acta/acta.dart';

abstract class Event {
  Severity get severity;
  Map<String, dynamic>? metadata;
  List<Map<String, dynamic>>? breadcrumbs;

  void calculateFingerprint();
  Map<String, dynamic> toMap();
  String toJson();
  String getContentToString();
  String prettyPrinter();
}
