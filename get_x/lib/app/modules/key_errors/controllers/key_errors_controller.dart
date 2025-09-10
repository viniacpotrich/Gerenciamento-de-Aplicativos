import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/app/modules/key_errors/views/widget_color_item.dart';

class KeyErrorsController extends GetxController {
  final RxList<WidgetColorItem> originalItems =
      [
        const WidgetColorItem(initialColor: Colors.red, title: 'Item 1 RED'),
        const WidgetColorItem(initialColor: Colors.blue, title: 'Item 2 BLUE'),
        const WidgetColorItem(
          initialColor: Colors.green,
          title: 'Item 3 GREEN',
        ),
      ].obs;

  @override
  void onInit() {
    super.onInit();
    items =
        List.generate(
          originalItems.length,
          (index) => originalItems[index],
        ).obs;
    itemsFixed =
        List.generate(
          originalItems.length,
          (index) => WidgetColorItem(
            key: ValueKey('item1'),
            initialColor: originalItems[index].initialColor,
            title: originalItems[index].title,
          ),
        ).obs;
  }

  late RxList<WidgetColorItem> items;
  late RxList<WidgetColorItem> itemsFixed;

  void shuffleItems(List<WidgetColorItem> list) => list.shuffle();
  // void _removeItem(List<ColorItem> list) => setState(() => list.removeLast());
}
