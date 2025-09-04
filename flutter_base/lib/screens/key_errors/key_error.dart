import 'package:flutter/material.dart';
import 'package:flutter_base/screens/key_errors/color_item.dart';

class KeyErrorScreen extends StatefulWidget {
  const KeyErrorScreen({super.key});

  @override
  State<KeyErrorScreen> createState() => _KeyErrorScreenState();
}

class _KeyErrorScreenState extends State<KeyErrorScreen> {
  final List<ColorItem> _originalItems = [
    const ColorItem(initialColor: Colors.red, title: 'Item 1 RED'),
    const ColorItem(initialColor: Colors.blue, title: 'Item 2 BLUE'),
    const ColorItem(initialColor: Colors.green, title: 'Item 3 GREEN'),
  ];

  @override
  void initState() {
    _items = List.generate(
      _originalItems.length,
      (index) => _originalItems[index],
    );
    _itemsFixed = List.generate(
      _originalItems.length,
      (index) => ColorItem(
        key: ValueKey('item1'),
        initialColor: _originalItems[index].initialColor,
        title: _originalItems[index].title,
      ),
    );
    super.initState();
  }

  late List<ColorItem> _items;
  late List<ColorItem> _itemsFixed;

  void _shuffleItems(List<ColorItem> list) => setState(() => list.shuffle());
  // void _removeItem(List<ColorItem> list) => setState(() => list.removeLast());

  Widget _buildListSection(String title, List<ColorItem> list, bool hasSuffle) {
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
                    onPressed: () => _shuffleItems(list),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Key Problem Example')),
      body: ListView(
        children: [
          _buildListSection('Original Items', _originalItems, false),
          _buildListSection('Unkeyed Items', _items, true),
          _buildListSection('Keyed Items', _itemsFixed, true),
        ],
      ),
    );
  }
}
