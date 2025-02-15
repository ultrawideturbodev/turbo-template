import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/enums/t_field_type.dart';
import 'package:turbo_template/forms/typedefs/values_validator_def.dart';

/// Creates a text area field configuration for multi-line text input.
TFieldConfig<String> tTextArea({
  required Object id,
  FormFieldValidator<String>? valueValidator,
  List<TextInputFormatter>? inputFormatters,
  String? initialValue,
  bool isEnabled = true,
  bool isReadOnly = false,
  bool isVisible = true,
}) {
  return TFieldConfig<String>(
    id: id,
    fieldType: TFieldType.textArea,
    initialValue: initialValue,
    valueValidator: valueValidator,
    inputFormatters: inputFormatters,
    isEnabled: isEnabled,
    isReadOnly: isReadOnly,
    isVisible: isVisible,
  );
}
