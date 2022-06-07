import 'package:flutter/material.dart';
import 'package:victor_olusoji/presentation/about_me/about_me.dart';
import 'package:victor_olusoji/presentation/contact/contact.dart';
import 'package:victor_olusoji/presentation/header/header.dart';
import 'package:victor_olusoji/presentation/navigation/widgets/app_drawer.dart';
import 'package:victor_olusoji/presentation/navigation/widgets/nav_item.dart';
import 'package:victor_olusoji/presentation/navigation/widgets/nav_section_mobile.dart';
import 'package:victor_olusoji/presentation/navigation/widgets/nav_section_web.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';
import 'package:victor_olusoji/presentation/projects/projects.dart';
import 'package:victor_olusoji/presentation/shared/utils/globals.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:victor_olusoji/presentation/shared/utils/helpers.dart';
import 'package:victor_olusoji/presentation/statistics/statistics_section.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:victor_olusoji/services/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  final ScrollController _scrollController = ScrollController();

  final List<NavItemData> navItems = [
    NavItemData(name: Strings.home, key: GlobalKey(), isSelected: true),
    NavItemData(name: Strings.about, key: GlobalKey()),
    NavItemData(name: Strings.work, key: GlobalKey()),
    NavItemData(name: Strings.connect, key: GlobalKey(), width: 75),
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels < 100) {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double screenHeight = heightOfScreen(context);
    double spacerHeight = screenHeight * 0.10;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      key: Globals.scaffoldKey,
      drawer: ResponsiveBuilder(
        builder: (context, size) {
          double screenWidth = size.screenSize.width;
          if (screenWidth < const RefinedBreakpoints().desktopSmall) {
            return AppDrawer(menuList: navItems);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton(
          onPressed: () => scrollToSection(navItems[0].key.currentContext!),
          backgroundColor: AppColors.secondaryColor,
          child: const Icon(Icons.arrow_upward_rounded, size: 22, color: AppColors.primaryColor),
        ),
      ),
      body: Column(
        children: [
          ResponsiveBuilder(
            refinedBreakpoints: const RefinedBreakpoints(),
            builder: (context, size) {
              double screenWidth = size.screenSize.width;
              if (screenWidth < const RefinedBreakpoints().desktopSmall) {
                return NavSectionMobile(scaffoldKey: Globals.scaffoldKey);
              } else {
                return NavSectionWeb(navItems: navItems);
              }
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Header(key: navItems[0].key),
                          SizedBox(height: spacerHeight),
                          VisibilityDetector(
                            key: const Key("AboutMe"),
                            onVisibilityChanged: (visibilityInfo) {
                              final visiblePercentage = visibilityInfo.visibleFraction * 100;
                              if (visiblePercentage > 10) {
                                _controller.forward();
                              }
                            },
                            child: Container(
                              key: navItems[1].key,
                              child: const AboutMe(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spacerHeight),
                  Stack(
                    children: [
                      Column(
                        children: const [
                          StatisticsSection(),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spacerHeight * 2),
                  Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            key: navItems[2].key,
                            child: const Projects(),
                          ),
                          SizedBox(height: spacerHeight),
                          Container(
                            key: navItems[3].key,
                            child: const Contact(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}