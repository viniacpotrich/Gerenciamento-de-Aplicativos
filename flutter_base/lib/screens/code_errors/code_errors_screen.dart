import 'package:acta/acta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/utils/code_errors.dart';

class CodeErrorsScreen extends StatefulWidget {
  const CodeErrorsScreen({super.key});

  @override
  State<CodeErrorsScreen> createState() => _CodeErrorsScreenState();
}

class _CodeErrorsScreenState extends State<CodeErrorsScreen> {
  final List<_ErrorAction> actions = [
    _ErrorAction(
      title: "Cast Error",
      description: "int inteiro = 0.0 as int",
      action: methodErrorCast,
    ),
    _ErrorAction(
      title: "Divide by Zero",
      description: "10 ~/ 0",
      action: methodDivideByZero,
    ),
    _ErrorAction(
      title: "Null Check Error",
      description: "text!.length",
      action: methodNullError,
    ),
    _ErrorAction(
      title: "Range Error",
      description: "list[99]",
      action: methodRangeError,
    ),
    _ErrorAction(
      title: "Format Error",
      description: "int.parse('not_a_number')",
      action: methodFormatError,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Code Errors")),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: actions.length,
        itemBuilder: (context, index) {
          final item = actions[index];
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
                  item.action();
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

class _ErrorAction {
  final String title;
  final String description;
  final VoidCallback action;
  _ErrorAction({
    required this.title,
    required this.description,
    required this.action,
  });
}
