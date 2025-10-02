import 'package:clean_arch/data/services/native_service.dart';
import 'package:flutter/material.dart';

class NativeErrorViewModel extends ChangeNotifier {
  void callNativeError() => NativeService.callNativeError();
  void callNativeToast(String str) => NativeService.callNativeToast(str);
}
