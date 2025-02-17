import 'package:get_it/get_it.dart';
import 'package:turbo_template/forms/abstracts/form_config.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/constants/k_value_validators.dart';
import 'package:turbo_template/forms/enums/t_field_type.dart';
import 'package:turbo_template/localizations/globals/g_strings.dart';
import 'package:turbo_template/state/constants/k_limits.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

enum TMultiExample {
  one,
  two,
  three,
  ;

  String get label {
    switch (this) {
      case TMultiExample.one:
        return 'One';
      case TMultiExample.two:
        return 'Two';
      case TMultiExample.three:
        return 'Three';
    }
  }
}

class TExampleDto {
  const TExampleDto({
    required this.text,
    required this.dropDown,
    required this.checkbox,
    required this.colorPicker,
    required this.datePicker,
    required this.filePicker,
    required this.numberInput,
    required this.phoneInput,
    required this.radioCard,
    required this.radioGroup,
    required this.select,
    required this.selectMulti,
    required this.slider,
    required this.starRating,
    required this.textArea,
    required this.textInput,
    required this.timePicker,
    required this.toggleGroup,
    required this.toggleSwitch,
  });

  final String text;
  final String dropDown;
  final bool checkbox;
  final ColorDerivative colorPicker;
  final DateTime datePicker;
  final String filePicker;
  final double numberInput;
  final String phoneInput;
  final String radioCard;
  final String radioGroup;
  final String select;
  final List<TMultiExample> selectMulti;
  final double slider;
  final int starRating;
  final String textArea;
  final String textInput;
  final DateTime timePicker;
  final String toggleGroup;
  final bool toggleSwitch;
}

