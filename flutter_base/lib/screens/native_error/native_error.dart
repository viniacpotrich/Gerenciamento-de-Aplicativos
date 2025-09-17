// A simple service that we can listen to
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeService {
  static const platform = MethodChannel('error_channel');

  static Future<void> callNativeError() async {
    await platform.invokeMethod('throwError');
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
              onPressed: () => NativeService.callNativeError(),
              child: Text('Chamar erro de channel'),
            ),
          ],
        ),
      ),
    );
  }
}
