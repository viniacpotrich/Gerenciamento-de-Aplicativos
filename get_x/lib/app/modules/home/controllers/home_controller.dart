import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/app/modules/home/models/item_menu.dart';
import 'package:get_x/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final List<ItemMenu> menus = [
    ItemMenu(
      title: 'Code Errors',
      icon: Icons.bug_report,
      route: Routes.CODE_ERROR_SCREEN,
      color: Colors.redAccent,
    ),
    ItemMenu(
      title: 'Key Error',
      icon: Icons.vpn_key,
      route: Routes.KEY_SCREEN,
      color: Colors.deepPurple,
    ),
    ItemMenu(
      title: 'Memory Leak',
      icon: Icons.memory,
      route: Routes.MEMORY_LEAK_SCREEN,
      color: Colors.amber,
    ),
    ItemMenu(
      title: 'Light Error',
      icon: Icons.running_with_errors,
      route: Routes.DB_ERRORS_SCREEN,
      color: Colors.deepOrange,
    ),
    ItemMenu(
      title: 'Connection Error',
      icon: Icons.signal_cellular_off_sharp,
      route: Routes.CONNECTION_ERROR_SCREEN,
      color: Colors.cyan,
    ),
    ItemMenu(
      title: 'Native Error',
      icon: Icons.android,
      route: Routes.NATIVE_ERROR_SCREEN,
      color: Colors.green,
    ),
    ItemMenu(
      title: 'Screen Error',
      icon: Icons.screenshot_outlined,
      route: Routes.SCREEN_ERROR_SCREEN,
      color: Colors.blueGrey,
    ),
  ];
}
