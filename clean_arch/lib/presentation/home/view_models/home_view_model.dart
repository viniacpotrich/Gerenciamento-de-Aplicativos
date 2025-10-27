import 'package:clean_arch/presentation/home/models/item_menu.dart';
import 'package:clean_arch/routes/routes.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final List<ItemMenu> menus = [
    ItemMenu(
      title: 'Code Errors',
      icon: Icons.bug_report,
      route: Routes.codeErrorScreen,
      color: Colors.redAccent,
    ),
    ItemMenu(
      title: 'Key Error',
      icon: Icons.vpn_key,
      route: Routes.keyErrorScreen,
      color: Colors.deepPurple,
    ),
    ItemMenu(
      title: 'Memory Leak',
      icon: Icons.memory,
      route: Routes.memoryLeakScreen,
      color: Colors.amber,
    ),
    ItemMenu(
      title: 'Light Error',
      icon: Icons.running_with_errors,
      route: Routes.dbErrors,
      color: Colors.deepOrange,
    ),
    ItemMenu(
      title: 'Connection Error',
      icon: Icons.signal_cellular_off_sharp,
      route: Routes.connectionErrorScreen,
      color: Colors.cyan,
    ),
    ItemMenu(
      title: 'Native Error',
      icon: Icons.android,
      route: Routes.nativeError,
      color: Colors.green,
    ),
    ItemMenu(
      title: 'Screen Error',
      icon: Icons.screenshot_outlined,
      route: Routes.screenError,
      color: Colors.blueGrey,
    ),
  ];
}
