import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  /// Returns the width of the current screen
  double get width => MediaQuery.of(this).size.width;
}
