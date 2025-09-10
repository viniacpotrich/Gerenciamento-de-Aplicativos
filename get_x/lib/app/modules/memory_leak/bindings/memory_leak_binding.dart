import 'package:get/get.dart';
import 'package:get_x/app/modules/memory_leak/controllers/memory_leak_controller.dart';

class MemoryLeakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MemoryLeakController>(() => MemoryLeakController());
  }
}
