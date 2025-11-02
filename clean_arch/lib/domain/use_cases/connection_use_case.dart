import 'package:acta/acta.dart';
import 'package:clean_arch/data/repositories/connection_repository.dart';

class ConnectionUseCase {
  final ConnectionRepository repository;

  ConnectionUseCase(this.repository);

  Future<String> simulateHttp() {
    ActaJournal.addBreadcrumb('[$runtimeType.simulateHttp]');
    return repository.simulateHttpError();
  }

  Future<String> simulateBluetooth() {
    ActaJournal.addBreadcrumb('[$runtimeType.simulateBluetooth]');
    return repository.simulateBluetoothError();
  }

  Future<String> simulateMqtt() {
    ActaJournal.addBreadcrumb('[$runtimeType.simulateMqtt]');
    return repository.simulateMqttError();
  }
}
