import 'package:flutter/services.dart';

class NativeService {
  static const platform = MethodChannel('error_channel');

  Future<void> callNativeError() async {
    await platform.invokeMethod('throwError');
  }
}
