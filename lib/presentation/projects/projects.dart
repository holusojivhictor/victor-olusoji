import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:victor_olusoji/presentation/shared/custom_info_section.dart';
import 'package:victor_olusoji/presentation/header/widgets/header_image.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';
import 'package:victor_olusoji/presentation/shared/content_area.dart';
import 'package:victor_olusoji/services/constants.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Projects extends StatefulWidget {
  final String pageKey;
  final String sectionKey;
  final String projectName;
  final String projectAltTitle;
  final String projectBody;
  final String projectPreview;
  final bool isPortfolio;

  const Projects({
    Key? key,
    required this.pageKey,
    required this.sectionKey,
    required this.projectName,
    required this.projectAltTitle,
    required this.projectBody,
    required this.projectPreview,
    this.isPortfolio = false,
  }) : super(key: key);

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late AnimationController _slideDownController;
  late Animation<Offset> _slideDownAnimation;

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
    _slideDownController = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    )..repeat(reverse: true);
    _slideDownAnimation = Tween<Offset>(begin: const Offset(0.0, 0.01), end: const Offset(0.0, -0.01)).animate(
      CurvedAnimation(parent: _slideDownController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _slideDownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = widthOfScreen(context) - getSidePadding(context);
    final screenHeight = heightOfScreen(context);
    final contentAreaHeight = screenHeight * 0.75;
    final contentAreaWidth = responsiveSize(
      context,
      screenWidth,
      screenWidth * 0.4,
      md: screenWidth * 0.4,
    );

    return VisibilityDetector(
      key: Key(widget.pageKey),
      onVisibilityChanged: (visibilityInfo) {
        final visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 40) {
          _scaleController.forward();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: getSidePadding(context) * 1.7),
        child: ResponsiveBuilder(
          refinedBreakpoints: const RefinedBreakpoints(),
          builder: (context, size) {
            final screenWidth = size.screenSize.width;
            if (screenWidth <= 1024) {
              return Column(
                children: [
                  ResponsiveBuilder(
                    builder: (context, size) {
                      final screenWidth = size.screenSize.width;
                      if (screenWidth < const RefinedBreakpoints().tabletSmall) {
                        return _buildProjectsSection();
                      } else {
                        return _buildProjectsSection();
                      }
                    },
                  ),
                  const SizedBox(height: 120),
                  ResponsiveBuilder(
                    builder: (context, size) {
                      final screenWidth = size.screenSize.width;
                      if (screenWidth < const RefinedBreakpoints().tabletSmall) {
                        return _buildImage(height: screenHeight * 0.75, width: screenWidth);
                      } else {
                        return Center(child: _buildImage(height: screenHeight * 0.75, width: screenWidth * 0.75));
                      }
                    },
                  ),
                ],
              );
            } else {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContentArea(
                    height: contentAreaHeight,
                    width: contentAreaWidth,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const SizedBox(height: 80),
                              _buildProjectsSection(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ContentArea(
                    width: screenWidth * 0.4,
                    child: _buildImage(height: contentAreaHeight, width: contentAreaWidth),
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
        Positioned(
          top: width * 0.2,
          left: width * 0.15,
          child: SvgImage(
            image: Assets.moon,
            label: "Moon Blob Svg",
            height: height * 0.6,
            width: width * 0.6,
          ),
        ),
        Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: SlideTransition(
              position: _slideDownAnimation,
              child: Image.asset(
                widget.projectPreview,
                height: widget.isPortfolio ? height * 0.6 : null,
                width: widget.isPortfolio ? width * 0.6 : null,
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsSection() {
    return CustomInfoSection(
      visibilityKey: widget.sectionKey,
      isProjects: true,
      sectionTitle: Strings.projectSectionTitle,
      altTitle: widget.projectAltTitle,
      title: Strings.projectTitle,
      body: widget.projectBody,
      projectName: widget.projectName,
      buttonTitle: Strings.checkOut,
    );
  }
}
