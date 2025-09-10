import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_x/app/modules/key_errors/controllers/key_errors_controller.dart';
import 'package:get_x/app/modules/key_errors/views/widget_build_list_section.dart';

class KeyErrorView extends GetView<KeyErrorsController> {
  const KeyErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Key Problem Example')),
      body: ListView(
        children: [
          WidgetBuildListSection(
            controller: controller,
            title: 'Original Items',
            list: controller.originalItems,
            hasSuffle: false,
          ),
          WidgetBuildListSection(
            controller: controller,
            title: 'Unkeyed Items',
            list: controller.items,
            hasSuffle: true,
          ),
          WidgetBuildListSection(
            controller: controller,
            title: 'Keyed Items',
            list: controller.itemsFixed,
            hasSuffle: true,
          ),
        ],
      ),
    );
  }
}
