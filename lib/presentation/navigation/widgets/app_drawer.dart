import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';
import 'package:victor_olusoji/presentation/shared/logo_text.dart';
import 'package:victor_olusoji/presentation/shared/utils/helpers.dart';

import 'nav_item.dart';

class AppDrawer extends StatefulWidget {
  final Color color;
  final double? width;
  final List<NavItemData> menuList;
  final GestureTapCallback? onClose;

  const AppDrawer({
    Key? key,
    required this.menuList,
    this.color = Colors.black38,
    this.width,
    this.onClose,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final defaultWidthOfDrawer = responsiveSize(
      context,
      assignWidth(context, 0.85),
      assignWidth(context, 0.60),
      md: assignWidth(context, 0.60),
    );

    return SizedBox(
      width: widget.width ?? defaultWidthOfDrawer,
      child: Drawer(
        child: Container(
          color: widget.color,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const LogoText(),
                  const Spacer(),
                  InkWell(
                    onTap: widget.onClose ?? () => _closeDrawer(),
                    child: const Icon(Icons.close, size: 30, color: Colors.white),
                  ),
                ],
              ),
              const Spacer(flex: 2),
              ..._buildMenuList(context, widget.menuList),
              const Spacer(flex: 6),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMenuList(BuildContext context, List<NavItemData> menuList) {
    final textTheme = Theme.of(context).textTheme;
    List<Widget> menuItems = [];
    for (int index = 0; index < menuList.length; index++) {
      menuItems.add(
        NavItem(
          isMobile: true,
          title: menuList[index].name,
          isSelected: menuList[index].isSelected,
          width: menuList[index].width,
          onTap: () => _onTapNavItem(
            context: menuList[index].key,
            navItemName: menuList[index].name,
          ),
          titleStyle: textTheme.bodyLarge?.copyWith(
            color: menuList[index].isSelected ? Theme.of(context).primaryColor : Colors.white,
            fontWeight: menuList[index].isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
      menuItems.add(const Spacer());
    }

    return menuItems;
  }

  void _onTapNavItem({required GlobalKey context, required String navItemName}) {
    for (int index = 0; index < widget.menuList.length; index++) {
      if (navItemName == widget.menuList[index].name) {
        scrollToSection(context.currentContext!);
        setState(() {
          widget.menuList[index].isSelected = true;
        });
        _closeDrawer();
      } else {
        widget.menuList[index].isSelected = false;
      }
    }
  }

  void _closeDrawer() {
    context.router.pop();
  }
}
