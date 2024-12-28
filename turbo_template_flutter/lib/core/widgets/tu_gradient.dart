import 'package:flutter/material.dart';

class TuGradient extends LinearGradient {
  const TuGradient.topBottom({
    required super.colors,
  }) : super(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
  const TuGradient.topLeft({
    required super.colors,
  }) : super(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        );
}
