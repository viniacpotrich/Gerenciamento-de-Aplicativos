import 'package:get/get.dart';

import '../controllers/code_errors_controller.dart';

class CodeErrorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CodeErrorsController>(() => CodeErrorsController());
  }
}
