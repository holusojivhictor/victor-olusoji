import 'package:flutter/material.dart';
import 'package:victor_olusoji/services/constants.dart';

class AnimatedHoverIndicator extends StatelessWidget {
  final Color indicatorColor;
  final double width;
  final double height;
  final Curve curve;
  final Duration duration;
  final bool isHover;

  const AnimatedHoverIndicator({
    Key? key,
    required this.width,
    this.indicatorColor = AppColors.primaryColor,
    this.height = 6,
    this.curve = Curves.linearToEaseOut,
    this.isHover = false,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isHover ? width : 0,
      height: height,
      color: indicatorColor,
      duration: duration,
      curve: curve,
    );
  }
}

class AltAnimatedHoverIndicator extends StatelessWidget {
  final Color indicatorColor;
  final Animation<double> animation;
  final double height;
  final Curve curve;
  final Duration duration;
  final bool isHover;

  const AltAnimatedHoverIndicator({
    Key? key,
    required this.animation,
    this.indicatorColor = AppColors.primaryColor,
    this.height = 6,
    this.curve = Curves.linearToEaseOut,
    this.isHover = false,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: animation.value,
      height: height,
      color: indicatorColor,
      duration: duration,
      curve: curve,
    );
  }
}
