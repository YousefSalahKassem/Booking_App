import 'package:flutter/material.dart';

class AuthTitleWidget extends StatelessWidget {
  const AuthTitleWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold));
  }
}
