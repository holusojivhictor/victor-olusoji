import 'package:flutter/material.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';
import 'package:victor_olusoji/presentation/shared/buttons/default_button.dart';
import 'package:victor_olusoji/services/constants.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../shared/custom_info_section.dart';

class AltAboutMeSection extends StatefulWidget {
  final String sectionTitle;
  final String altTitle;
  final String title;
  final String body;
  final String bodyHeader;
  final String altBody;
  final TextStyle? sectionTitleStyle;
  final TextStyle? titleStyle;
  final TextStyle? bodyStyle;
  final Widget? child;

  const AltAboutMeSection({
    Key? key,
    required this.sectionTitle,
    required this.altTitle,
    required this.title,
    required this.body,
    required this.bodyHeader,
    required this.altBody,
    this.sectionTitleStyle,
    this.titleStyle,
    this.bodyStyle,
    this.child,
  }) : super(key: key);

  @override
  State<AltAboutMeSection> createState() => _AltAboutMeSectionState();
}

class _AltAboutMeSectionState extends State<AltAboutMeSection> with TickerProviderStateMixin {
  late AnimationController _indicatorController;

  @override
  void initState() {
    super.initState();
    _indicatorController = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _indicatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    TextStyle? customTitleStyle = textTheme.displayMedium?.copyWith(
      fontSize: responsiveSize(context, 30, 40, md: 36),
      color: Colors.white,
    );
    final fontSize = responsiveSize(context, 14, 16);
    final buttonWidth = responsiveSize(context, 80, 150);
    final buttonHeight = responsiveSize(context, 44, 52, md: 50);
    final buttonTextSize = responsiveSize(context, 14.0, 16.0);
    TextStyle? buttonTitleStyle = textTheme.titleMedium?.copyWith(fontSize: buttonTextSize, color: Colors.white);

    return VisibilityDetector(
      key: const Key("AltAboutMeSection"),
      onVisibilityChanged: (visibilityInfo) {
        final visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 25) {
          _indicatorController.forward();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // SectionTitle(
          //   sectionTitle: widget.sectionTitle,
          //   textTheme: textTheme,
          //   fontSize: fontSize,
          //   controller: _indicatorController,
          // ),
          const SizedBox(height: 20),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title, style: widget.titleStyle ?? customTitleStyle),
              const SizedBox(height: 20),
              Text(
                widget.bodyHeader,
                style: textTheme.bodyLarge?.copyWith(fontSize: fontSize, height: 1.8, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                widget.body,
                style: textTheme.bodyLarge?.copyWith(fontSize: fontSize, height: 1.8, color: Colors.white),
              ),
              const SizedBox(height: 20),
              // SectionTitle(
              //   sectionTitle: widget.altTitle,
              //   textTheme: textTheme,
              //   fontSize: fontSize,
              //   width: 40,
              //   controller: _indicatorController,
              // ),
              const SizedBox(height: 20),
              Text(
                widget.altBody,
                style: textTheme.bodyLarge?.copyWith(fontSize: fontSize, height: 1.8, color: Colors.white),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  DefaultButton(
                    width: buttonWidth,
                    height: buttonHeight,
                    buttonTitle: Strings.downloadCV,
                    titleStyle: buttonTitleStyle,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}