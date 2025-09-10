import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good/home/controllers/home_controller.dart';
import 'package:very_good/home/views/widget_build_menu_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<HomeCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView.builder(
        itemCount: cubit.length,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemBuilder: (context, index) => WidgetBuildMenuButton(
          title: cubit[index].title,
          icon: cubit[index].icon,
          route: cubit[index].route,
          color: cubit[index].color,
        ),
      ),
    );
  }
}
