import 'package:bookingapp/src/features/auth/presentation/widgets/hint_text.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    required this.inputAction,
    required this.inputType,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputAction inputAction;
  final TextInputType inputType;
  bool obscureText;

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
          controller: controller,
          textInputAction: inputAction,
          keyboardType: inputType,
          obscureText: obscureText,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
