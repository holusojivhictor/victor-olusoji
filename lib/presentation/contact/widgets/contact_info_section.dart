import 'dart:async';

import 'package:flutter/material.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';
import 'package:victor_olusoji/presentation/shared/section_title.dart';
import 'package:victor_olusoji/presentation/shared/utils/helpers.dart';
import 'package:victor_olusoji/services/constants.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'social_button.dart';

class ContactInfoSection extends StatefulWidget {
  final String sectionTitle;
  final String title;
  final String altTitle;
  final String body;
  final TextStyle? sectionTitleStyle;
  final TextStyle? titleStyle;
  final TextStyle? bodyStyle;
  final Widget? child;

  const ContactInfoSection({
    Key? key,
    required this.sectionTitle,
    required this.title,
    required this.altTitle,
    required this.body,
    this.sectionTitleStyle,
    this.titleStyle,
    this.bodyStyle,
    this.child,
  }) : super(key: key);

  @override
  State<ContactInfoSection> createState() => _ContactInfoSectionState();
}

class _ContactInfoSectionState extends State<ContactInfoSection> with TickerProviderStateMixin {
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
    final fontSize = responsiveSize(context, 14, 16);

    return VisibilityDetector(
      key: const Key("ContactInfoSection"),
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
                  Row(
                    children: [
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
                      const SizedBox(width: 15),
                      const Icon(Icons.arrow_forward_sharp, size: 40, color: AppColors.primaryColor),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SlideTransition(
                    position: _slideInAnimation,
                    child: FadeTransition(
                      opacity: _fadeInAnimation,
                      child: Text(
                        widget.altTitle,
                        style: widget.titleStyle ?? customTitleStyle,
                      ),
                    ),
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
                  const SizedBox(height: 30),
                  SlideTransition(
                    position: _slideDownAnimation,
                    child: FadeTransition(
                      opacity: _altFadeInAnimation,
                      child: Row(
                        children: _buildSocialButtons(Data.socialData),
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

  List<Widget> _buildSocialButtons(List<SocialButtonData> buttonItems) {
    List<Widget> items = [];
    for (int index = 0; index < buttonItems.length; index++) {
      items.add(
        SocialButton(
          tag: buttonItems[index].tag,
          iconData: buttonItems[index].iconData,
          onPressed: () => openUrl(buttonItems[index].url),
        ),
      );
      items.add(const SizedBox(width: 10));
    }

    return items;
  }
}
