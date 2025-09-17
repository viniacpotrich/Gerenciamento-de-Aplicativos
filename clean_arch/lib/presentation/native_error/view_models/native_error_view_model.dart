import 'package:clean_arch/data/services/native_service.dart';
import 'package:flutter/material.dart';

class NativeErrorViewModel extends ChangeNotifier {
  void callNative() => NativeService.callNativeError();
}
