abstract class ConnectionRepository {
  Future<String> simulateHttpError();
  Future<String> simulateBluetoothError();
  Future<String> simulateMqttError();
}
