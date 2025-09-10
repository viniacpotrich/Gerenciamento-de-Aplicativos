import 'package:acta/acta.dart';
import 'package:get/get.dart';

class ConnectionErrorsController extends GetxController {
  RxString status = "Select an error to simulate".obs;

  Future<void> simulateHttpError() async {
    status.value = "🌐 HTTP Request...";
    await Future.delayed(const Duration(seconds: 2));
    status.value = "❌ HTTP 500 Internal Server Error";
    captureMethod(str: status.value);
  }

  Future<void> simulateBluetoothError() async {
    status.value = "🔍 Scanning Bluetooth...";
    await Future.delayed(const Duration(seconds: 3));
    status.value = "❌ Bluetooth device not found";
    captureMethod(str: status.value);
  }

  Future<void> simulateMqttError() async {
    status.value = "🔌 Connecting to MQTT...";
    await Future.delayed(const Duration(seconds: 2));
    status.value = "❌ Failed to connect to MQTT broker";
    captureMethod(str: status.value);
  }

  void captureMethod({required String str}) {
    Handler.capture(
      message: str,
      severity: Severity.warning,
      tag: 'Connection',
    );
  }
}
