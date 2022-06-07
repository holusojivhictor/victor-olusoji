import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomIndicator extends StatelessWidget {
  final Color indicatorColor;
  final double width;
  final double height;
  final double opacity;
  final BorderRadius borderRadius;
  final Curve curve;
  final AnimationController controller;

  CustomIndicator({
    Key? key,
    required this.width,
    required this.controller,
    this.indicatorColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(3)),
    this.height = 6,
    this.opacity = 0.85,
    this.curve = Curves.linearToEaseOut,
  }) : super(key: key);

  late Animation<double> animation = Tween(begin: 0.0, end: width).animate(
    CurvedAnimation(
      parent: controller,
      curve: curve,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              color: indicatorColor,
              borderRadius: borderRadius,
            ),
            height: height,
            width: animation.value,
          );
        },
      ),
    );
  }
}