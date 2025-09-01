import 'package:flutter/material.dart';
import 'package:flutter_base/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Erro Test Home')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.errorScreenCast);
            },
            child: const Text('Error 1'),
          ),
        ],
      ),
    );
  }
}
