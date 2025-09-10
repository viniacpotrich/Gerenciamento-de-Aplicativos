import 'package:get/get.dart';

import '../controllers/connection_errors_controller.dart';

class ConnectionErrorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionErrorsController>(() => ConnectionErrorsController());
  }
}
