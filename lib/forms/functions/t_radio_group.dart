import 'package:flutter/widgets.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/enums/t_field_type.dart';
import 'package:turbo_template/forms/typedefs/values_validator_def.dart';

/// Creates a radio group field configuration for selecting one option from a list.
TFieldConfig<T> tRadioGroup<T>({
  required Object id,
  FormFieldValidator<T>? valueValidator,
  T? initialValue,
  bool isEnabled = true,
  bool isReadOnly = false,
  bool isVisible = true,
}) {
  return TFieldConfig<T>(
    id: id,
    fieldType: TFieldType.radioGroup,
    initialValue: initialValue,
    valueValidator: valueValidator,
    isEnabled: isEnabled,
    isReadOnly: isReadOnly,
    isVisible: isVisible,
  );
}
