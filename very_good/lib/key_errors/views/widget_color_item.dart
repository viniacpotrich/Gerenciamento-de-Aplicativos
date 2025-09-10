import 'package:flutter/material.dart';

class WidgetColorItem extends StatefulWidget {
  final Color initialColor;
  final String title;

  const WidgetColorItem({
    super.key,
    required this.initialColor,
    required this.title,
  });

  @override
  State<WidgetColorItem> createState() => _WidgetColorItemState();
}

class _WidgetColorItemState extends State<WidgetColorItem> {
  late Color _color;

  @override
  void initState() {
    super.initState();
    _color = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: _color,
      child: Center(child: Text(widget.title)),
    );
  }
}
