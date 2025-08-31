import 'storage.dart';
import '../event.dart';

class CompositeStorage implements Storage {
  final List<Storage> storages;

  CompositeStorage(this.storages);

  @override
  Future<void> save(Event event) async {
    for (var storage in storages) {
      await storage.save(event);
    }
  }
}
