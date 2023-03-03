import 'package:flutter/cupertino.dart';

class CustomDivider extends StatelessWidget {
  final double? space;
  final Color? color;
  final Axis direction;

  const CustomDivider({super.key, this.space, this.color, required this.direction});

  @override
  Widget build(BuildContext context) {
    if(direction == Axis.horizontal) {
      return Container(width: space ?? 10, color: color);
    } else {
      return Container(height: space ?? 10, color: color);
    }
  }
}