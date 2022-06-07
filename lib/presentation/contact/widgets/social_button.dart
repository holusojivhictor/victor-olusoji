import 'package:flutter/material.dart';

class SocialButtonData {
  final String tag;
  final String url;
  final IconData iconData;
  final Color? iconColor;

  SocialButtonData({
    required this.tag,
    required this.url,
    required this.iconData,
    this.iconColor,
  });
}

class SocialButton extends StatelessWidget {
  final String tag;
  final double width;
  final double elevation;
  final double height;
  final IconData iconData;
  final double iconSize;
  final Color iconColor;
  final Color buttonColor;
  final BoxDecoration? decoration;
  final VoidCallback? onPressed;

  const SocialButton({
    Key? key,
    required this.tag,
    required this.iconData,
    this.onPressed,
    this.width = 28,
    this.height = 28,
    this.elevation = 0,
    this.buttonColor = const Color(0xFFD9D9D9),
    this.iconColor = const Color(0xFF000000),
    this.iconSize = 18,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: decoration ?? BoxDecoration(
        shape: BoxShape.circle,
        color: buttonColor.withOpacity(0.6),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Icon(
          iconData,
          size: iconSize,
          color: iconColor.withOpacity(0.8),
        ),
      ),
    );
  }
}
