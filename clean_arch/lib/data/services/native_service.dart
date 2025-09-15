import 'package:flutter/services.dart';

class NativeService {
  static const platform = MethodChannel('error_channel');

  static Future<void> callNativeError() async {
    await platform.invokeMethod('throwError');
  }
}
