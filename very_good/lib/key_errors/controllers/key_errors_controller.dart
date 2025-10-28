import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good/key_errors/views/widget_color_item.dart';

class KeyErrorsState {
  const KeyErrorsState({
    required this.originalItems,
    required this.items,
    required this.itemsFixed,
  });
  final List<WidgetColorItem> originalItems;
  final List<WidgetColorItem> items;
  final List<WidgetColorItem> itemsFixed;

  KeyErrorsState copyWith({
    List<WidgetColorItem>? originalItems,
    List<WidgetColorItem>? items,
    List<WidgetColorItem>? itemsFixed,
  }) {
    return KeyErrorsState(
      originalItems: originalItems ?? this.originalItems,
      items: items ?? this.items,
      itemsFixed: itemsFixed ?? this.itemsFixed,
    );
  }
}

class KeyErrorsCubit extends Cubit<KeyErrorsState> {
  KeyErrorsCubit()
      : super(
          const KeyErrorsState(
            originalItems: [
              WidgetColorItem(initialColor: Colors.red, title: 'Item 1 RED'),
              WidgetColorItem(initialColor: Colors.blue, title: 'Item 2 BLUE'),
              WidgetColorItem(
                initialColor: Colors.green,
                title: 'Item 3 GREEN',
              ),
            ],
            items: [],
            itemsFixed: [],
          ),
        ) {
    _initializeLists();
  }

  void _initializeLists() {
    final items = List<WidgetColorItem>.from(state.originalItems);
    final itemsFixed = state.originalItems.map((item) {
      return WidgetColorItem(
        key: ValueKey(item.title),
        initialColor: item.initialColor,
        title: item.title,
      );
    }).toList();

    emit(state.copyWith(items: items, itemsFixed: itemsFixed));
  }

  void shuffleList(ListType type) {
    switch (type) {
      case ListType.original:
        emit(
          state.copyWith(
            originalItems: List.of(state.originalItems)..shuffle(),
          ),
        );
      case ListType.items:
        emit(
          state.copyWith(
            items: List.of(state.items)..shuffle(),
          ),
        );
      case ListType.itemsFixed:
        emit(
          state.copyWith(
            itemsFixed: List.of(state.itemsFixed)..shuffle(),
          ),
        );
    }
  }
}

enum ListType { original, items, itemsFixed }
