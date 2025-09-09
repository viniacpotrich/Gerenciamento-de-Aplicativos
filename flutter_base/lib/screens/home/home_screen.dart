import 'package:flutter/material.dart';
import 'package:flutter_base/navigation/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildMenuButton({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String route,
    Color color = Colors.blue,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.pushNamed(context, route),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Row(
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 18),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuButton(
            context: context,
            title: 'Code Errors',
            icon: Icons.bug_report,
            route: Routes.codeErrorScreen,
            color: Colors.redAccent,
          ),
          _buildMenuButton(
            context: context,
            title: 'Key Error',
            icon: Icons.vpn_key,
            route: Routes.keyErrorScreen,
            color: Colors.deepPurple,
          ),
          _buildMenuButton(
            context: context,
            title: 'Memory Leak',
            icon: Icons.memory,
            route: Routes.memoryLeakScreen,
            color: Colors.amber,
          ),
          _buildMenuButton(
            context: context,
            title: 'Light Error',
            icon: Icons.running_with_errors,
            route: Routes.dbErrors,
            color: Colors.deepOrange,
          ),
          _buildMenuButton(
            context: context,
            title: 'Connection Error',
            icon: Icons.signal_cellular_off_sharp,
            route: Routes.connectionErrorScreen,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
