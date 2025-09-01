import 'package:acta/acta.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String title;
  final String breadcrumbName;
  final void Function() triggerError;

  const ErrorScreen({
    super.key,
    required this.title,
    required this.breadcrumbName,
    required this.triggerError,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          children: [
            Text('Forcar erro de cast'),
            Text('int inteiro = 0,0 as int'),
            ElevatedButton(
              onPressed: () {
                // Adiciona breadcrumb da navegação/ação
                Handler.addBreadcrumb('Pressed button on $breadcrumbName');
                // Chama função que dispara o erro
                triggerError();
              },
              child: Text('Trigger Error'),
            ),
          ],
        ),
      ),
    );
  }
}
