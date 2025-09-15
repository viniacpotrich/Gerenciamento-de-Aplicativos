import 'package:acta/acta.dart';
import 'package:clean_arch/presentation/db_errors/view_models/db_errors_view_model.dart';
import 'package:flutter/material.dart';

class DbErrorView extends StatelessWidget {
  const DbErrorView({super.key, required this.viewModel});
  final DbErrorsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Erros Tag')),
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
                  Handler.addBreadcrumb('Pressed button on ${item.title}');
                  item.methodCapture();
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
