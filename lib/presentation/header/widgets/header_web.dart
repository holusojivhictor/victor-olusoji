import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:victor_olusoji/presentation/header/widgets/header_image.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';
import 'package:victor_olusoji/presentation/shared/buttons/default_button.dart';
import 'package:victor_olusoji/presentation/shared/content_area.dart';
import 'package:victor_olusoji/presentation/shared/utils/helpers.dart';
import 'package:victor_olusoji/services/constants.dart';

import 'build_card.dart';

const double bodyTextSizeLg = 16.0;
const double bodyTextSizeSm = 14.0;
const double buttonTextSizeLg = 16.0;
const double buttonTextSizeSm = 14.0;

class HeaderWeb extends StatefulWidget {
  const HeaderWeb({Key? key}) : super(key: key);

  @override
  State<HeaderWeb> createState() => _HeaderWebState();
}

class _HeaderWebState extends State<HeaderWeb> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    _controller.forward();
    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final headerIntroTextSize = responsiveSize(context, 28, 64, md: 42);
    final bodyTextSize = responsiveSize(context, bodyTextSizeSm, bodyTextSizeLg);
    final buttonTextSize = responsiveSize(context, buttonTextSizeSm, buttonTextSizeLg);
    final screenWidth = widthOfScreen(context);
    final contentAreaWidth = screenWidth;
    TextStyle? bodyTextStyle = textTheme.bodyLarge?.copyWith(fontSize: bodyTextSize, color: Colors.white.withOpacity(0.64));
    TextStyle? buttonTitleStyle = textTheme.titleMedium?.copyWith(fontSize: buttonTextSize, color: Colors.white);
    final buttonWidth = responsiveSize(context, 80, 150);
    final buttonHeight = responsiveSize(context, 44, 52, md: 50);

    final sizeOfSvgSm = screenWidth * 0.3;
    final heightOfStack = sizeOfSvgSm * 1.5;

    List<Widget> cardsForTabletView = buildCardRow(
      context: context,
      data: Data.rowCardData,
      width: contentAreaWidth * 0.4,
      isWrap: true,
    );

    return ContentArea(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 30),
            height: heightOfStack,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: SvgImage(
                    image: Assets.header,
                    label: "Header Image",
                    height: heightOfStack / 1.35,
                    width: sizeOfSvgSm,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: heightOfStack * 0.15, left: sizeOfSvgSm * 0.25),
                    child: SelectableText(
                      Strings.hiThere,
                      style: textTheme.bodyLarge?.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: heightOfStack * 0.25, left: sizeOfSvgSm * 0.25),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: screenWidth * 0.2),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  TyperAnimatedText(
                                    Strings.intro,
                                    speed: const Duration(milliseconds: 60),
                                    textStyle: textTheme.displayMedium?.copyWith(
                                      color: Colors.white,
                                      fontSize: headerIntroTextSize,
                                    ),
                                  ),
                                ],
                                onTap: () {},
                                isRepeatingAnimation: false,
                              ),
                            ),
                            const SizedBox(height: 35),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: screenWidth * 0.3),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  RotateAnimatedText(
                                    Strings.aboutHeader,
                                    textStyle: bodyTextStyle?.copyWith(height: 1.5),
                                    rotateOut: false,
                                  ),
                                ],
                                onTap: () {},
                                isRepeatingAnimation: false,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Row(
                              children: [
                                DefaultButton(
                                  width: buttonWidth,
                                  height: buttonHeight,
                                  buttonTitle: Strings.contactMe,
                                  onPressed: () => openUrl(Strings.emailUrl),
                                  titleStyle: buttonTitleStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 150),
              Container(
                margin: EdgeInsets.only(left: sizeOfSvgSm * 0.25),
                child: ResponsiveBuilder(
                  refinedBreakpoints: const RefinedBreakpoints(),
                  builder: (context, size) {
                    final screenWidth = size.screenSize.width;
                    if (screenWidth < const RefinedBreakpoints().tabletNormal) {
                      return Container(
                        margin: EdgeInsets.only(right: sizeOfSvgSm * 0.25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: buildCardRow(
                            context: context,
                            data: Data.rowCardData,
                            width: contentAreaWidth,
                            isHorizontal: false,
                            hasAnimation: false,
                          ),
                        ),
                      );
                    } else if (screenWidth >= const RefinedBreakpoints().tabletNormal && screenWidth <= 1024) {
                      return Wrap(
                        runSpacing: 24,
                        children: [
                          SizedBox(width: contentAreaWidth * 0.03),
                          cardsForTabletView[0],
                          const SizedBox(width: 40),
                          cardsForTabletView[1],
                          SizedBox(width: contentAreaWidth * 0.03),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: cardsForTabletView[2],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ...buildCardRow(context: context, data: Data.rowCardData, width: contentAreaWidth / 3.8),
                              const Spacer(),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
