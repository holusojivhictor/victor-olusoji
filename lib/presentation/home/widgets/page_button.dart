import 'package:flutter/material.dart';
import 'package:victor_olusoji/services/constants.dart';

typedef OnPressed = void Function()?;

class PageButton extends StatelessWidget {
  final String buttonTitle;
  final IconData iconData;
  final OnPressed onPressed;
  final bool isLeft;

  const PageButton({
    Key? key,
    required this.buttonTitle,
    required this.iconData,
    this.isLeft = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white.withOpacity(0.4)),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            if (!isLeft)
              ButtonText(buttonTitle: buttonTitle),
            isLeft
                ? RotatedBox(
                    quarterTurns: 2,
                    child: PaddedIcon(iconData: iconData),
                  )
                : PaddedIcon(iconData: iconData),
            if (isLeft)
              ButtonText(buttonTitle: buttonTitle),
          ],
        ),
      ),
    );
  }
}

class ButtonText extends StatelessWidget {
  const ButtonText({
    Key? key,
    required this.buttonTitle,
  }) : super(key: key);

  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      buttonTitle,
      style: const TextStyle(fontSize: 16, color: Colors.white),
    );
  }
}

class PaddedIcon extends StatelessWidget {
  const PaddedIcon({
    Key? key,
    required this.iconData,
  }) : super(key: key);

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Icon(iconData, color: AppColors.primaryColor, size: 30),
    );
  }
}
