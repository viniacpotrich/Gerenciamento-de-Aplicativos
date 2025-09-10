import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good/home/models/item_menu.dart';
import 'package:very_good/utils/routes.dart';

class HomeCubit extends Cubit<List<ItemMenu>> {
  HomeCubit()
      : super([
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
            color: Colors.green,
          ),
        ]);
}
