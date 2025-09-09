import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_x/app/modules/home/views/widget_build_menu_button.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView.builder(
        itemCount: controller.menus.length,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemBuilder:
            (context, index) => WidgetBuildMenuButton(
              title: controller.menus[index].title,
              icon: controller.menus[index].icon,
              route: controller.menus[index].route,
              color: controller.menus[index].color,
            ),
      ),
    );
  }
}
