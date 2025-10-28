// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:acta/acta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCustomEvent extends Event {
  final String message;
  FirebaseCustomEvent({required this.message});
}

class FirebaseCustomReporter extends Reporter {
  @override
  Future<void> report(Event report) async {
    await FirebaseFirestore.instance.collection('logs').add(report.toMap());
  }
}
