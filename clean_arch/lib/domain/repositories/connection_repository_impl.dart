// data/repositories/error_simulation_repository_impl.dart
import 'dart:async';

import 'package:clean_arch/data/repositories/connection_repository.dart';

class ConnectionRepositoryImpl implements ConnectionRepository {
  @override
  Future<String> simulateHttpError() async {
    await Future.delayed(const Duration(seconds: 2));
    return "❌ HTTP 500 Internal Server Error";
  }

  @override
  Future<String> simulateBluetoothError() async {
    await Future.delayed(const Duration(seconds: 3));
    return "❌ Bluetooth device not found";
  }

  @override
  Future<String> simulateMqttError() async {
    await Future.delayed(const Duration(seconds: 2));
    return "❌ Failed to connect to MQTT broker";
  }
}
