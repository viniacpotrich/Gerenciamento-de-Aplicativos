import 'package:clean_arch/presentation/key_errors/views/widget_color_item.dart';
import 'package:flutter/material.dart';

class KeyErrorsViewModel extends ChangeNotifier {
  final List<WidgetColorItem> originalItems = [
    const WidgetColorItem(initialColor: Colors.red, title: 'Item 1 RED'),
    const WidgetColorItem(initialColor: Colors.blue, title: 'Item 2 BLUE'),
    const WidgetColorItem(initialColor: Colors.green, title: 'Item 3 GREEN'),
  ];

  late List<WidgetColorItem> items;
  late List<WidgetColorItem> itemsFixed;

  void onInit() {
    items = List.generate(
      originalItems.length,
      (index) => originalItems[index],
    );
    itemsFixed = List.generate(
      originalItems.length,
      (index) => WidgetColorItem(
        key: ValueKey('item1'),
        initialColor: originalItems[index].initialColor,
        title: originalItems[index].title,
      ),
    );
  }

  void shuffleList(List<WidgetColorItem> list) {
    list.shuffle();
    notifyListeners();
  }

  // void removeItem(List<WidgetColorItem> list) {
  //   list.removeLast();
  //   notifyListeners();
  //   return;
  // }
}
