import 'package:acta/acta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good/db_errors/controllers/db_errors_controller.dart';

class DbErrorsPage extends StatelessWidget {
  const DbErrorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DbErrorsCubit(),
      child: const DbErrorView(),
    );
  }
}

class DbErrorView extends StatelessWidget {
  const DbErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DbErrorsCubit>().state;
    return Scaffold(
      appBar: AppBar(title: const Text('Erros Tag')),
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
                  ActaJournal.addBreadcrumb('Pressed button on ${item.title}');
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
