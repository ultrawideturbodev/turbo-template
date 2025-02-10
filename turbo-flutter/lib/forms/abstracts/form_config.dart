import 'package:flutter/foundation.dart';
import '../config/t_field_config.dart';

abstract class FormConfig {
  @protected
  Map<Enum, TFieldConfig> get formFieldConfigs;

  TFieldConfig<T> formFieldConfig<T>(Enum id) => formFieldConfigs[id] as TFieldConfig<T>;

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
