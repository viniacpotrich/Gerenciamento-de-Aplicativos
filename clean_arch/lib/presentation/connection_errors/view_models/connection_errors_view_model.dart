import 'package:acta/acta.dart';
import 'package:flutter/widgets.dart';

class ConnectionErrorsViewModel extends ChangeNotifier {
  String status = "Select an error to simulate";

  Future<void> simulateHttpError() async {
    status = '🌐 HTTP Request...';
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    const msg = '❌ HTTP 500 Internal Server Error';
    status = msg;
    notifyListeners();
    captureMethod(msg);
  }

  Future<void> simulateBluetoothError() async {
    status = '🔍 Scanning Bluetooth...';
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    const msg = '❌ Bluetooth device not found';
    status = msg;
    notifyListeners();
    captureMethod(msg);
  }

  Future<void> simulateMqttError() async {
    status = '🔌 Connecting to MQTT...';
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    const msg = '❌ Failed to connect to MQTT broker';
    status = msg;
    notifyListeners();
    captureMethod(msg);
  }

  void captureMethod(String str) {
    ActaJournal.report(
      event: Event(message: str, severity: Severity.warning, tag: 'Connection'),
    );
  }
}
