import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:informers/informer.dart';
import 'package:loglytics/loglytics.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/extensions/string_extension.dart';
import 'package:turbo_template/forms/enums/t_field_type.dart';
import 'package:turbo_template/forms/typedefs/values_validator_def.dart';
import 'package:turbo_template/state/exceptions/unexpected_state_exception.dart';

class TFieldConfig<T> extends ChangeNotifier with Loglytics {
  TFieldConfig({
    FormFieldValidator<T>? valueValidator,
    List<T>? initialValues,
    List<T>? items,
    List<TextInputFormatter>? inputFormatters,
    List<String>? autoCompleteValues,
    T? initialValue,
    ValuesValidatorDef<T>? valuesValidator,
    bool isEnabled = true,
    bool isReadOnly = false,
    bool isVisible = true,
    bool obscureText = false,
    required this.fieldType,
    required Object id,
    this.incrementAmount = 1,
    this.labelBuilder,
    this.maxValue = double.maxFinite,
    this.minValue = 0,
  })  : _id = id,
        _initialValue = initialValue,
        _initialValues = initialValues,
        _inputFormatters = inputFormatters,
        _autoCompleteValues = autoCompleteValues,
        _isEnabled = isEnabled,
        _isReadOnly = isReadOnly,
        _isVisible = isVisible,
        _items = items,
        _obscureText = obscureText,
        _value = initialValue,
        _valueValidator = valueValidator,
        _valuesValidator = valuesValidator,
        _formFieldType = fieldType;

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final FormFieldValidator<T>? _valueValidator;
  List<T>? _initialValues;
  List<T>? _items;
  List<T>? _values;
  List<TextInputFormatter>? _inputFormatters;
  final List<String>? _autoCompleteValues;
  T? _initialValue;
  T? _value;
  final ValuesValidatorDef<T>? _valuesValidator;
  bool _isEnabled;
  bool _isReadOnly;
  bool _isVisible;
  bool _obscureText;
  final FocusNode _focusNode = FocusNode();
  final TFieldType fieldType;
  final Object _id;
  final num incrementAmount;
  final num maxValue;
  final num minValue;
  final String Function(T value)? labelBuilder;
  final TFieldType _formFieldType;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  void dispose() {
    log.info('Disposing $fieldType with id: $_id..');
    switch (fieldType) {
      case TFieldType.textInput:
      case TFieldType.textArea:
        textEditingController.dispose();
        break;
      case TFieldType.select:
      case TFieldType.checkbox:
      case TFieldType.cameraPath:
      case TFieldType.colorPicker:
      case TFieldType.datePicker:
      case TFieldType.dateRangePicker:
      case TFieldType.filePickerPath:
      case TFieldType.numberInput:
      case TFieldType.phoneInput:
      case TFieldType.radioCard:
      case TFieldType.radioGroup:
      case TFieldType.slider:
      case TFieldType.starRating:
      case TFieldType.timePicker:
      case TFieldType.toggleGroup:
      case TFieldType.toggleSwitch:
      case TFieldType.selectMulti:
        break;
    }
    _errorText.dispose();
    _shouldValidate.dispose();
    _focusNode.dispose();
    super.dispose();
    log.info('Disposed $fieldType with id: $_id!');
  }

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  final Informer<String?> _errorText = Informer(null);
  final Informer<bool> _shouldValidate = Informer(false);

  late final TextEditingController textEditingController = TextEditingController(
    text: _value as String? ?? _initialValue as String?,
  );

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  FocusNode get focusNode => _focusNode;
  FormFieldValidator<T>? get validator => _valueValidator;
  List<T>? get initialValues => _initialValues;
  List<T>? get items => _items;
  List<TextInputFormatter>? get inputFormatters => _inputFormatters;
  List<String>? get autoCompleteValues => _autoCompleteValues;
  Set<T> get valuesAsSet => values?.toSet() ?? {};
  T? get initialValue => _initialValue;
  ValueListenable<String?> get errorText => _errorText;
  ValueListenable<bool> get shouldValidate => _shouldValidate;
  ValuesValidatorDef<T>? get valuesValidator => _valuesValidator;
  bool get didChange => _value != _initialValue;
  bool get hasFocus => _focusNode.hasFocus;
  bool get isEnabled => _isEnabled;
  bool get isReadOnly => _isReadOnly;
  bool get isVisible => _isVisible;
  bool get obscureText => _obscureText;

  List<T>? get values => _values;

  T? get value => _value;

  double? get valueAsDouble {
    final localValue = value;
    if (localValue is String?) {
      return localValue?.tryAsDouble;
    }
    return null;
  }

