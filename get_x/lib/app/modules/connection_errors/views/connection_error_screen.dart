import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_x/app/modules/connection_errors/controllers/connection_errors_controller.dart';

class ConnectionErrorsScreen extends GetView<ConnectionErrorsController> {
  const ConnectionErrorsScreen({super.key});

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
                controller.status,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: controller.simulateHttpError,
                icon: const Icon(Icons.cloud_off),
                label: const Text("Simulate HTTP Error"),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: controller.simulateBluetoothError,
                icon: const Icon(Icons.bluetooth_disabled),
                label: const Text("Simulate Bluetooth Error"),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: controller.simulateMqttError,
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
