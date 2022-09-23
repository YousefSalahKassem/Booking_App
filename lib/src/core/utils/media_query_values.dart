import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get paddingTop => MediaQuery.of(this).padding.top;
  double get paddingBottom => MediaQuery.of(this).padding.bottom;
  Brightness get brightness => MediaQuery.of(this).platformBrightness;
}
