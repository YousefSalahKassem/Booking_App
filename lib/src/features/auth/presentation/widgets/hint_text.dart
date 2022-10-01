import 'package:bookingapp/src/config/themes/app_styles.dart';
import 'package:flutter/material.dart';

class HintText extends StatelessWidget {
  const HintText({
    Key? key,
    required this.text,
    this.alignment = Alignment.center,
    this.onTap,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  final Alignment? alignment;
  final TextAlign? textAlign;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment!,
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          textAlign: textAlign,
          style: AppStyles.hintTextStyle(),
        ),
      ),
    );
  }
}
