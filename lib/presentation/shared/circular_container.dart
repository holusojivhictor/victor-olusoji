import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final IconData iconData;
  final double iconSize;
  final Color iconColor;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final Widget? child;

  const CircularContainer({
    Key? key,
    this.iconData = Icons.check,
    this.iconColor = Colors.white,
    this.iconSize = 24,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.backgroundColor = Colors.black54,
    this.padding = const EdgeInsets.all(4),
    this.child,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: child ?? Icon(iconData, color: iconColor, size: iconSize),
    );
  }
}
