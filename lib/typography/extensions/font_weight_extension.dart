import 'dart:ui';

import 'package:turbo_template/data/extensions/list_extension.dart';

extension FontWeightExtensionExtension on FontWeight {
  List<FontWeight> get _values => FontWeight.values;

  FontWeight get next => _values.indexOrElse(index + 1, orElse: _values.last)!;
  FontWeight get nextX2 => _values.indexOrElse(index + 2, orElse: _values.last)!;
  FontWeight get nextX3 => _values.indexOrElse(index + 3, orElse: _values.last)!;
  FontWeight get nextX4 => _values.indexOrElse(index + 4, orElse: _values.last)!;
  FontWeight get nextX5 => _values.indexOrElse(index + 5, orElse: _values.last)!;
  FontWeight get nextX6 => _values.indexOrElse(index + 6, orElse: _values.last)!;
  FontWeight get nextX7 => _values.indexOrElse(index + 7, orElse: _values.last)!;
  FontWeight get nextX8 => _values.indexOrElse(index + 8, orElse: _values.last)!;

  FontWeight get previous => _values.indexOrElse(index - 1, orElse: _values.first)!;
  FontWeight get previousX2 => _values.indexOrElse(index - 2, orElse: _values.first)!;
  FontWeight get previousX3 => _values.indexOrElse(index - 3, orElse: _values.first)!;
  FontWeight get previousX4 => _values.indexOrElse(index - 4, orElse: _values.first)!;
  FontWeight get previousX5 => _values.indexOrElse(index - 5, orElse: _values.first)!;
  FontWeight get previousX6 => _values.indexOrElse(index - 6, orElse: _values.first)!;
  FontWeight get previousX7 => _values.indexOrElse(index - 7, orElse: _values.first)!;
  FontWeight get previousX8 => _values.indexOrElse(index - 8, orElse: _values.first)!;
}
