import 'package:acta/acta.dart';
import 'package:flutter/material.dart';

class DbErrorScreen extends StatefulWidget {
  const DbErrorScreen({super.key});

  @override
  State<DbErrorScreen> createState() => _DbErrorScreenState();
}

class _DbErrorScreenState extends State<DbErrorScreen> {
  final List<_ErrorAction> actions = [
    _ErrorAction(
      title: "Blue Screen Error",
      description: "Apenas um erro com tag de Blue Screen",
      tag: "Blue Screen",
    ),
    _ErrorAction(
      title: "Just warning",
      description: "Nem erro e",
      tag: "Just warning",
    ),
    _ErrorAction(title: "Virus", description: "HELP", tag: "Virus"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Erros Tag")),
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

class _ErrorAction {
  final String title;
  final String description;
  final String tag;
  _ErrorAction({
    required this.title,
    required this.description,
    required this.tag,
  });

  void methodCapture() {
    ActaJournal.report(
      event: BaseEvent(
        message:
            '$title Apenas um teste de erro com TAG = $tag e desc = $description',
        severity: Severity.info,
        tag: tag,
      ),
    );
  }
}
