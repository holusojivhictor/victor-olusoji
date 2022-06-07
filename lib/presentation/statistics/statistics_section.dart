import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';
import 'package:victor_olusoji/services/constants.dart';
import 'package:visibility_detector/visibility_detector.dart';

class StatItemData {
  final int value;
  final String subtitle;

  StatItemData({
    required this.value,
    required this.subtitle,
  });
}

class StatisticsSection extends StatefulWidget {
  const StatisticsSection({Key? key}) : super(key: key);

  @override
  State<StatisticsSection> createState() => _StatisticsSectionState();
}

class _StatisticsSectionState extends State<StatisticsSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contentAreaWidth = widthOfScreen(context) - (getSidePadding(context) * 2);

    return VisibilityDetector(
      key: const Key("StatisticsSection"),
      onVisibilityChanged: (visibilityInfo) {
        final visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 30) {
          _controller.forward();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: getSidePadding(context) * 1.5),
        child: Card(
          elevation: 4,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          color: AppColors.secondaryColor,
          child: ResponsiveBuilder(
            refinedBreakpoints: const RefinedBreakpoints(),
            builder: (context, size) {
              final screenWidth = size.screenSize.width;
              if (screenWidth < const RefinedBreakpoints().tabletLarge) {
                return Container(
                  width: contentAreaWidth,
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(height: 30),
                      ..._buildItems(Data.statItemsData),
                      const SizedBox(height: 30),
                    ],
                  ),
                );
              } else {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -75,
                        left: -50,
                        child: Image.asset(Assets.blobOrange, height: 200),
                      ),
                      Positioned(
                        right: -75,
                        bottom: -65,
                        child: Image.asset(Assets.blobPurple, height: 200),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Spacer(),
                            ..._buildItems(Data.statItemsData, isHorizontal: true),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildItems(List<StatItemData> data, {bool isHorizontal = false}) {
    List<Widget> items = [];
    for (int index = 0; index < data.length; index++) {
      items.add(
        StatItem(
          title: data[index].value,
          subtitle: data[index].subtitle,
          controller: _controller,
        ),
      );

      if (index < data.length - 1) {
        if (isHorizontal) {
          items.add(const Spacer(flex: 2));
        } else {
          items.add(const SizedBox(height: 40));
        }
      }
    }

    return items;
  }
}

// ignore: must_be_immutable
class StatItem extends StatelessWidget {
  final int title;
  final String subtitle;
  final Color titleColor;
  final Color subtitleColor;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final AnimationController controller;
  final Curve curve;

  StatItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.controller,
    this.titleColor = Colors.black,
    this.subtitleColor = Colors.grey,
    this.titleStyle,
    this.subtitleStyle,
    this.curve = Curves.easeIn,
  }) : super(key: key);

  late Animation<int> animation = IntTween(begin: 0, end: title).animate(
    CurvedAnimation(parent: controller, curve: curve),
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return _buildChild(context: context, value: animation.value);
      },
    );
  }

  Widget _buildChild({required BuildContext context, required int value}) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          "$value",
          style: titleStyle ?? textTheme.displayMedium?.copyWith(color: titleColor, fontSize: 36),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          style: subtitleStyle ?? textTheme.bodyLarge?.copyWith(color: subtitleColor, fontSize: 16),
        ),
      ],
    );
  }
}

