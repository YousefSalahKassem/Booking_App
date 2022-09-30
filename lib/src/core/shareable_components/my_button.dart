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
  final void Function()? onPressed;
  final Color? backgroundColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: backgroundColor != null
          ? ButtonStyle(backgroundColor: MaterialStateProperty.all(backgroundColor))
          : onPressed != null
              ? const ButtonStyle()
              : ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey)),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null ? Icon(icon, color: Colors.white, size: 20) : const SizedBox(),
          icon != null ? const SizedBox(width: 5) : const SizedBox(),
          Text(
            text,
            style: TextStyle(
              color: backgroundColor == Colors.white ? Colors.black : Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
