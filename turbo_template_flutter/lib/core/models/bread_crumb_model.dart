import 'dart:ui';

class BreadCrumbModel {
  const BreadCrumbModel({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;
}
