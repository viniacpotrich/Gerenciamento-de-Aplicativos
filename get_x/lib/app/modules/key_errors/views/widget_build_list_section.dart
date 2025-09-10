import 'package:flutter/material.dart';
import 'package:get_x/app/modules/key_errors/controllers/key_errors_controller.dart';
import 'package:get_x/app/modules/key_errors/views/widget_color_item.dart';

class WidgetBuildListSection extends StatelessWidget {
  const WidgetBuildListSection({
    super.key,
    required this.controller,
    required this.title,
    required this.list,
    required this.hasSuffle,
  });

  final KeyErrorsController controller;
  final String title;
  final List<WidgetColorItem> list;
  final bool hasSuffle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (hasSuffle)
                  ElevatedButton.icon(
                    onPressed: () => controller.shuffleItems(list),
                    icon: const Icon(Icons.shuffle),
                    label: const Text('Shuffle'),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder:
                  (_, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: list[index],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
