import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_x/app/modules/memory_leak/controllers/memory_leak_controller.dart';

class MemoryLeakView extends GetView<MemoryLeakController> {
  const MemoryLeakView({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Color>(
      valueListenable: controller.sharedColor,
      builder: (context, color, _) {
        return Scaffold(
          backgroundColor: color,
          appBar: AppBar(title: const Text('Memory Leak Screen')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Observe a cor mudar a cada 3 segundos',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Ou saia e entre denovo para vazar memoria',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Numero atual de escutas: ${controller.numberListener}',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