  int? get valueAsInt {
    final localValue = value;
    if (localValue is String?) {
      return localValue?.tryAsInt;
    }
    return null;
  }

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void rebuild() {
    try {
      notifyListeners();
      log.info('Rebuilt $fieldType with id: $_id!');
    } catch (error, stackTrace) {
      log.error(
        '$error caught while rebuilding $fieldType with id: $_id',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void updateErrorText({required String? errorText}) => _errorText.update(errorText);

  void requestFocus() {
    _focusNode.requestFocus();
    switch (fieldType) {
      case TFieldType.textInput:
      case TFieldType.textArea:
        // select the entire text
        textEditingController.selection = TextSelection(
          baseOffset: 0,
          extentOffset: textEditingController.text.length,
        );
        break;
      case TFieldType.select:
      case TFieldType.checkbox:
      case TFieldType.cameraPath:
      case TFieldType.colorPicker:
      case TFieldType.datePicker:
      case TFieldType.dateRangePicker:
      case TFieldType.filePickerPath:
      case TFieldType.numberInput:
      case TFieldType.phoneInput:
      case TFieldType.radioCard:
      case TFieldType.radioGroup:
      case TFieldType.slider:
      case TFieldType.starRating:
      case TFieldType.timePicker:
      case TFieldType.toggleGroup:
      case TFieldType.toggleSwitch:
      case TFieldType.selectMulti:
        break;
    }
    log.info('Requested focus for $fieldType with id: $_id!');
  }

  void unfocus() => _focusNode.unfocus();

  void _tryValidate() {
    if (shouldValidate.value) {
      isValid;
    }
  }

  void _resetShouldValidate() {
    _shouldValidate.update(false, doNotifyListeners: false);
    _errorText.update(null);
  }

  void silentReset() {
    _resetShouldValidate();
    switch (fieldType) {
      case TFieldType.textInput:
      case TFieldType.textArea:
        textEditingController.text = _initialValue as String? ?? '';
        _value = _initialValue;
        break;
      case TFieldType.select:
      case TFieldType.checkbox:
      case TFieldType.cameraPath:
      case TFieldType.colorPicker:
      case TFieldType.datePicker:
      case TFieldType.dateRangePicker:
      case TFieldType.filePickerPath:
      case TFieldType.numberInput:
      case TFieldType.phoneInput:
      case TFieldType.radioCard:
      case TFieldType.radioGroup:
      case TFieldType.slider:
      case TFieldType.starRating:
      case TFieldType.timePicker:
      case TFieldType.toggleGroup:
      case TFieldType.toggleSwitch:
        _value = _initialValue;
        break;
      case TFieldType.selectMulti:
        _values = _initialValues;
    }
    log.info('Reset $fieldType with id: $_id!');
  }

  void silentUpdateValue(T? value) => _value = value;
  void silentUpdateValues(List<T>? values) => _values = values;
  void updateCurrentValue(T? Function(T? value) current) => value = current(value);
  void updateCurrentValues(List<T>? Function(List<T>? values) current) => values = current(values);

  void addValue(T value) {
    if (values != null) {
      values!.add(value);
    } else {
      values = [value];
    }
  }

  void removeValue(T value) => values?.remove(value);

  bool get isNotValid => !isValid;

  bool get isValidSilent =>
      switch (fieldType) {
        TFieldType.textInput => _valueValidator?.call(_value),
        TFieldType.select => _valueValidator?.call(_value),
        TFieldType.checkbox => _valueValidator?.call(_value),
        TFieldType.cameraPath => _valueValidator?.call(_value),
        TFieldType.colorPicker => _valueValidator?.call(_value),
        TFieldType.datePicker => _valueValidator?.call(_value),
        TFieldType.dateRangePicker => _valueValidator?.call(_value),
        TFieldType.filePickerPath => _valueValidator?.call(_value),
        TFieldType.numberInput => _valueValidator?.call(_value),
        TFieldType.phoneInput => _valueValidator?.call(_value),
        TFieldType.radioCard => _valueValidator?.call(_value),
        TFieldType.radioGroup => _valueValidator?.call(_value),
        TFieldType.selectMulti => _valuesValidator?.call(_values),
        TFieldType.slider => _valueValidator?.call(_value),
        TFieldType.starRating => _valueValidator?.call(_value),
        TFieldType.textArea => _valueValidator?.call(_value),
        TFieldType.timePicker => _valueValidator?.call(_value),
        TFieldType.toggleGroup => _valueValidator?.call(_value),
        TFieldType.toggleSwitch => _valueValidator?.call(_value),
      } ==
      null;

  bool get isValid {
    if (!_shouldValidate.value) {
      _shouldValidate.update(true, doNotifyListeners: false);
    }
    final errorText = switch (fieldType) {
      TFieldType.textInput => _valueValidator?.call(_value),
      TFieldType.select => _valueValidator?.call(_value),
      TFieldType.checkbox => _valueValidator?.call(_value),
      TFieldType.cameraPath => _valueValidator?.call(_value),
      TFieldType.colorPicker => _valueValidator?.call(_value),
      TFieldType.datePicker => _valueValidator?.call(_value),
      TFieldType.dateRangePicker => _valueValidator?.call(_value),
      TFieldType.filePickerPath => _valueValidator?.call(_value),
      TFieldType.numberInput => _valueValidator?.call(_value),
      TFieldType.phoneInput => _valueValidator?.call(_value),
      TFieldType.radioCard => _valueValidator?.call(_value),
      TFieldType.radioGroup => _valueValidator?.call(_value),
      TFieldType.selectMulti => _valuesValidator?.call(_values),
      TFieldType.slider => _valueValidator?.call(_value),
      TFieldType.starRating => _valueValidator?.call(_value),
      TFieldType.textArea => _valueValidator?.call(_value),
      TFieldType.timePicker => _valueValidator?.call(_value),
      TFieldType.toggleGroup => _valueValidator?.call(_value),
      TFieldType.toggleSwitch => _valueValidator?.call(_value),
    };
    _errorText.update(errorText);
    final isValid = errorText == null;
    log.info('Checking if $fieldType with id: $_id is valid: $isValid!');
    return isValid;
  }

  set initialValue(T? value) {
    _initialValue = value;
    _value = value;
    _tryValidate();
    notifyListeners();
    log.info('Set initialValue to $value for $fieldType with id: $_id!');
  }

  set initialValues(List<T>? values) {
    _initialValues = values;
    _values = values;
    _tryValidate();
    notifyListeners();
    log.info('Set initialValues to $values for $fieldType with id: $_id!');
  }

  set items(List<T>? value) {
    _items = value;
    _tryValidate();
    notifyListeners();
    log.info('Set items to $value for $fieldType with id: $_id!');
  }

  set isReadOnly(bool value) {
    _isReadOnly = value;
    if (value) {
      _tryValidate();
    } else {
      _resetShouldValidate();
    }
    notifyListeners();
    log.info('Set isReadOnly to $value for $fieldType with id: $_id!');
  }

  set isVisible(bool value) {
    _isVisible = value;
    if (value) {
      _tryValidate();
    } else {
      _resetShouldValidate();
    }
    notifyListeners();
    log.info('Set isVisible to $value for $fieldType with id: $_id!');
  }

  set value(T? value) {
    switch (fieldType) {
      case TFieldType.textInput:
      case TFieldType.textArea:
        _value = value;
        final textValue = (_value as String?) ?? '';
        final oldCursorPos = textEditingController.selection.baseOffset;
        final oldTextLength = textEditingController.text.length;
        final oldTextValue = textEditingController.text;

        textEditingController.text = textValue;

        int newCursorPos = oldCursorPos;
        if (textValue.length > oldTextLength && oldTextValue == '0') {
          newCursorPos = textValue.length;
        } else if (textValue.length > oldTextLength) {
          newCursorPos += 1;
        } else if (textValue.length < oldTextLength) {
          newCursorPos -= 1;
        }

        newCursorPos = newCursorPos.clamp(0, textValue.length);

        textEditingController.selection =
            TextSelection.fromPosition(TextPosition(offset: newCursorPos));
        break;
      case TFieldType.select:
      case TFieldType.checkbox:
      case TFieldType.cameraPath:
      case TFieldType.colorPicker:
      case TFieldType.datePicker:
      case TFieldType.dateRangePicker:
      case TFieldType.filePickerPath:
      case TFieldType.numberInput:
      case TFieldType.phoneInput:
      case TFieldType.radioCard:
      case TFieldType.radioGroup:
      case TFieldType.slider:
      case TFieldType.starRating:
      case TFieldType.timePicker:
      case TFieldType.toggleGroup:
      case TFieldType.toggleSwitch:
        _value = value;
        break;
      case TFieldType.selectMulti:
        if (value != null) {
          _values = [value];
        }
    }
    _tryValidate();
    notifyListeners();
  }

  set values(List<T>? values) {
    switch (fieldType) {
      case TFieldType.textArea:
      case TFieldType.textInput:
      case TFieldType.select:
      case TFieldType.checkbox:
      case TFieldType.cameraPath:
      case TFieldType.colorPicker:
      case TFieldType.datePicker:
      case TFieldType.dateRangePicker:
      case TFieldType.filePickerPath:
      case TFieldType.numberInput:
      case TFieldType.phoneInput:
      case TFieldType.radioCard:
      case TFieldType.radioGroup:
      case TFieldType.slider:
      case TFieldType.starRating:
      case TFieldType.timePicker:
      case TFieldType.toggleGroup:
      case TFieldType.toggleSwitch:
        throw UnexpectedStateException(
          reason: 'Cannot set values for $fieldType with id: $_id',
        );
      case TFieldType.selectMulti:
        _values = values;
    }
    _tryValidate();
    notifyListeners();
    log.info('Set validator to $value for $fieldType with id: $_id!');
  }

  set isEnabled(bool value) {
    _isEnabled = value;
    if (value) {
      _tryValidate();
    } else {
      _resetShouldValidate();
    }
    notifyListeners();
    log.info('Set isEnabled to $value for $fieldType with id: $_id!');
  }

  set inputFormatters(List<TextInputFormatter>? value) {
    _inputFormatters = value;
    _tryValidate();
    notifyListeners();
    log.info('Set inputFormatters to $value for $fieldType with id: $_id!');
  }

  set obscureText(bool value) {
    _obscureText = value;
    _tryValidate();
    notifyListeners();
    log.info('Set obscureText to $value for $fieldType with id: $_id!');
  }

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\
}

extension FormFieldConfigStringExtension on TFieldConfig<String> {
  bool get valueTrimIsEmpty => _value?.trimIsEmpty ?? true;
}
