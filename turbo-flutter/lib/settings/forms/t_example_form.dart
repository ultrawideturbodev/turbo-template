import 'package:get_it/get_it.dart';
import 'package:turbo_template/forms/abstracts/form_config.dart';
import 'package:turbo_template/forms/config/form_field_config.dart';
import 'package:turbo_template/forms/constants/k_value_validators.dart';
import 'package:turbo_template/forms/enums/form_field_type.dart';
import 'package:turbo_template/localizations/globals/g_strings.dart';
import 'package:turbo_template/state/constants/k_limits.dart';

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
  final String colorPicker;
  final DateTime datePicker;
  final String filePicker;
  final num numberInput;
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
  late final Map<Enum, FormFieldConfig> formFieldConfigs = {
    for (final formFieldType in FormFieldType.values)
      formFieldType: switch (formFieldType) {
        FormFieldType.textInput => FormFieldConfig<String>(
            id: formFieldType,
            formFieldType: FormFieldType.textInput,
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
        FormFieldType.checkbox => FormFieldConfig<bool>(
            id: formFieldType,
            formFieldType: FormFieldType.checkbox,
            initialValue: _initialValue?.checkbox,
          ),
        FormFieldType.chipInput => FormFieldConfig<String>(
            id: formFieldType,
            formFieldType: FormFieldType.chipInput,
            initialValues: ['Chip 1', 'Chip 2'],
          ),
        FormFieldType.colorPicker => FormFieldConfig<String>(
            id: formFieldType,
            formFieldType: FormFieldType.colorPicker,
            initialValue: _initialValue?.colorPicker,
          ),
        FormFieldType.datePicker => FormFieldConfig<DateTime>(
            id: formFieldType,
            formFieldType: FormFieldType.datePicker,
            initialValue: _initialValue?.datePicker,
          ),
        FormFieldType.filePickerPath => FormFieldConfig<String>(
            id: formFieldType,
            formFieldType: FormFieldType.filePickerPath,
            initialValue: _initialValue?.filePicker,
          ),
        FormFieldType.numberInput => FormFieldConfig<num>(
            id: formFieldType,
            formFieldType: FormFieldType.numberInput,
            initialValue: _initialValue?.numberInput,
            minValue: 0,
            maxValue: 100,
          ),
        FormFieldType.phoneInput => FormFieldConfig<String>(
            id: formFieldType,
            formFieldType: FormFieldType.phoneInput,
            initialValue: _initialValue?.phoneInput,
          ),
        FormFieldType.radioCard => FormFieldConfig<String>(
            id: formFieldType,
            formFieldType: FormFieldType.radioCard,
            initialValue: _initialValue?.radioCard,
            items: ['Option 1', 'Option 2', 'Option 3'],
          ),
        FormFieldType.radioGroup => FormFieldConfig<String>(
            id: formFieldType,
            formFieldType: FormFieldType.radioGroup,
            initialValue: _initialValue?.radioGroup,
            items: ['Group 1', 'Group 2', 'Group 3'],
          ),
        FormFieldType.select => FormFieldConfig<String>(
            id: formFieldType,
            formFieldType: FormFieldType.select,
            initialValue: _initialValue?.select,
            items: ['Select 1', 'Select 2', 'Select 3'],
          ),
        FormFieldType.selectMulti => FormFieldConfig<TMultiExample>(
            id: formFieldType,
            formFieldType: FormFieldType.selectMulti,
            initialValues: _initialValue?.selectMulti,
            items: TMultiExample.values,
          ),
        FormFieldType.slider => FormFieldConfig<double>(
            id: formFieldType,
            formFieldType: FormFieldType.slider,
            initialValue: _initialValue?.slider,
            minValue: 0,
            maxValue: 100,
          ),
        FormFieldType.starRating => FormFieldConfig<int>(
            id: formFieldType,
            formFieldType: FormFieldType.starRating,
            initialValue: _initialValue?.starRating,
            minValue: 0,
            maxValue: 5,
          ),
        FormFieldType.textArea => FormFieldConfig<String>(
            id: formFieldType,
            formFieldType: FormFieldType.textArea,
            initialValue: _initialValue?.textArea,
          ),
        FormFieldType.timePicker => FormFieldConfig<DateTime>(
            id: formFieldType,
            formFieldType: FormFieldType.timePicker,
            initialValue: _initialValue?.timePicker,
          ),
        FormFieldType.toggleGroup => FormFieldConfig<String>(
            id: formFieldType,
            formFieldType: FormFieldType.toggleGroup,
            initialValue: _initialValue?.toggleGroup,
            items: ['Toggle 1', 'Toggle 2', 'Toggle 3'],
          ),
        FormFieldType.toggleSwitch => FormFieldConfig<bool>(
            id: formFieldType,
            formFieldType: FormFieldType.toggleSwitch,
            initialValue: _initialValue?.toggleSwitch,
          ),
        FormFieldType.cameraPath => FormFieldConfig<String>(
            id: formFieldType,
            formFieldType: FormFieldType.cameraPath,
            initialValue: null,
          ),
      },
  };

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  FormFieldConfig<String> get textInput => formFieldConfig(FormFieldType.textInput);
  FormFieldConfig<String> get select => formFieldConfig(FormFieldType.select);
  FormFieldConfig<bool> get checkbox => formFieldConfig(FormFieldType.checkbox);
  FormFieldConfig<String> get cameraPath => formFieldConfig(FormFieldType.cameraPath);
  FormFieldConfig<String> get chipInput => formFieldConfig(FormFieldType.chipInput);
  FormFieldConfig<String> get colorPicker => formFieldConfig(FormFieldType.colorPicker);
  FormFieldConfig<DateTime> get datePicker => formFieldConfig(FormFieldType.datePicker);
  FormFieldConfig<String> get filePickerPath => formFieldConfig(FormFieldType.filePickerPath);
  FormFieldConfig<int> get numberInput => formFieldConfig(FormFieldType.numberInput);
  FormFieldConfig<String> get phoneInput => formFieldConfig(FormFieldType.phoneInput);
  FormFieldConfig<String> get radioCard => formFieldConfig(FormFieldType.radioCard);
  FormFieldConfig<String> get radioGroup => formFieldConfig(FormFieldType.radioGroup);
  FormFieldConfig<String> get selectMulti => formFieldConfig(FormFieldType.selectMulti);
  FormFieldConfig<double> get slider => formFieldConfig(FormFieldType.slider);
  FormFieldConfig<int> get starRating => formFieldConfig(FormFieldType.starRating);
  FormFieldConfig<String> get textArea => formFieldConfig(FormFieldType.textArea);
  FormFieldConfig<DateTime> get timePicker => formFieldConfig(FormFieldType.timePicker);
  FormFieldConfig<String> get toggleGroup => formFieldConfig(FormFieldType.toggleGroup);
  FormFieldConfig<bool> get toggleSwitch => formFieldConfig(FormFieldType.toggleSwitch);

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void updateTextInput(String? value) => textInput.value = value;
  void updateSelect(String? value) => select.value = value;
  void updateCheckbox(bool? value) => checkbox.value = value;
  void updateCameraPath(String? value) => cameraPath.value = value;
  void updateChipInput(String? value) => chipInput.value = value;
  void updateColorPicker(String? value) => colorPicker.value = value;
  void updateDatePicker(DateTime? value) => datePicker.value = value;
  void updateFilePickerPath(String? value) => filePickerPath.value = value;
  void updateNumberInput(int? value) => numberInput.value = value;
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
