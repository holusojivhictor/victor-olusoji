import 'package:flutter/material.dart';

class ContentArea extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;
  final BorderRadius borderRadius;
  final Widget? child;

  const ContentArea({
    this.width,
    this.height,
    this.backgroundColor,
    this.padding,
    this.decoration,
    this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      height: height,
      decoration: decoration ?? BoxDecoration(color: backgroundColor, borderRadius: borderRadius),
      child: child,
    );
  }
}
