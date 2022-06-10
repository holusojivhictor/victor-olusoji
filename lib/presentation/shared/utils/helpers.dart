import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const kDuration = Duration(milliseconds: 600);

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw Exception('Could not launch $url');
  }
}

void scrollToSection(BuildContext context) {
  Scrollable.ensureVisible(context, duration: kDuration);
}

Size textSize({
  required String text,
  required TextStyle? style,
  int maxLines = 1,
  double maxWidth = double.infinity,
}) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: maxWidth);
  return textPainter.size;
}