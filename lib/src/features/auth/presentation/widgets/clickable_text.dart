import 'package:bookingapp/src/config/themes/app_styles.dart';
import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  const ClickableText({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: AppStyles.clickableTextStyle(),
      ),
    );
  }
}
