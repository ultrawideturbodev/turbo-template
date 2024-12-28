import 'package:flutter/foundation.dart';
import 'form_field_config.dart';

abstract class FormConfig {
  @protected
  Map<Enum, FormFieldConfig> get formFieldConfigs;

  FormFieldConfig<T> formFieldConfig<T>(Enum id) => formFieldConfigs[id] as FormFieldConfig<T>;

  bool get isValid {
    bool formIsValid = true;
    for (final formFieldConfig in formFieldConfigs.values) {
      if (formFieldConfig.isEnabled && formFieldConfig.isVisible) {
        if (!formFieldConfig.isValid && formIsValid) formIsValid = false;
      }
    }
    return formIsValid;
  }

  void dispose() {
    for (final formFieldConfig in formFieldConfigs.values) {
      formFieldConfig.dispose();
    }
  }
}
