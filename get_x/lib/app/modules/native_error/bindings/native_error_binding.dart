import 'package:get/get.dart';
import 'package:get_x/app/modules/native_error/controllers/native_error_controller.dart';

class NativeErrorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NativeErrorController>(() => NativeErrorController());
  }
}
