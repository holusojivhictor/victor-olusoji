import 'package:flutter/material.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';
import 'package:victor_olusoji/presentation/shared/custom_icons.dart';
import 'package:victor_olusoji/presentation/shared/logo_text.dart';
import 'package:victor_olusoji/presentation/shared/utils/helpers.dart';
import 'package:victor_olusoji/services/constants.dart';

import 'nav_item.dart';

class NavSectionWeb extends StatefulWidget {
  final List<NavItemData> navItems;

  const NavSectionWeb({Key? key, required this.navItems}) : super(key: key);

  @override
  State<NavSectionWeb> createState() => _NavSectionWebState();
}

class _NavSectionWebState extends State<NavSectionWeb> {
  @override
  Widget build(BuildContext context) {
    final logoSpace = responsiveSize(context, 40.0, 140.0, md: 100, sm: 70);

    return SizedBox(
      height: 100,
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(width: logoSpace),
            const LogoText(textSize: 26),
            SizedBox(width: logoSpace),
            const Spacer(),
            ..._buildNavItems(widget.navItems),
            InkWell(
              onTap: () => openUrl(Strings.github),
              child: const Icon(CustomIcons.github_alt_outlined),
            ),
            const SizedBox(width: 20),
            SizedBox(width: logoSpace),
          ],
        ),
      ),
    );
  }

  void _onTapNavItem({required GlobalKey context, required String navItemName}) {
    for (int index = 0; index < widget.navItems.length; index++) {
      if (navItemName == widget.navItems[index].name) {
        scrollToSection(context.currentContext!);
        setState(() {
          widget.navItems[index].isSelected = true;
        });
      } else {
        widget.navItems[index].isSelected = false;
      }
    }
  }

  List<Widget> _buildNavItems(List<NavItemData> navItems) {
    List<Widget> items = [];
    for (int index = 0; index < navItems.length; index++) {
      items.add(
        NavItem(
          title: navItems[index].name,
          isSelected: navItems[index].isSelected,
          width: navItems[index].width,
          onTap: () => _onTapNavItem(
            context: navItems[index].key,
            navItemName: navItems[index].name,
          ),
        ),
      );
      items.add(const SizedBox(width: 45.0));
    }

    return items;
  }
}
