import 'package:flutter/material.dart';
import 'package:victor_olusoji/presentation/header/widgets/row_card.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';
import 'package:victor_olusoji/presentation/shared/circular_container.dart';

List<Widget> buildCardRow({
  required BuildContext context,
  required List<CardData> data,
  required double width,
  bool isHorizontal = true,
  bool isWrap = false,
  bool hasAnimation = true,
}) {
  final textTheme = Theme.of(context).textTheme;
  List<Widget> items = [];

  double cardWidth = responsiveSize(context, 32, 40, md: 36);
  double iconSize = responsiveSize(context, 18, 24);
  double trailingIconSize = responsiveSize(context, 28, 30, md: 30);

  for (int index = 0; index < data.length; index++) {
    items.add(
      RowCard(
        width: width,
        height: responsiveSize(context, 125, 140),
        hasAnimation: hasAnimation,
        leading: CircularContainer(
          width: cardWidth,
          height: cardWidth,
          iconSize: iconSize,
          backgroundColor: data[index].circleBgColor,
          iconColor: data[index].leadingIconColor,
        ),
        title: Flexible(
          child: SelectableText(
            data[index].title,
            style: textTheme.titleMedium?.copyWith(
              fontSize: responsiveSize(context, 14, 16),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        subtitle: Flexible(
          child: SelectableText(
            data[index].subtitle,
            style: textTheme.bodyLarge?.copyWith(
              fontSize: responsiveSize(context, 13, 14),
            ),
          ),
        ),
        trailing: Icon(
          data[index].trailingIcon,
          size: trailingIconSize,
          color: data[index].trailingIconColor,
        ),
      ),
    );
    if (!isWrap) {
      if (isHorizontal) {
        items.add(const SizedBox(width: 36));
      } else {
        items.add(const SizedBox(width: 30));
      }
    }
  }

  return items;
}