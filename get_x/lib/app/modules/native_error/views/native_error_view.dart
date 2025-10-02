import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/app/modules/native_error/controllers/native_error_controller.dart';

class NativeErrorView extends GetView<NativeErrorController> {
  const NativeErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NativeErrorController());
    return Scaffold(
      appBar: AppBar(title: const Text('Native Error Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:
                  () => controller.callNativeToast("Esse é um Toast Nativo."),
              child: Text('Chamar Toast Nativo'),
            ),
            ElevatedButton(
              onPressed: () => controller.callNative(),
              child: Text('Chamar erro de channel'),
            ),
          ],
        ),
      ),
    );
  }
}
