import 'package:acta/acta.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_x/app/modules/db_errors/controllers/db_errors_controller.dart';

class DbErrorView extends GetView<DbErrorsController> {
  const DbErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Erros Tag")),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: controller.actions.length,
        itemBuilder: (context, index) {
          final item = controller.actions[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            child: ListTile(
              title: Text(
                item.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item.description),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                onPressed: () {
                  ActaJournal.addBreadcrumb("Pressed button on ${item.title}");
                  item.methodCapture();
                },
                child: Text("Trigger"),
              ),
            ),
          );
        },
      ),
    );
  }
}
