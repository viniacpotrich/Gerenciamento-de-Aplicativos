import 'package:flutter/services.dart';

class NativeService {
  static const errorChannel = MethodChannel('error_channel');
  static Future<void> callNativeError() async {
    await errorChannel.invokeMethod('throwError');
  }

  static const toastChannel = MethodChannel('toast_channel');
  static Future<void> callNativeToast(String message) async {
    try {
      await toastChannel.invokeMethod('showToast', {'message': message});
    } on PlatformException catch (e) {
      print('Erro ao chamar toast: ${e.message}');
    }
  }
}
