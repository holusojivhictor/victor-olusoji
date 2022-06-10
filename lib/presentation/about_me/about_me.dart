import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:victor_olusoji/presentation/shared/custom_info_section.dart';
import 'package:victor_olusoji/presentation/header/widgets/header_image.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';
import 'package:victor_olusoji/presentation/shared/content_area.dart';
import 'package:victor_olusoji/services/constants.dart';
import 'package:visibility_detector/visibility_detector.dart';

const double kSpacingSm = 40.0;
const double kRunSpacingSm = 24.0;
const double kSpacingLg = 24.0;
const double kRunSpacingLg = 16.0;

class AboutMe extends StatefulWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    _scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.fastOutSlowIn),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = widthOfScreen(context) - getSidePadding(context);
    final screenHeight = heightOfScreen(context);
    final contentAreaWidthSm = screenWidth * 1.0;
    final contentAreaHeightSm = screenHeight * 0.6;
    final contentAreaWidthLg = screenWidth * 0.35;
    final textContentAreaWidth = screenWidth * 0.5;

    return VisibilityDetector(
      key: const Key("AboutMePage"),
      onVisibilityChanged: (visibilityInfo) {
        final visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 25) {
          Timer(const Duration(milliseconds: 750), () {
            _scaleController.forward();
          });
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: getSidePadding(context) * 1.7),
        child: ResponsiveBuilder(
          refinedBreakpoints: const RefinedBreakpoints(),
          builder: (context, size) {
            final screenWidth = size.screenSize.width;
            if (screenWidth < const RefinedBreakpoints().tabletLarge) {
              return Column(
                children: [
                  ContentArea(
                    width: contentAreaWidthSm,
                    child: _buildImage(height: contentAreaHeightSm, width: contentAreaWidthSm),
                  ),
                  const SizedBox(height: 30),
                  ContentArea(
                    width: contentAreaWidthSm,
                    child: _buildAboutMe(height: screenHeight * 0.9, width: contentAreaWidthSm),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  ContentArea(
                    width: contentAreaWidthLg,
                    child: _buildImage(height: screenHeight * 0.9, width: contentAreaWidthLg),
                  ),
                  const SizedBox(width: 80),
                  ContentArea(
                    width: textContentAreaWidth,
                    child: _buildAboutMe(height: screenHeight * 0.9, width: textContentAreaWidth),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildImage({required double height, required double width}) {
    return Stack(
      children: [
        ScaleTransition(
          scale: _scaleAnimation,
          child: SvgImage(
            image: Assets.aboutMe,
            label: "About Me Image",
            height: height,
            width: width * 0.95,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutMe({required double height, required double width}) {
    return Stack(
      children: [
        ResponsiveBuilder(
          refinedBreakpoints: const RefinedBreakpoints(),
          builder: (context, size) {
            final screenWidth = size.screenSize.width;
            if (screenWidth < const RefinedBreakpoints().tabletNormal) {
              return aboutMeSectionSm();
            } else {
              return SizedBox(
                width: width * 0.85,
                child: aboutMeSectionLg(),
              );
            }
          },
        ),
      ],
    );
  }

  Widget aboutMeSectionLg() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CustomInfoSection(
                visibilityKey: "AboutMeSection",
                sectionTitle: Strings.aboutSectionTitle,
                altTitle: Strings.aboutAltTitle,
                title: Strings.aboutTitle,
                body: Strings.aboutBody,
                altBody: Strings.aboutAltBody,
                buttonTitle: Strings.downloadCV,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget aboutMeSectionSm() {
    return const CustomInfoSection(
      visibilityKey: "AboutMeSection",
      sectionTitle: Strings.aboutSectionTitle,
      altTitle: Strings.aboutAltTitle,
      title: Strings.aboutTitle,
      body: Strings.aboutBody,
      altBody: Strings.aboutAltBody,
      buttonTitle: Strings.downloadCV,
    );
  }
}
