import 'package:flutter/widgets.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/enums/t_field_type.dart';
import 'package:turbo_template/forms/typedefs/values_validator_def.dart';

/// Creates a switch field configuration for boolean toggle input.
TFieldConfig<bool> tSwitch({
  required Object id,
  FormFieldValidator<bool>? valueValidator,
  bool? initialValue,
  bool isEnabled = true,
  bool isReadOnly = false,
  bool isVisible = true,
}) {
  return TFieldConfig<bool>(
    id: id,
    fieldType: TFieldType.toggleSwitch,
    initialValue: initialValue,
    valueValidator: valueValidator,
    isEnabled: isEnabled,
    isReadOnly: isReadOnly,
    isVisible: isVisible,
  );
}
