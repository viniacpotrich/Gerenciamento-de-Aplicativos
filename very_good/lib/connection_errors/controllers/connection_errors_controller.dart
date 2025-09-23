import 'package:acta/acta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionErrorsCubit extends Cubit<String> {
  ConnectionErrorsCubit() : super('Select an error to simulate');

  Future<void> simulateHttpError() async {
    emit('🌐 HTTP Request...');
    await Future<void>.delayed(const Duration(seconds: 2));
    const msg = '❌ HTTP 500 Internal Server Error';
    emit(msg);
    captureMethod(msg);
  }

  Future<void> simulateBluetoothError() async {
    emit('🔍 Scanning Bluetooth...');
    await Future<void>.delayed(const Duration(seconds: 3));
    const msg = '❌ Bluetooth device not found';
    emit(msg);
    captureMethod(msg);
  }

  Future<void> simulateMqttError() async {
    emit('🔌 Connecting to MQTT...');
    await Future<void>.delayed(const Duration(seconds: 2));
    const msg = '❌ Failed to connect to MQTT broker';
    emit(msg);
    captureMethod(msg);
  }

  void captureMethod(String str) {
    ActaJournal.report(
      event: Event(
        message: str,
        severity: Severity.warning,
        tag: 'Connection',
      ),
    );
  }
}
