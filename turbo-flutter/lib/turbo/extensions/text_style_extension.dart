import 'package:shadcn_flutter/shadcn_flutter.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
}
