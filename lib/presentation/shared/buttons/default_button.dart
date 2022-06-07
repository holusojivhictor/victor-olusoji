import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';
import 'package:victor_olusoji/services/constants.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final String buttonTitle;
  final TextStyle? titleStyle;
  final Color titleColor;
  final Color buttonColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry padding;
  final String url;
  final LinkTarget linkTarget;
  final bool opensUrl;

  const DefaultButton({
    Key? key,
    required this.buttonTitle,
    this.width = 150,
    this.height = 60,
    this.titleStyle,
    this.titleColor = Colors.white,
    this.buttonColor = AppColors.primaryColor,
    this.onPressed,
    this.padding = const EdgeInsets.all(8),
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.opensUrl = false,
    this.url = "",
    this.linkTarget = LinkTarget.blank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: MaterialButton(
        minWidth: width,
        height: height,
        onPressed: opensUrl ? () {} : onPressed,
        color: buttonColor,
        child: Padding(
          padding: padding,
          child: buildChild(context),
        ),
      ),
    );
  }

  Widget buildChild(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double textSize = responsiveSize(context, 14, 16, md: 15);
    if (opensUrl) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Link(
          uri: Uri.parse(url),
          target: linkTarget,
          builder: (context, followLink) {
            return GestureDetector(
              onTap: followLink,
              child: Text(
                buttonTitle,
                style: titleStyle ?? textTheme.button?.copyWith(
                  color: titleColor,
                  fontSize: textSize,
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Text(
        buttonTitle,
        style: titleStyle ?? textTheme.button?.copyWith(
          color: titleColor,
          fontSize: textSize,
          letterSpacing: 1.1,
        ),
      );
    }
  }
}
