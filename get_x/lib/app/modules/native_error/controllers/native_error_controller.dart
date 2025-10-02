import 'package:get/get.dart';
import 'package:get_x/app/data/services/native_service.dart';

class NativeErrorController extends GetxController {
  void callNative() => NativeService.callNativeError();
  void callNativeToast(String str) => NativeService.callNativeToast(str);
}
