import 'package:flutter/material.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final int? maxLines;

  const CustomFormField({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    required this.textInputType,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fontSize = responsiveSize(context, 14, 16);
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textEditingController,
        keyboardType: textInputType,
        maxLines: maxLines,
        onSaved: (value) {
          textEditingController.text = value ?? "";
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          hintText: hintText,
          hintStyle: theme.textTheme.bodyLarge!.copyWith(fontSize: fontSize, color: const Color(0xFF1F1E1D).withOpacity(0.8)),
        ),
      ),
    );
  }
}