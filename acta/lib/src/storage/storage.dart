import '../model/event.dart';

abstract class Storage {
  Future<void> save(Event event);
}
