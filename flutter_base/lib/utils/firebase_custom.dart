// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:acta/acta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseCustomEvent extends Event {
  final String message;
  @override
  Map<String, dynamic> toMap() => {'message': message};

  FirebaseCustomEvent({required this.message});
}

class FirebaseCustomReporter extends Reporter {
  @override
  Future<void> report(Event report) async {
    // Check that Firebase is initialized but don’t re-init it
    if (Firebase.apps.isEmpty) {
      print('Firebase not initialized. Call Firebase.initializeApp() first.');
    }

    await FirebaseFirestore.instance.collection('logs').add(report.toMap());
  }
}
