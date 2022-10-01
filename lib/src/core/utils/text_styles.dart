import 'package:flutter/material.dart';

class TextStyles {
  final BuildContext context;

  TextStyles(this.context);

  TextStyle getTitleStyle() {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 24,
    );
  }

  TextStyle getDescriptionStyle() {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
    );
  }

  TextStyle getRegularStyle() {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
      fontSize: 16,
    );
  }

  TextStyle getBoldStyle() {
    return Theme.of(context).textTheme.subtitle1!.copyWith(
      fontSize: 14,
    );
  }
}