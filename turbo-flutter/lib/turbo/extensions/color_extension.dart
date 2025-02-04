import 'dart:math';

import 'package:flutter/material.dart' as material;
import 'package:shadcn_flutter/shadcn_flutter.dart';

extension ColorExtension on Color {
  Color get onColor =>
      material.ThemeData.estimateBrightnessForColor(this) == material.Brightness.light
          ? Colors.black
          : Colors.white;

  /// Brightens the color with the given integer percentage amount.
  /// Defaults to 5%.
  Color brighten([final int amount = 5]) {
    if (amount <= 0) return this;
    if (amount > 100) return Colors.white;
    final Color color = Color.fromARGB(
      alpha,
      max(0, min(255, red - (255 * -(amount / 100)).round())),
      max(0, min(255, green - (255 * -(amount / 100)).round())),
      max(0, min(255, blue - (255 * -(amount / 100)).round())),
    );
    return color;
  }

  /// Lightens the color with the given integer percentage amount.
  /// Defaults to 5%.
  Color lighten([final int amount = 5]) {
    if (amount <= 0) return this;
    if (amount > 100) return Colors.white;
    // HSLColor returns saturation 1 for black, we want 0 instead to be able
    // lighten black color up along the grey scale from black.
    final HSLColor hsl = this == const Color(0xFF000000)
        ? HSLColor.fromColor(this).withSaturation(0)
        : HSLColor.fromColor(this);
    return hsl.withLightness(min(1, max(0, hsl.lightness + amount / 100))).toColor();
  }

  /// Darkens the color with the given integer percentage amount.
  /// Defaults to 5%.
  Color darken([final int amount = 5]) {
    if (amount <= 0) return this;
    if (amount > 100) return Colors.black;
    final HSLColor hsl = HSLColor.fromColor(this);
    return hsl.withLightness(min(1, max(0, hsl.lightness - amount / 100))).toColor();
  }
}
