import 'package:flutter/widgets.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/enums/t_field_type.dart';
import 'package:turbo_template/forms/typedefs/values_validator_def.dart';

/// Creates a select field configuration for dropdown selection input.
///
/// The select field allows users to choose one option from a list of items.
///
/// Parameters:
/// - [id]: Unique identifier for the field
/// - [valueValidator]: Optional function to validate the selected value
/// - [initialValue]: Initial selected value
/// - [items]: List of available options to select from
/// - [isEnabled]: Whether the select is interactive
/// - [isReadOnly]: Whether the select is in read-only mode
/// - [isVisible]: Whether the select is visible
TFieldConfig<T> tSelect<T>({
  required Object id,
  FormFieldValidator<T>? valueValidator,
  T? initialValue,
  List<T>? items,
  bool isEnabled = true,
  bool isReadOnly = false,
  bool isVisible = true,
}) {
  return TFieldConfig<T>(
    id: id,
    fieldType: TFieldType.select,
    initialValue: initialValue,
    items: items,
    valueValidator: valueValidator,
    isEnabled: isEnabled,
    isReadOnly: isReadOnly,
    isVisible: isVisible,
  );
}
