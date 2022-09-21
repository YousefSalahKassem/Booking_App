import 'package:bookingapp/src/config/themes/app_styles.dart';
import 'package:flutter/material.dart';

class HintText extends StatelessWidget {
  const HintText({
    Key? key,
    required this.text,
    this.alignment = Alignment.center,
    this.onTap,
  }) : super(key: key);

  final Alignment? alignment;
  final String text;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment!,
      child: InkWell(
        onTap: () => onTap,
        child: Text(
          text,
          style: AppStyles.hintTextStyle(),
        ),
      ),
    );
  }
}
