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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:
                  () =>
                      NativeService.callNativeToast("Esse é um Toast Nativo."),
              child: Text('Chamar Toast Nativo'),
            ),
            ElevatedButton(
              onPressed: () => NativeService.callNativeError(),
              child: Text('Chamar erro de channel'),
            ),
          ],
        ),
      ),
    );
  }
}