class TExampleForm extends FormConfig {
  TExampleForm({
    required TExampleDto? initialValue,
  }) : _initialValue = initialValue;

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static TExampleForm locate({required TExampleDto? initialValue}) =>
      GetIt.I.get(param1: initialValue);
  static void registerFactoryParam() =>
      GetIt.I.registerFactoryParam<TExampleForm, TExampleDto?, void>(
        (initialValue, _) => TExampleForm(initialValue: initialValue),
      );
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final TExampleDto? _initialValue;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  @override
  late final Map<Enum, TFieldConfig> formFieldConfigs = {
    for (final fieldType in TFieldType.values)
      fieldType: switch (fieldType) {
        TFieldType.textInput => TFieldConfig<String>(
            id: fieldType,
            fieldType: TFieldType.textInput,
            initialValue: _initialValue?.text,
            valueValidator: kValueValidatorsMultiple(
              [
                kValueValidatorsRequired(
                  errorText: () => gStrings.thisFieldIsRequired,
                ),
                kValueValidatorsMinLength(
                  minLength: 1,
                  errorText: () => gStrings.titleMustBeAtLeast1CharacterLong,
                ),
                kValueValidatorsMaxLength(
                  maxLength: kLimitsMaxNameLength,
                  errorText: () => gStrings
                      .nameCanBeAtMostKlimitsmaxnamelengthCharactersLong(kLimitsMaxNameLength),
                ),
              ],
            ),
          ),
        TFieldType.checkbox => TFieldConfig<bool>(
            id: fieldType,
            fieldType: TFieldType.checkbox,
            initialValue: _initialValue?.checkbox,
          ),
        TFieldType.colorPicker => TFieldConfig<ColorDerivative>(
            id: fieldType,
            fieldType: TFieldType.colorPicker,
            initialValue: _initialValue?.colorPicker,
          ),
        TFieldType.datePicker => TFieldConfig<DateTime>(
            id: fieldType,
            fieldType: TFieldType.datePicker,
            initialValue: _initialValue?.datePicker,
          ),
        TFieldType.filePickerPath => TFieldConfig<String>(
            id: fieldType,
            fieldType: TFieldType.filePickerPath,
            initialValue: _initialValue?.filePicker,
          ),
        TFieldType.numberInput => TFieldConfig<double>(
            id: fieldType,
            fieldType: TFieldType.numberInput,
            initialValue: _initialValue?.numberInput,
            minValue: 0,
            maxValue: 100,
          ),
        TFieldType.phoneInput => TFieldConfig<String>(
            id: fieldType,
            fieldType: TFieldType.phoneInput,
            initialValue: _initialValue?.phoneInput,
          ),
        TFieldType.radioCard => TFieldConfig<String>(
            id: fieldType,
            fieldType: TFieldType.radioCard,
            initialValue: _initialValue?.radioCard,
            items: ['Option 1', 'Option 2', 'Option 3'],
          ),
        TFieldType.radioGroup => TFieldConfig<String>(
            id: fieldType,
            fieldType: TFieldType.radioGroup,
            initialValue: _initialValue?.radioGroup,
            items: ['Group 1', 'Group 2', 'Group 3'],
          ),
        TFieldType.select => TFieldConfig<String>(
            id: fieldType,
            fieldType: TFieldType.select,
            initialValue: _initialValue?.select,
            items: ['Select 1', 'Select 2', 'Select 3'],
          ),
        TFieldType.selectMulti => TFieldConfig<TMultiExample>(
            id: fieldType,
            fieldType: TFieldType.selectMulti,
            initialValues: _initialValue?.selectMulti,
            items: TMultiExample.values,
          ),
        TFieldType.slider => TFieldConfig<double>(
            id: fieldType,
            fieldType: TFieldType.slider,
            initialValue: _initialValue?.slider,
            minValue: 0,
            maxValue: 100,
          ),
        TFieldType.starRating => TFieldConfig<int>(
            id: fieldType,
            fieldType: TFieldType.starRating,
            initialValue: _initialValue?.starRating,
            minValue: 0,
            maxValue: 5,
          ),
        TFieldType.textArea => TFieldConfig<String>(
            id: fieldType,
            fieldType: TFieldType.textArea,
            initialValue: _initialValue?.textArea,
          ),
        TFieldType.timePicker => TFieldConfig<DateTime>(
            id: fieldType,
            fieldType: TFieldType.timePicker,
            initialValue: _initialValue?.timePicker,
          ),
        TFieldType.toggleGroup => TFieldConfig<String>(
            id: fieldType,
            fieldType: TFieldType.toggleGroup,
            initialValue: _initialValue?.toggleGroup,
            items: ['Toggle 1', 'Toggle 2', 'Toggle 3'],
          ),
        TFieldType.toggleSwitch => TFieldConfig<bool>(
            id: fieldType,
            fieldType: TFieldType.toggleSwitch,
            initialValue: _initialValue?.toggleSwitch,
          ),
        TFieldType.cameraPath => TFieldConfig<String>(
            id: fieldType,
            fieldType: TFieldType.cameraPath,
            initialValue: null,
          ),
      },
  };

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  TFieldConfig<String> get textInput => formFieldConfig(TFieldType.textInput);
  TFieldConfig<String> get select => formFieldConfig(TFieldType.select);
  TFieldConfig<bool> get checkbox => formFieldConfig(TFieldType.checkbox);
  TFieldConfig<String> get cameraPath => formFieldConfig(TFieldType.cameraPath);
  TFieldConfig<ColorDerivative> get colorPicker => formFieldConfig(TFieldType.colorPicker);
  TFieldConfig<DateTime> get datePicker => formFieldConfig(TFieldType.datePicker);
  TFieldConfig<String> get filePickerPath => formFieldConfig(TFieldType.filePickerPath);
  TFieldConfig<double> get numberInput => formFieldConfig(TFieldType.numberInput);
  TFieldConfig<String> get phoneInput => formFieldConfig(TFieldType.phoneInput);
  TFieldConfig<String> get radioCard => formFieldConfig(TFieldType.radioCard);
  TFieldConfig<String> get radioGroup => formFieldConfig(TFieldType.radioGroup);
  TFieldConfig<String> get selectMulti => formFieldConfig(TFieldType.selectMulti);
  TFieldConfig<double> get slider => formFieldConfig(TFieldType.slider);
  TFieldConfig<int> get starRating => formFieldConfig(TFieldType.starRating);
  TFieldConfig<String> get textArea => formFieldConfig(TFieldType.textArea);
  TFieldConfig<DateTime> get timePicker => formFieldConfig(TFieldType.timePicker);
  TFieldConfig<String> get toggleGroup => formFieldConfig(TFieldType.toggleGroup);
  TFieldConfig<bool> get toggleSwitch => formFieldConfig(TFieldType.toggleSwitch);

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void updateTextInput(String? value) => textInput.value = value;
  void updateSelect(String? value) => select.value = value;
  void updateCheckbox(bool? value) => checkbox.value = value;
  void updateCameraPath(String? value) => cameraPath.value = value;
  void updateColorPicker(ColorDerivative? value) => colorPicker.value = value;
  void updateDatePicker(DateTime? value) => datePicker.value = value;
  void updateFilePickerPath(String? value) => filePickerPath.value = value;
  void updateNumberInput(double? value) => numberInput.value = value;
  void updatePhoneInput(String? value) => phoneInput.value = value;
  void updateRadioCard(String? value) => radioCard.value = value;
  void updateRadioGroup(String? value) => radioGroup.value = value;
  void updateSelectMulti(String? value) => selectMulti.value = value;
  void updateSlider(double? value) => slider.value = value;
  void updateStarRating(int? value) => starRating.value = value;
  void updateTextArea(String? value) => textArea.value = value;
  void updateTimePicker(DateTime? value) => timePicker.value = value;
  void updateToggleGroup(String? value) => toggleGroup.value = value;
  void updateToggleSwitch(bool? value) => toggleSwitch.value = value;
}
