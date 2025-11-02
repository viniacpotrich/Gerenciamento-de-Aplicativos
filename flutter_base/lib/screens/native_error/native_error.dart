// A simple service that we can listen to
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeService {
  static const errorChannel = MethodChannel('error_channel');
  static Future<void> callNativeError() async {
    await errorChannel.invokeMethod('throwError');
  }

  static const toastChannel = MethodChannel("toast_channel");
  static Future<void> callNativeToast(String message) async {
    try {
      await toastChannel.invokeMethod("showToast", {"message": message});
    } on PlatformException catch (e) {
      print("Erro ao chamar toast: ${e.message}");
    }
  }
}

class NativeErrorScreen extends StatelessWidget {
  const NativeErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Native Error Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: const Text(
                'Chamar Toast Nativo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Mostra um Toast no Android/iOS'),
              trailing: const Icon(Icons.check_circle_outline),
              onTap:
                  () =>
                      NativeService.callNativeToast('Esse é um Toast Nativo.'),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
            ListTile(
              title: const Text(
                'Chamar erro de channel',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Mostra um Erro ao chamar um channel que não existe',
              ),
              trailing: const Icon(Icons.error_outline),
              onTap: () => NativeService.callNativeError(),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
