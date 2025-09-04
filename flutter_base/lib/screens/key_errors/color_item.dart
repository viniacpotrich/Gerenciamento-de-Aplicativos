import 'package:flutter/material.dart';

class ColorItem extends StatefulWidget {
  final Color initialColor;
  final String title;

  const ColorItem({super.key, required this.initialColor, required this.title});

  @override
  State<ColorItem> createState() => _ColorItemState();
}

class _ColorItemState extends State<ColorItem> {
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
