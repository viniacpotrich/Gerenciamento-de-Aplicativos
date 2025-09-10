import 'package:flutter/material.dart';
import 'package:very_good/key_errors/views/widget_color_item.dart';

class WidgetBuildListSection extends StatelessWidget {
  const WidgetBuildListSection({
    required this.functionShuffle,
    required this.title,
    required this.list,
    required this.hasSuffle,
    super.key,
  });

  final void Function() functionShuffle;
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
                    onPressed: functionShuffle,
                    icon: const Icon(Icons.shuffle),
                    label: const Text('Shuffle'),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (_, index) => Padding(
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
