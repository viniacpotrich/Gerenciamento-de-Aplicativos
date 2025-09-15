import 'package:clean_arch/presentation/key_errors/view_models/key_errors_view_model.dart';
import 'package:clean_arch/presentation/key_errors/views/widget_build_list_section.dart';
import 'package:flutter/material.dart';

class KeyErrorView extends StatefulWidget {
  const KeyErrorView({super.key, required this.viewModel});

  final KeyErrorsViewModel viewModel;

  @override
  State<KeyErrorView> createState() => _KeyErrorViewState();
}

class _KeyErrorViewState extends State<KeyErrorView> {
  @override
  void initState() {
    widget.viewModel.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Key Problem Example')),
      body: ListView(
        children: [
          WidgetBuildListSection(
            functionShuffle:
                () => widget.viewModel.shuffleList(
                  widget.viewModel.originalItems,
                ),
            title: 'Original Items',
            list: widget.viewModel.originalItems,
            hasSuffle: false,
          ),
          WidgetBuildListSection(
            functionShuffle:
                () => widget.viewModel.shuffleList(widget.viewModel.items),
            title: 'Unkeyed Items',
            list: widget.viewModel.items,
            hasSuffle: true,
          ),
          WidgetBuildListSection(
            functionShuffle:
                () => widget.viewModel.shuffleList(widget.viewModel.itemsFixed),
            title: 'Keyed Items',
            list: widget.viewModel.itemsFixed,
            hasSuffle: true,
          ),
        ],
      ),
    );
  }
}
