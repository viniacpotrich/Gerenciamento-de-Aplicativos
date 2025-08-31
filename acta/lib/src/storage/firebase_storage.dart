import 'storage.dart';
import '../event.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class FirebaseStorage implements Storage {
  @override
  Future<void> save(Event event) async {
    FirebaseCrashlytics.instance.recordError(
      event.exception,
      event.stackTrace,
      reason: event.message,
    );
  }
}
