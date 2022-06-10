import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:victor_olusoji/presentation/header/widgets/build_card.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';
import 'package:victor_olusoji/presentation/shared/buttons/default_button.dart';
import 'package:victor_olusoji/presentation/shared/content_area.dart';
import 'package:victor_olusoji/presentation/shared/utils/helpers.dart';
import 'package:victor_olusoji/services/constants.dart';

const double bodyTextSizeLg = 16.0;
const double bodyTextSizeSm = 14.0;
const double buttonTextSizeLg = 18.0;
const double buttonTextSizeSm = 14.0;
const double sidePadding = 16.0;

class HeaderMobile extends StatefulWidget {
  const HeaderMobile({Key? key}) : super(key: key);

  @override
  State<HeaderMobile> createState() => _HeaderMobileState();
}

class _HeaderMobileState extends State<HeaderMobile> with SingleTickerProviderStateMixin {
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
    const headerIntroTextSize = 24.0;
    final screenWidth = widthOfScreen(context) - (sidePadding * 2);
    final contentAreaWidth = screenWidth;
    TextStyle? bodyTextStyle = textTheme.bodyLarge?.copyWith(fontSize: bodyTextSizeSm, color: Colors.white.withOpacity(0.64));
    TextStyle? buttonTitleStyle = textTheme.titleMedium?.copyWith(fontSize: buttonTextSizeSm, color: Colors.white);
    const buttonWidth = 80.0;
    const buttonHeight = 44.0;

    final sizeOfSvgSm = screenWidth * 0.4;
    final heightOfStack = sizeOfSvgSm * 1.5;

    return ContentArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: heightOfStack * 0.15, left: sidePadding * 1.5),
                    child: SelectableText(
                      Strings.hiThere,
                      style: textTheme.bodyLarge?.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: sidePadding * 1.5),
                    margin: EdgeInsets.only(top: heightOfStack * 0.3),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: screenWidth * 0.7),
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
                            const SizedBox(height: 25),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: screenWidth * 0.8),
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
                            const SizedBox(height: 30),
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
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: sidePadding),
                child: Column(
                  children: buildCardRow(
                    context: context,
                    data: Data.rowCardData,
                    width: contentAreaWidth,
                    isHorizontal: false,
                    hasAnimation: false,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
