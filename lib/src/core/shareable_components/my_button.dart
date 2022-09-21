import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.icon,
  }) : super(key: key);

  final String text;
  final void Function() onPressed;
  final Color? backgroundColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: backgroundColor != null
          ? ButtonStyle(backgroundColor: MaterialStateProperty.all(backgroundColor))
          : const ButtonStyle(),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null ? Icon(icon, color: Colors.white, size: 20) : const SizedBox(),
          icon != null ? const SizedBox(width: 5) : const SizedBox(),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
