import 'package:flutter/material.dart';
import 'package:victor_olusoji/services/constants.dart';

class SelectedIndicator extends StatelessWidget {
  final Color indicatorColor;
  final double width;
  final double height;
  final double opacity;

  const SelectedIndicator({
    Key? key,
    required this.width,
    this.indicatorColor = AppColors.primaryColor,
    this.height = 6,
    this.opacity = 0.85,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
          color: indicatorColor,
        ),
        height: height,
        width: width,
      ),
    );
  }
}
