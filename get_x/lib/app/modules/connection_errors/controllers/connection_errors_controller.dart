import 'package:acta/acta.dart';
import 'package:get/get.dart';

class ConnectionErrorsController extends GetxController {
  String status = "Select an error to simulate";

  Future<void> simulateHttpError() async {
    status = "🌐 HTTP Request...";
    await Future.delayed(const Duration(seconds: 2));
    status = "❌ HTTP 500 Internal Server Error";
    captureMethod(str: status);
  }

  Future<void> simulateBluetoothError() async {
    status = "🔍 Scanning Bluetooth...";
    await Future.delayed(const Duration(seconds: 3));
    status = "❌ Bluetooth device not found";
    captureMethod(str: status);
  }

  Future<void> simulateMqttError() async {
    status = "🔌 Connecting to MQTT...";
    await Future.delayed(const Duration(seconds: 2));
    status = "❌ Failed to connect to MQTT broker";
    captureMethod(str: status);
  }

  void captureMethod({required String str}) {
    Handler.capture(
      message: str,
      severity: Severity.warning,
      tag: 'Connection',
    );
  }
}
