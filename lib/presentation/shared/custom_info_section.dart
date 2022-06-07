import 'dart:async';

import 'package:flutter/material.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';
import 'package:victor_olusoji/presentation/shared/buttons/default_button.dart';
import 'package:victor_olusoji/presentation/shared/section_title.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CustomInfoSection extends StatefulWidget {
  final String visibilityKey;
  final String sectionTitle;
  final String altTitle;
  final String title;
  final String projectName;
  final String body;
  final String altBody;
  final TextStyle? sectionTitleStyle;
  final TextStyle? titleStyle;
  final TextStyle? projectStyle;
  final TextStyle? bodyStyle;
  final Widget? child;
  final bool isProjects;
  final String buttonTitle;

  const CustomInfoSection({
    Key? key,
    required this.visibilityKey,
    required this.sectionTitle,
    required this.altTitle,
    required this.title,
    required this.body,
    this.altBody = "",
    required this.buttonTitle,
    this.isProjects = false,
    this.projectName = "",
    this.sectionTitleStyle,
    this.titleStyle,
    this.projectStyle,
    this.bodyStyle,
    this.child,
  }) : super(key: key);

  @override
  State<CustomInfoSection> createState() => _CustomInfoSectionState();
}

class _CustomInfoSectionState extends State<CustomInfoSection> with TickerProviderStateMixin {
  late AnimationController _indicatorController;
  late AnimationController _slideInController;
  late Animation<Offset> _slideInAnimation;
  late AnimationController _slideDownController;
  late Animation<Offset> _slideDownAnimation;
  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;
  late AnimationController _altFadeInController;
  late Animation<double> _altFadeInAnimation;

  @override
  void initState() {
    super.initState();
    _indicatorController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _slideInController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _slideInAnimation = Tween<Offset>(begin: const Offset(-0.1, 0.0), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideInController, curve: Curves.fastOutSlowIn),
    );
    _slideDownController = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    _slideDownAnimation = Tween<Offset>(begin: const Offset(0.0, -0.25), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideDownController, curve: Curves.fastOutSlowIn),
    );
    _fadeInController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeInAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeInController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _altFadeInController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _altFadeInAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _altFadeInController,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  @override
  void dispose() {
    _indicatorController.dispose();
    _slideInController.dispose();
    _slideDownController.dispose();
    _fadeInController.dispose();
    _altFadeInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    TextStyle? customTitleStyle = textTheme.displayMedium?.copyWith(
      fontSize: responsiveSize(context, 30, 40, md: 36),
      color: Colors.white,
    );
    TextStyle? customProjectStyle = textTheme.displayMedium?.copyWith(
      fontSize: responsiveSize(context, 24, 32, md: 26),
      color: Colors.white,
    );
    final fontSize = responsiveSize(context, 14, 16);
    final buttonWidth = responsiveSize(context, 80, 150);
    final buttonHeight = responsiveSize(context, 44, 52, md: 50);
    final buttonTextSize = responsiveSize(context, 14.0, 16.0);
    TextStyle? buttonTitleStyle = textTheme.titleMedium?.copyWith(fontSize: buttonTextSize, color: Colors.white);

    return VisibilityDetector(
      key: Key(widget.visibilityKey),
      onVisibilityChanged: (visibilityInfo) {
        final visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 25) {
          _indicatorController.forward();
          _slideInController.forward();
          _fadeInController.forward();
          Timer(const Duration(milliseconds: 500), () {
            _slideDownController.forward();
            _altFadeInController.forward();
          });
        }
      },
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(
                    sectionTitle: widget.sectionTitle,
                    textTheme: textTheme,
                    fontSize: fontSize,
                    controller: _indicatorController,
                    slideAnimation: _slideInAnimation,
                    fadeAnimation: _fadeInAnimation,
                  ),
                  const SizedBox(height: 40),
                  SlideTransition(
                    position: _slideInAnimation,
                    child: FadeTransition(
                      opacity: _fadeInAnimation,
                      child: Text(
                        widget.title,
                        style: widget.titleStyle ?? customTitleStyle,
                      ),
                    ),
                  ),
                  if (widget.isProjects)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80),
                        SlideTransition(
                          position: _slideInAnimation,
                          child: FadeTransition(
                            opacity: _fadeInAnimation,
                            child: Text(
                              widget.projectName,
                              style: widget.projectStyle ?? customProjectStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (widget.isProjects)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        SectionTitle(
                          sectionTitle: widget.altTitle,
                          textTheme: textTheme,
                          fontSize: fontSize,
                          width: 40,
                          controller: _indicatorController,
                          slideAnimation: _slideInAnimation,
                          fadeAnimation: _fadeInAnimation,
                        ),
                      ],
                    ),
                  const SizedBox(height: 30),
                  SlideTransition(
                    position: _slideDownAnimation,
                    child: FadeTransition(
                      opacity: _altFadeInAnimation,
                      child: Text(
                        widget.body,
                        style: textTheme.bodyLarge?.copyWith(fontSize: fontSize, height: 1.8, color: Colors.white),
                      ),
                    ),
                  ),
                  if (!widget.isProjects)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        SectionTitle(
                          sectionTitle: widget.altTitle,
                          textTheme: textTheme,
                          fontSize: fontSize,
                          width: 40,
                          controller: _indicatorController,
                          slideAnimation: _slideInAnimation,
                          fadeAnimation: _fadeInAnimation,
                        ),
                        const SizedBox(height: 30),
                        SlideTransition(
                          position: _slideDownAnimation,
                          child: FadeTransition(
                            opacity: _altFadeInAnimation,
                            child: Text(
                              widget.altBody,
                              style: textTheme.bodyLarge?.copyWith(fontSize: fontSize, height: 1.8, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: widget.isProjects ? 40 : 30),
                  SlideTransition(
                    position: _slideDownAnimation,
                    child: FadeTransition(
                      opacity: _altFadeInAnimation,
                      child: Row(
                        children: [
                          DefaultButton(
                            width: buttonWidth,
                            height: buttonHeight,
                            buttonTitle: widget.buttonTitle,
                            titleStyle: buttonTitleStyle,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
