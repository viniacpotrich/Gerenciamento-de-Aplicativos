import 'package:clean_arch/presentation/home/view_models/home_view_model.dart';
import 'package:clean_arch/presentation/home/views/widget_build_menu_button.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView.builder(
        itemCount: viewModel.menus.length,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemBuilder:
            (context, index) => WidgetBuildMenuButton(
              title: viewModel.menus[index].title,
              icon: viewModel.menus[index].icon,
              route: viewModel.menus[index].route,
              color: viewModel.menus[index].color,
            ),
      ),
    );
  }
}
