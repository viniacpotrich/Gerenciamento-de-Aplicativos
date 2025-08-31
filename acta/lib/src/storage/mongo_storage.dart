import 'package:flutter/foundation.dart';

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

  @override
  Future<void> save(Event event) async {
    // Exemplo conceitual, integração real dependeria do mongo_dart
    debugPrint('Salvando no MongoDB: ${event.message}');
  }
}
