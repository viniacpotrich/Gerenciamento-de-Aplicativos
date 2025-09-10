import 'package:acta/acta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good/code_errors/cubit/code_errors_controller.dart';

class CodeErrorsPage extends StatelessWidget {
  const CodeErrorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CodeErrorsCubit(),
      child: const CodeErrorsView(),
    );
  }
}

class CodeErrorsView extends StatelessWidget {
  const CodeErrorsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CodeErrorsCubit>().state;
    return Scaffold(
      appBar: AppBar(title: const Text('Code Errors')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: cubit.length,
        itemBuilder: (context, index) {
          final item = cubit[index];
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                onPressed: () {
                  Handler.addBreadcrumb('Pressed button on ${item.title}');
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
