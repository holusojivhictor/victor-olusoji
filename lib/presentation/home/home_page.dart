import 'package:flutter/material.dart';
import 'package:victor_olusoji/presentation/about_me/about_me.dart';
import 'package:victor_olusoji/presentation/contact/contact.dart';
import 'package:victor_olusoji/presentation/header/header.dart';
import 'package:victor_olusoji/presentation/header/widgets/header_mobile.dart';
import 'package:victor_olusoji/presentation/home/widgets/nav_arguments.dart';
import 'package:victor_olusoji/presentation/loading/loading_page.dart';
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

import 'widgets/page_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  late NavigationArguments _arguments;

  int _currentProjectPage = 0;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );


  final List<NavItemData> navItems = [
    NavItemData(name: Strings.home, key: GlobalKey(), isSelected: true),
    NavItemData(name: Strings.about, key: GlobalKey()),
    NavItemData(name: Strings.work, key: GlobalKey()),
    NavItemData(name: Strings.connect, key: GlobalKey(), width: 75),
  ];

  final List<Widget> projectList = [
    const Projects(
      pageKey: "FirstProjectPage",
      sectionKey: "FirstProjectInfoSection",
      projectName: Strings.morningstarName,
      projectAltTitle: Strings.morningstarAltTitle,
      projectBody: Strings.morningstarBody,
      projectPreview: Assets.morningstarPreview,
    ),
    const Projects(
      pageKey: "SecondProjectPage",
      sectionKey: "SecondProjectInfoSection",
      projectName: Strings.chainWalletName,
      projectAltTitle: Strings.chainWalletTitle,
      projectBody: Strings.chainWalletBody,
      projectPreview: Assets.chainWalletPreview,
    ),
    const Projects(
      pageKey: "ThirdProjectPage",
      sectionKey: "ThirdProjectInfoSection",
      projectName: Strings.portfolioAppName,
      projectAltTitle: Strings.portfolioAppAltTitle,
      projectBody: Strings.portfolioAppBody,
      projectPreview: Assets.portfolioPreview,
      isPortfolio: true,
    ),
    const Projects(
      pageKey: "FourthProjectPage",
      sectionKey: "FourthProjectInfoSection",
      projectName: Strings.cseanName,
      projectAltTitle: Strings.cseanAltTitle,
      projectBody: Strings.cseanBody,
      projectPreview: Assets.cseanPreview,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _arguments = NavigationArguments();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels < 100) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void getArguments() {
    final Object? args = ModalRoute.of(context)!.settings.arguments;

    if (args == null) {
      _arguments.showUnVeilAnimation = false;
    } else {
      _arguments = args as NavigationArguments;
    }
  }

  @override
  Widget build(BuildContext context) {
    getArguments();
    final theme = Theme.of(context);
    double screenHeight = heightOfScreen(context);
    double spacerHeight = screenHeight * 0.10;
    final buttonHeight = responsiveSize(context, screenHeight * 0.65, screenHeight * 0.7, md: screenHeight * 0.8);
    final leftPadding = responsiveSize(
      context,
      sidePadding * 1.5,
      getSidePadding(context) * 1.7,
      md: getSidePadding(context) * 1.7,
    );
    final projectHeight = responsiveSize(
      context,
      screenHeight * 1.3,
      screenHeight * 0.8,
      md: screenHeight * 1.3,
    );

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
      body: Stack(
        children: [
          Column(
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
                              VisibilityDetector(
                                key: const Key("Header"),
                                onVisibilityChanged: (visibilityInfo) {
                                  final visiblePercentage = visibilityInfo.visibleFraction * 100;
                                  if (visiblePercentage > 50) {
                                    setState(() {
                                      navItems[0].isSelected = true;
                                    });
                                    clearSelections(0);
                                  }
                                },
                                child: Header(key: navItems[0].key),
                              ),
                              SizedBox(height: spacerHeight),
                              VisibilityDetector(
                                key: const Key("AboutMe"),
                                onVisibilityChanged: (visibilityInfo) {
                                  final visiblePercentage = visibilityInfo.visibleFraction * 100;
                                  if (visiblePercentage > 10) {
                                    _controller.forward();
                                  }
                                  if (visiblePercentage > 50) {
                                    setState(() {
                                      navItems[1].isSelected = true;
                                    });
                                    clearSelections(1);
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
                              Stack(
                                children: [
                                  VisibilityDetector(
                                    key: const Key("Projects"),
                                    onVisibilityChanged: (visibilityInfo) {
                                      final visiblePercentage = visibilityInfo.visibleFraction * 100;
                                      if (visiblePercentage > 50) {
                                        setState(() {
                                          navItems[2].isSelected = true;
                                        });
                                        clearSelections(2);
                                      }
                                    },
                                    child: Container(
                                      key: navItems[2].key,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: projectHeight,
                                            child: PageView(
                                              controller: _pageController,
                                              physics: const NeverScrollableScrollPhysics(),
                                              children: projectList,
                                              onPageChanged: (pageNum) {
                                                setState(() {
                                                  _currentProjectPage = pageNum;
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          ResponsiveBuilder(
                                            builder: (context, size) {
                                              final screenWidth = size.screenSize.width;
                                              if (screenWidth < const RefinedBreakpoints().tabletSmall) {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: leftPadding),
                                                  child: buildButtonRow(),
                                                );
                                              } else {
                                                return const SizedBox.shrink();
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ResponsiveBuilder(
                                    builder: (context, size) {
                                      final screenWidth = size.screenSize.width;
                                      if (screenWidth < const RefinedBreakpoints().tabletSmall) {
                                        return const SizedBox.shrink();
                                      } else {
                                        return Container(
                                          padding: EdgeInsets.symmetric(horizontal: leftPadding),
                                          height: buttonHeight,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              buildButtonRow(),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: spacerHeight),
                              VisibilityDetector(
                                key: const Key("Contact"),
                                onVisibilityChanged: (visibilityInfo) {
                                  final visiblePercentage = visibilityInfo.visibleFraction * 100;
                                  if (visiblePercentage > 50) {
                                    setState(() {
                                      navItems[3].isSelected = true;
                                    });
                                    clearSelections(3);
                                  }
                                },
                                child: Container(
                                  key: navItems[3].key,
                                  child: const Contact(),
                                ),
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
          if (!_arguments.showUnVeilAnimation)
            LoadingPage(
              text: Strings.appName,
              style: theme.textTheme.headlineMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              onLoadingDone: () {},
            ),
        ],
      ),
    );
  }

  void clearSelections(int exclude) {
    List<int> indexList = <int>[];
    for (var element in navItems) {
      final index = navItems.indexOf(element);
      indexList.add(index);
    }
    indexList.remove(exclude);
    for (var index in indexList) {
      setState(() {
        navItems[index].isSelected = false;
      });
    }
  }

  Widget buildButtonRow() {
    return Row(
      children: [
        if (_currentProjectPage != 0)
          PageButton(
            onPressed: () {
              _pageController.jumpToPage(_currentProjectPage - 1);
            },
            isLeft: true,
            buttonTitle: 'Previous',
            iconData: Icons.arrow_right_alt_sharp,
          ),
        if (_currentProjectPage != 0)
          const SizedBox(width: 40),
        if (_currentProjectPage != (projectList.length - 1))
          PageButton(
            onPressed: () {
              _pageController.jumpToPage(_currentProjectPage + 1);
            },
            buttonTitle: 'Next',
            iconData: Icons.arrow_right_alt_sharp,
          ),
      ],
    );
  }
}