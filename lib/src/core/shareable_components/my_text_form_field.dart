import 'package:bookingapp/src/core/services/form_validation/validation_helper.dart';
import 'package:bookingapp/src/core/utils/app_strings.dart';
import 'package:bookingapp/src/features/auth/presentation/widgets/hint_text.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    required this.focusNode,
    required this.controller,
    required this.inputAction,
    required this.inputType,
    this.validationItem,
    this.validateForm,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  bool obscureText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final ValidationItem? validationItem;
  void Function(String? value)? validateForm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 10),
          child: HintText(alignment: Alignment.centerLeft, text: labelText),
        ),
        const SizedBox(height: 5),
        TextFormField(
          style: const TextStyle(fontFamily: AppStrings.fontFamily, fontWeight: FontWeight.normal),
          focusNode: focusNode,
          controller: controller,
          textInputAction: inputAction,
          keyboardType: inputType,
          obscureText: obscureText,
          decoration: InputDecoration(hintText: hintText, errorText: validationItem?.error),
          onChanged: (String? value) => validateForm!(value),
        ),
      ],
    );
  }
}
