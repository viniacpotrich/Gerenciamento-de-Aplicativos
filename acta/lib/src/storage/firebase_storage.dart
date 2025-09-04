import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../model/event.dart';
import 'storage.dart';

class FirebaseStorage implements Storage {
  final FirebaseFirestore firestore;
  final String collection;

  FirebaseStorage({
    FirebaseFirestore? firestoreInstance,
    this.collection = 'error_logs',
  }) : firestore = firestoreInstance ?? FirebaseFirestore.instance;

  @override
  Future<void> save(Event event) async {
    try {
      await firestore.collection(collection).add({
        'message': event.message,
        'severity': event.severity.toString(),
        'timestamp': event.timestamp.toIso8601String(),
        'exception': event.exception?.toString(),
        'stackTrace': event.stackTrace?.toString(),
        'metadata': event.metadata,
        'breadcrumbs': event.breadcrumbs,
        'fingerPrint': event.fingerPrint,
        'tag': event.tag,
      });
      debugPrint('Evento salvo no Firebase: ${event.message}');
    } catch (e, s) {
      debugPrint('Erro ao salvar no Firebase: $e\n$s');
    }
  }
}
