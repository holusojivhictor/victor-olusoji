import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:victor_olusoji/presentation/header/widgets/header_mobile.dart';
import 'package:victor_olusoji/presentation/header/widgets/header_web.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      refinedBreakpoints: const RefinedBreakpoints(),
      builder: (context, size) {
        final screenWidth = size.screenSize.width;
        if (screenWidth <= const RefinedBreakpoints().tabletLarge) {
          return const HeaderMobile();
        } else {
          return const HeaderWeb();
        }
      },
    );
  }
}
