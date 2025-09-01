import 'package:flutter/foundation.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'storage.dart';
import '../event.dart';

class MongoStorage implements Storage {
  final String connectionString;
  final String dbName;
  final String collection;

  MongoStorage({
    required this.connectionString,
    required this.dbName,
    required this.collection,
  });

  Future<Db> _connect() async {
    final db = Db(connectionString);
    await db.open();
    return db;
  }

  @override
  Future<void> save(Event event) async {
    try {
      final db = await _connect();
      final coll = db.collection(collection);

      await coll.insertOne({
        'message': event.message,
        'severity': event.severity.toString(),
        'timestamp': event.timestamp.toIso8601String(),
        'exception': event.exception?.toString(),
        'stackTrace': event.stackTrace?.toString(),
        'metadata': event.metadata,
        'breadcrumbs': event.breadcrumbs,
      });

      await db.close();
      debugPrint('Evento salvo no MongoDB: ${event.message}');
    } catch (e, s) {
      debugPrint('Erro ao salvar no MongoDB: $e\n$s');
    }
  }
}
