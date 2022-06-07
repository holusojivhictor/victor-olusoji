import 'package:flutter/material.dart';
import 'package:victor_olusoji/presentation/layout/adaptive.dart';
import 'package:victor_olusoji/presentation/shared/buttons/default_button.dart';
import 'package:victor_olusoji/presentation/shared/custom_form_field.dart';
import 'package:victor_olusoji/presentation/shared/utils/helpers.dart';
import 'package:victor_olusoji/services/constants.dart';

class FormSection extends StatefulWidget {
  const FormSection({Key? key}) : super(key: key);

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController subjectController = TextEditingController();
  late TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final buttonTextSize = responsiveSize(context, 14, 16);
    final buttonWidth = responsiveSize(context, 80, 150);
    final buttonHeight = responsiveSize(context, 44, 52, md: 50);
    TextStyle? buttonTitleStyle = textTheme.titleMedium?.copyWith(fontSize: buttonTextSize, color: Colors.white);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFormField(
            textEditingController: emailController,
            textInputType: TextInputType.emailAddress,
            hintText: Strings.emailHint,
          ),
          CustomFormField(
            textEditingController: subjectController,
            textInputType: TextInputType.text,
            hintText: Strings.subjectHint,
          ),
          CustomFormField(
            textEditingController: messageController,
            textInputType: TextInputType.text,
            hintText: Strings.messageHint,
            maxLines: 5,
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DefaultButton(
              width: buttonWidth,
              height: buttonHeight,
              onPressed: _openUrl,
              buttonTitle: Strings.submit,
              titleStyle: buttonTitleStyle,
            ),
          ),
        ],
      ),
    );
  }

  void _openUrl() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    final finalUrl = "mailto:<${Strings.myEmail}>?subject=${subjectController.text}&body=${messageController.text}";
    openUrl(finalUrl);
    emailController.clear();
    subjectController.clear();
    messageController.clear();
  }
}
