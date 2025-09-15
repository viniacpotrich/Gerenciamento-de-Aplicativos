import 'package:clean_arch/presentation/connection_errors/view_models/connection_errors_view_model.dart';
import 'package:flutter/material.dart';

class ConnectionErrorsView extends StatelessWidget {
  const ConnectionErrorsView({super.key, required this.viewModel});

  final ConnectionErrorsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connection Errors')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                viewModel.status,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: viewModel.simulateHttpError,
                icon: const Icon(Icons.cloud_off),
                label: const Text('Simulate HTTP Error'),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: viewModel.simulateBluetoothError,
                icon: const Icon(Icons.bluetooth_disabled),
                label: const Text('Simulate Bluetooth Error'),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: viewModel.simulateMqttError,
                icon: const Icon(Icons.wifi_off),
                label: const Text('Simulate MQTT Error'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
