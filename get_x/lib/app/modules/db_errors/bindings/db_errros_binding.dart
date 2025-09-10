import 'package:get/get.dart';

import '../controllers/db_errors_controller.dart';

class DbErrorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DbErrorsController>(() => DbErrorsController());
  }
}
