import 'package:flutter/material.dart';
import 'package:victor_olusoji/services/constants.dart';

class CardData {
  final IconData leadingIcon;
  final IconData trailingIcon;
  final Color trailingIconColor;
  final Color leadingIconColor;
  final Color circleBgColor;
  final String title;
  final String subtitle;

  CardData({
    required this.leadingIcon,
    required this.trailingIcon,
    required this.title,
    required this.subtitle,
    this.circleBgColor = Colors.black54,
    this.leadingIconColor = Colors.white,
    this.trailingIconColor = Colors.grey,
  });
}

class RowCard extends StatefulWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final double? width;
  final double? height;
  final double? elevation;
  final double offsetY;
  final MainAxisAlignment columnMainAxisAlignment;
  final CrossAxisAlignment columnCrossAxisAlignment;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final MainAxisAlignment rowMainAxisAlignment;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final bool hasAnimation;

  const RowCard({
    Key? key,
    this.columnMainAxisAlignment = MainAxisAlignment.start,
    this.columnCrossAxisAlignment = CrossAxisAlignment.start,
    this.rowMainAxisAlignment = MainAxisAlignment.start,
    this.rowCrossAxisAlignment = CrossAxisAlignment.center,
    this.offsetY = -40,
    this.elevation = 4,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = const EdgeInsets.symmetric(vertical: 12),
    this.hasAnimation = true,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<RowCard> createState() => _RowCardState();
}

class _RowCardState extends State<RowCard> with SingleTickerProviderStateMixin {
  bool _hovering = false;
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: widget.offsetY).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuart));
  }

  Future<void> _animateCard() async {
    if (_hovering) {
      try {
        await _controller.forward().orCancel;
      } on TickerCanceled {
        throw Exception("This ticker was cancelled");
      }
    } else {
      try {
        await _controller.reverse().orCancel;
      } on TickerCanceled {
        throw Exception("This ticker was cancelled");
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.hasAnimation
        ? MouseRegion(
            onEnter: (e) => _mouseEnter(true),
            onExit: (e) => _mouseEnter(false),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, animation.value),
                  child: _buildCard(),
                );
              },
            ),
          )
        : _buildCard();
  }

  Widget _buildCard() {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: Card(
          color: AppColors.secondaryColor,
          elevation: widget.elevation,
          child: Padding(
            padding: widget.padding,
            child: Row(
              mainAxisAlignment: widget.rowMainAxisAlignment,
              crossAxisAlignment: widget.rowCrossAxisAlignment,
              children: [
                widget.leading != null
                    ? const Spacer()
                    : const SizedBox.shrink(),
                widget.leading ?? const SizedBox.shrink(),
                widget.leading != null
                    ? const Spacer()
                    : const SizedBox.shrink(),
                Column(
                  mainAxisAlignment: widget.columnMainAxisAlignment,
                  crossAxisAlignment: widget.columnCrossAxisAlignment,
                  children: [
                    const Spacer(),
                    widget.title ?? const SizedBox.shrink(),
                    widget.title != null
                        ? const SizedBox(height: 8)
                        : const SizedBox.shrink(),
                    widget.subtitle ?? const SizedBox.shrink(),
                    const Spacer(),
                  ],
                ),
                widget.trailing != null
                    ? const Spacer()
                    : const SizedBox.shrink(),
                widget.trailing ?? const SizedBox.shrink(),
                widget.trailing != null
                    ? const Spacer()
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mouseEnter(bool hovering) {
    setState(() {
      _hovering = hovering;
    });
    _animateCard();
  }
}
