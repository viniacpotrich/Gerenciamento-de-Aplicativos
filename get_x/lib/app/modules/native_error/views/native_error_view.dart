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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title: const Text(
              'Chamar Toast Nativo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Mostra um Toast no Android/iOS'),
            trailing: const Icon(Icons.check_circle_outline),
            onTap: () => controller.callNativeToast('Esse é um Toast Nativo.'),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          ListTile(
            title: const Text(
              'Chamar erro de channel',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Mostra um Erro ao chamar um channel que não existe',
            ),
            trailing: const Icon(Icons.error_outline),
            onTap: () => controller.callNative(),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
        ],
      ),
    );
  }
}
