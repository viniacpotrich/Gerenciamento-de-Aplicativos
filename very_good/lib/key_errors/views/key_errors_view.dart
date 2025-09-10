import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good/key_errors/controllers/key_errors_controller.dart';
import 'package:very_good/key_errors/views/widget_build_list_section.dart';

class KeyErrorsPage extends StatelessWidget {
  const KeyErrorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => KeyErrorsCubit(),
      child: const KeyErrorView(),
    );
  }
}

class KeyErrorView extends StatelessWidget {
  const KeyErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<KeyErrorsCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Key Problem Example')),
      body: ListView(
        children: [
          WidgetBuildListSection(
            functionShuffle: () => cubit.shuffleList(ListType.original),
            title: 'Original Items',
            list: cubit.state.originalItems,
            hasSuffle: false,
          ),
          WidgetBuildListSection(
            functionShuffle: () => cubit.shuffleList(ListType.items),
            title: 'Unkeyed Items',
            list: cubit.state.items,
            hasSuffle: true,
          ),
          WidgetBuildListSection(
            functionShuffle: () => cubit.shuffleList(ListType.itemsFixed),
            title: 'Keyed Items',
            list: cubit.state.itemsFixed,
            hasSuffle: true,
          ),
        ],
      ),
    );
  }
}
