import 'package:flutter/material.dart';

class RotationAppArrowIcon extends StatelessWidget {
  final Color? color;
  final double size;
  const RotationAppArrowIcon({
    super.key,
    required this.showList,
    required this.color,
    this.size = 40,
  });

  final bool showList;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      duration: const Duration(milliseconds: 300),
      turns: showList ? 0.5 : 1,
      child: Icon(
        Icons.keyboard_arrow_down_sharp,
        size: size,
        color: color,
      ),
    );
  }
}
