import 'package:get/get.dart';

import '../controllers/key_errors_controller.dart';

class KeyErrorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeyErrorsController>(() => KeyErrorsController());
  }
}
