import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  final double textSize;

  const LogoText({Key? key, this.textSize = 24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
      text: TextSpan(
        text: 'Victor ',
        style: theme.textTheme.headlineSmall!.copyWith(fontSize: textSize, fontWeight: FontWeight.bold, color: Colors.white),
        children: <TextSpan>[
          TextSpan(
            text: 'Olusoji',
            style: theme.textTheme.headlineSmall!.copyWith(fontSize: textSize, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
