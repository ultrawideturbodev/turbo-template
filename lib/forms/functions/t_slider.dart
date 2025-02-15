import 'package:flutter/widgets.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/enums/t_field_type.dart';
import 'package:turbo_template/forms/typedefs/values_validator_def.dart';

/// Creates a slider field configuration for numeric range input.
///
/// The slider allows users to select a value within a specified range by dragging
/// a thumb along a track.
///
/// Parameters:
/// - [id]: Unique identifier for the field
/// - [min]: Minimum value of the slider range
/// - [max]: Maximum value of the slider range
/// - [valueValidator]: Optional function to validate the selected value
/// - [initialValue]: Initial value of the slider (defaults to min if not provided)
/// - [divisions]: Optional number of discrete divisions
/// - [isEnabled]: Whether the slider is interactive
/// - [isReadOnly]: Whether the slider is in read-only mode
/// - [isVisible]: Whether the slider is visible
TFieldConfig<double> tSlider({
  required String id,
  required double min,
  required double max,
  String? Function(double?)? valueValidator,
  double? initialValue,
  int? divisions,
  bool isEnabled = true,
  bool isReadOnly = false,
  bool isVisible = true,
}) {
  return TFieldConfig<double>(
    id: id,
    fieldType: TFieldType.slider,
    valueValidator: valueValidator,
    initialValue: initialValue ?? min,
    isEnabled: isEnabled,
    isReadOnly: isReadOnly,
    isVisible: isVisible,
  );
}
