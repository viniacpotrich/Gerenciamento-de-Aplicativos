import 'package:acta/acta.dart';
import 'package:clean_arch/presentation/code_errors/view_models/code_errors_controller.dart';
import 'package:flutter/material.dart';

class CodeErrorsView extends StatelessWidget {
  const CodeErrorsView({super.key, required this.viewModel});
  final CodeErrorsViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Code Errors')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: viewModel.actions.length,
        itemBuilder: (context, index) {
          final item = viewModel.actions[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            child: ListTile(
              title: Text(
                item.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item.description),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                onPressed: () {
                  ActaJournal.addBreadcrumb('Pressed button on ${item.title}');
                  item.action();
                },
                child: const Text('Trigger'),
              ),
            ),
          );
        },
      ),
    );
  }
}
