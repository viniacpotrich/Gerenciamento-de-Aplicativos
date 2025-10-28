import 'package:clean_arch/data/repositories/connection_repository.dart';

class ConnectionUseCase {
  final ConnectionRepository repository;

  ConnectionUseCase(this.repository);

  Future<String> simulateHttp() => repository.simulateHttpError();
  Future<String> simulateBluetooth() => repository.simulateBluetoothError();
  Future<String> simulateMqtt() => repository.simulateMqttError();
}
