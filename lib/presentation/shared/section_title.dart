import 'package:flutter/material.dart';
import 'package:victor_olusoji/services/constants.dart';

import 'custom_indicator.dart';

class SectionTitle extends StatelessWidget {
  final String sectionTitle;
  final TextTheme textTheme;
  final double fontSize;
  final double width;
  final AnimationController controller;
  final Animation<Offset> slideAnimation;
  final Animation<double> fadeAnimation;
  final Color color;

  const SectionTitle({
    Key? key,
    required this.sectionTitle,
    required this.textTheme,
    required this.fontSize,
    required this.controller,
    required this.slideAnimation,
    required this.fadeAnimation,
    this.color = AppColors.primaryColor,
    this.width = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIndicator(width: width, controller: controller),
        const SizedBox(width: 10),
        SlideTransition(
          position: slideAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: Text(
              sectionTitle,
              style: textTheme.bodyMedium?.copyWith(
                fontSize: fontSize,
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}