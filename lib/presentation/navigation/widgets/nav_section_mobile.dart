import 'package:flutter/material.dart';
import 'package:victor_olusoji/presentation/shared/logo_text.dart';

class NavSectionMobile extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const NavSectionMobile({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          const SizedBox(width: 30),
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 26,
            ),
            onPressed: () {
              if (scaffoldKey.currentState!.isEndDrawerOpen) {
                scaffoldKey.currentState?.openEndDrawer();
              } else {
                scaffoldKey.currentState?.openDrawer();
              }
            },
          ),
          const Spacer(),
          const LogoText(),
          const Spacer(),
        ],
      ),
    );
  }
}
