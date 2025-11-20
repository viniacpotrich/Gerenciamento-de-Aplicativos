import 'package:get/get.dart';
import 'package:get_x/app/modules/screen_error/controllers/screen_error_controller.dart';

class NativeErrorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScreenErrorController>(() => ScreenErrorController());
  }
}
