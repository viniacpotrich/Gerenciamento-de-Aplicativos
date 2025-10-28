// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:acta/acta.dart';
import 'package:clean_arch/domain/use_cases/connection_use_case.dart';
import 'package:flutter/widgets.dart';

class ConnectionErrorsViewModel extends ChangeNotifier {
  final ConnectionUseCase useCase;

  String status = "Select an error to simulate";
  ConnectionErrorsViewModel({required this.useCase});

  Future<void> simulateHttpError() async {
    status = '🌐 HTTP Request...';
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    var msg = await useCase.simulateHttp();
    status = msg;
    notifyListeners();
    captureMethod(msg);
  }

  Future<void> simulateBluetoothError() async {
    status = '🔍 Scanning Bluetooth...';
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    var msg = await useCase.simulateBluetooth();
    status = msg;
    notifyListeners();
    captureMethod(msg);
  }

  Future<void> simulateMqttError() async {
    status = '🔌 Connecting to MQTT...';
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    var msg = await useCase.simulateMqtt();
    status = msg;
    notifyListeners();
    captureMethod(msg);
  }

  void captureMethod(String str) {
    ActaJournal.report(
      event: BaseEvent(
        message: str,
        severity: Severity.warning,
        tag: 'Connection',
      ),
    );
  }
}
