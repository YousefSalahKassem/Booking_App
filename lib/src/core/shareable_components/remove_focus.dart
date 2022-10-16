import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RemoveFocus extends StatelessWidget {
  const RemoveFocus({Key? key, required this.child, this.onClick}) : super(key: key);
  final Widget child;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? GestureDetector(
            onTap: onClick,
            child: child,
          )
        : InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: onClick,
            child: child,
          );
  }
}
