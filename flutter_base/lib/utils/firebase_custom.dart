import 'package:acta/acta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCustomEvent extends BaseEvent {
  FirebaseCustomEvent({required super.message});

  @override
  void calculateFingerprint() {
    fingerPrint = '';
  }

  @override
  String getContentToString() {
    return message;
  }

  @override
  String prettyPrinter() {
    return 'FirebaseCustomEvent: $message';
  }

  @override
  Severity get severity => Severity.info;

  @override
  String toJson() {
    return message;
  }

  @override
  Map<String, dynamic> toMap() {
    return {'message': message};
  }
}

class FirebaseCustomReporter extends Reporter {
  @override
  Future<void> report(Event report) async {
    await FirebaseFirestore.instance.collection('logs').add(report.toMap());
  }
}
