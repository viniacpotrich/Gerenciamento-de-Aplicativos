import 'package:acta/acta.dart';
import 'package:flutter/material.dart';

class ConnectionErrorScreen extends StatefulWidget {
  const ConnectionErrorScreen({super.key});

  @override
  State<ConnectionErrorScreen> createState() => _ConnectionErrorScreenState();
}

class _ConnectionErrorScreenState extends State<ConnectionErrorScreen> {
  String _status = "Select an error to simulate";

  Future<void> _simulateHttpError() async {
    setState(() => _status = "🌐 HTTP Request...");
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _status = "❌ HTTP 500 Internal Server Error");
    captureMethod(str: _status);
  }

  Future<void> _simulateBluetoothError() async {
    setState(() => _status = "🔍 Scanning Bluetooth...");
    await Future.delayed(const Duration(seconds: 3));
    setState(() => _status = "❌ Bluetooth device not found");
    captureMethod(str: _status);
  }

  Future<void> _simulateMqttError() async {
    setState(() => _status = "🔌 Connecting to MQTT...");
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _status = "❌ Failed to connect to MQTT broker");
    captureMethod(str: _status);
  }

  void captureMethod({required String str}) {
    ActaJournal.report(
      event: Event(message: str, severity: Severity.warning, tag: 'Connection'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connection Errors")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _status,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: _simulateHttpError,
                icon: const Icon(Icons.cloud_off),
                label: const Text("Simulate HTTP Error"),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _simulateBluetoothError,
                icon: const Icon(Icons.bluetooth_disabled),
                label: const Text("Simulate Bluetooth Error"),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _simulateMqttError,
                icon: const Icon(Icons.wifi_off),
                label: const Text("Simulate MQTT Error"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
