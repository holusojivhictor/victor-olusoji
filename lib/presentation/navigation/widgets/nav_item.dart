import 'package:flutter/material.dart';
import 'package:victor_olusoji/presentation/navigation/widgets/animated_hover_indicator.dart';
import 'package:victor_olusoji/presentation/navigation/widgets/selected_indicator.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';
import 'package:victor_olusoji/services/constants.dart';

const double indicatorWidth = 60;

class NavItemData {
  final String name;
  final GlobalKey key;
  final double width;
  bool isSelected;

  NavItemData({
    required this.name,
    required this.key,
    this.width = indicatorWidth,
    this.isSelected = false,
  });
}

class NavItem extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;
  final Color titleColor;
  final bool isSelected;
  final bool isMobile;
  final GestureTapCallback? onTap;
  final double width;

  const NavItem({
    Key? key,
    required this.title,
    this.titleColor = Colors.white,
    this.isSelected = false,
    this.isMobile = false,
    this.titleStyle,
    required this.width,
    this.onTap,
  }) : super(key: key);

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> with SingleTickerProviderStateMixin {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double textSize = responsiveSize(context, Sizes.textSize14, Sizes.textSize16, md: Sizes.textSize15);

    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: widget.onTap,
        child: Stack(
          children: [
            if (!widget.isMobile)
              widget.isSelected
                  ? Positioned(
                      top: 20.0,
                      child: SelectedIndicator(
                        width: widget.width,
                      ),
                    )
                  : Positioned(
                      top: 20.0,
                      child: AnimatedHoverIndicator(
                        isHover: _hovering,
                        width: widget.width,
                      ),
                    ),
            Text(
              widget.title,
              style: widget.titleStyle ?? textTheme.subtitle1?.copyWith(fontSize: textSize, color: widget.titleColor),
            ),
          ],
        ),
      ),
    );
  }

  void _mouseEnter(bool hovering) {
    setState(() {
      _hovering = hovering;
    });
  }
}
