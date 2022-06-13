import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:victor_olusoji/presentation/contact/widgets/contact_info_section.dart';
import 'package:victor_olusoji/presentation/contact/widgets/form_section.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';
import 'package:victor_olusoji/presentation/shared/content_area.dart';
import 'package:victor_olusoji/services/constants.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final fontSize = responsiveSize(context, 12, 14);
    final screenWidth = widthOfScreen(context) - getSidePadding(context);
    final screenHeight = heightOfScreen(context);
    final contentAreaHeight = screenHeight * 0.6;
    final contentAreaWidth = responsiveSize(
      context,
      screenWidth,
      screenWidth * 0.4,
      md: screenWidth * 0.4,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: getSidePadding(context) * 1.7),
      child: ResponsiveBuilder(
        refinedBreakpoints: const RefinedBreakpoints(),
        builder: (context, size) {
          final screenWidth = size.screenSize.width;
          if (screenWidth <= 1024) {
            return Column(
              children: [
                ResponsiveBuilder(
                  builder: (context, size) {
                    final screenWidth = size.screenSize.width;
                    if (screenWidth < const RefinedBreakpoints().tabletSmall) {
                      return _buildContactSection();
                    } else {
                      return _buildContactSection();
                    }
                  },
                ),
                const SizedBox(height: 50),
                ResponsiveBuilder(
                  builder: (context, size) {
                    final screenWidth = size.screenSize.width;
                    if (screenWidth < const RefinedBreakpoints().tabletSmall) {
                      return _buildFormField();
                    } else {
                      return Center(child: _buildFormField());
                    }
                  },
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: "© Victor Olusoji | Developed with Flutter",
                    style: textTheme.bodyMedium!.copyWith(
                      color: Colors.white.withOpacity(0.3),
                      fontSize: fontSize,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ContentArea(
                      height: contentAreaHeight,
                      width: contentAreaWidth,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const SizedBox(height: 80),
                                _buildContactSection(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: ContentArea(
                        height: contentAreaHeight,
                        width: screenWidth * 0.3,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const SizedBox(height: 100),
                                  _buildFormField(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: "© Victor Olusoji | Developed with Flutter",
                    style: textTheme.bodyMedium!.copyWith(
                      color: Colors.white.withOpacity(0.3),
                      fontSize: fontSize,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildFormField() {
    return const FormSection();
  }

  Widget _buildContactSection() {
    return const ContactInfoSection(
      sectionTitle: Strings.contactSectionTitle,
      title: Strings.contactTitle,
      altTitle: Strings.contactAltTitle,
      body: Strings.contactBody,
    );
  }
}
