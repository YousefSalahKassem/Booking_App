import 'package:bookingapp/src/config/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AccountCheckTextWidget extends StatelessWidget {
  const AccountCheckTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        const TextSpan(text: 'Already have an account? '),
        TextSpan(
            text: 'Log in',
            recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.pushNamed(context, Routes.loginRoute)),
      ]),
    );
  }
}
