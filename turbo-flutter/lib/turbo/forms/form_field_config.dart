import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:informers/informer.dart';
import 'package:loglytics/loglytics.dart';

import '../enums/form_field_type.dart';
import '../exceptions/unexpected_state_exception.dart';
import '../extensions/string_extension.dart';
import '../typedefs/values_validator.dart';

class FormFieldConfig<T> extends ChangeNotifier with Loglytics {
  FormFieldConfig({
    FormFieldValidator<T>? valueValidator,
    List<T>? initialValues,
    List<T>? items,
    List<TextInputFormatter>? inputFormatters,
    T? initialValue,
    ValuesValidator<T>? valuesValidator,
    bool isEnabled = true,
    bool isReadOnly = false,
    bool isVisible = true,
    bool obscureText = false,
    required FormFieldType formFieldType,
    required Object id,
    this.incrementAmount = 1,
    this.labelBuilder,
    this.maxValue = double.maxFinite,
    this.minValue = 0,
  })  : _id = id,
        _initialValue = initialValue,
        _initialValues = initialValues,
        _inputFormatters = inputFormatters,
        _isEnabled = isEnabled,
        _isReadOnly = isReadOnly,
        _isVisible = isVisible,
        _items = items,
        _obscureText = obscureText,
        _value = initialValue,
        _valueValidator = valueValidator,
        _valuesValidator = valuesValidator,
        _formFieldType = formFieldType;

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  FormFieldValidator<T>? _valueValidator;
  List<T>? _initialValues;
  List<T>? _items;
  List<T>? _values;
  List<TextInputFormatter>? _inputFormatters;
  T? _initialValue;
  T? _value;
  ValuesValidator<T>? _valuesValidator;
  bool _isEnabled;
  bool _isReadOnly;
  bool _isVisible;
  bool _obscureText;
  final FocusNode _focusNode = FocusNode();
  final FormFieldType _formFieldType;
  final Object _id;
  final num incrementAmount;
  final num maxValue;
  final num minValue;
  final String Function(T value)? labelBuilder;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  void dispose() {
    log.info('Disposing $_formFieldType with id: $_id..');
    switch (_formFieldType) {
      case FormFieldType.text:
      case FormFieldType.counter:
        textEditingController.dispose();
        break;
      case FormFieldType.dropDown:
      case FormFieldType.checkbox:
      case FormFieldType.chipWrap:
      case FormFieldType.dateTimePicker:
        break;
    }
    _errorText.dispose();
    _shouldValidate.dispose();
    _focusNode.dispose();
    super.dispose();
    log.info('Disposed $_formFieldType with id: $_id!');
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
  Set<T> get valuesAsSet => values?.toSet() ?? {};
  T? get initialValue => _initialValue;
  ValueListenable<String?> get errorText => _errorText;
  ValueListenable<bool> get shouldValidate => _shouldValidate;
  ValuesValidator<T>? get valuesValidator => _valuesValidator;
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
      log.info('Rebuilt $_formFieldType with id: $_id!');
    } catch (error, stackTrace) {
      log.error(
        '$error caught while rebuilding $_formFieldType with id: $_id',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void updateErrorText({required String? errorText}) => _errorText.update(errorText);

  void requestFocus() {
    _focusNode.requestFocus();
    switch (_formFieldType) {
      case FormFieldType.text:
      case FormFieldType.counter:
        // select the entire text
        textEditingController.selection = TextSelection(
          baseOffset: 0,
          extentOffset: textEditingController.text.length,
        );
        break;
      case FormFieldType.dropDown:
      case FormFieldType.checkbox:
      case FormFieldType.dateTimePicker:
      case FormFieldType.chipWrap:
        break;
    }
    log.info('Requested focus for $_formFieldType with id: $_id!');
  }

  void unfocus() => _focusNode.unfocus();

  void silentReset() {
    switch (_formFieldType) {
      case FormFieldType.text:
      case FormFieldType.counter:
        textEditingController.text = _initialValue as String? ?? '';
        _value = _initialValue;
        break;
      case FormFieldType.dropDown:
      case FormFieldType.checkbox:
      case FormFieldType.dateTimePicker:
        _value = _initialValue;
        break;
      case FormFieldType.chipWrap:
        _values = _initialValues;
    }
    _shouldValidate.update(false, doNotifyListeners: false);
    _errorText.update(null);
    log.info('Reset $_formFieldType with id: $_id!');
  }

  void silentUpdateValue(T? value) {
    _value = value;
  }

  void silentUpdateValues(List<T>? values) {
    _values = values;
  }

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

  bool get isValid {
    if (!_shouldValidate.value) {
      _shouldValidate.update(true, doNotifyListeners: false);
    }

    final errorText = switch (_formFieldType) {
      FormFieldType.text => _valueValidator?.call(_value),
      FormFieldType.dropDown => _valueValidator?.call(_value),
      FormFieldType.checkbox => _valueValidator?.call(_value),
      FormFieldType.counter => _valueValidator?.call(_value),
      FormFieldType.dateTimePicker => _valueValidator?.call(_value),
      FormFieldType.chipWrap => _valuesValidator?.call(_values),
    };
    _errorText.update(errorText);
    final isValid = errorText == null;
    log.info('Checking if $_formFieldType with id: $_id is valid: $isValid!');
    return isValid;
  }

  set initialValue(T? value) {
    _initialValue = value;
    _value = value;
    notifyListeners();
    log.info('Set initialValue to $value for $_formFieldType with id: $_id!');
  }

  set initialValues(List<T>? values) {
    _initialValues = values;
    _values = values;
    notifyListeners();
    log.info('Set initialValues to $values for $_formFieldType with id: $_id!');
  }

  set items(List<T>? value) {
    _items = value;
    notifyListeners();
    log.info('Set items to $value for $_formFieldType with id: $_id!');
  }

  set isReadOnly(bool value) {
    _isReadOnly = value;
    notifyListeners();
    log.info('Set isReadOnly to $value for $_formFieldType with id: $_id!');
  }

  set isVisible(bool value) {
    _isVisible = value;
    notifyListeners();
    log.info('Set isVisible to $value for $_formFieldType with id: $_id!');
  }

  set value(T? value) {
    switch (_formFieldType) {
      case FormFieldType.text:
      case FormFieldType.counter:
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
      case FormFieldType.dropDown:
      case FormFieldType.checkbox:
      case FormFieldType.dateTimePicker:
        _value = value;
        break;
      case FormFieldType.chipWrap:
        if (value != null) {
          _values = [value];
        }
    }
    notifyListeners();
  }

  set values(List<T>? values) {
    switch (_formFieldType) {
      case FormFieldType.text:
      case FormFieldType.counter:
      case FormFieldType.dropDown:
      case FormFieldType.checkbox:
      case FormFieldType.dateTimePicker:
        throw const UnexpectedStateException(
          reason: 'Should not set values, '
              'instead set value (single) when formFieldType is text, counter, dropDown or checkbox',
        );
      case FormFieldType.chipWrap:
        _values = values;
    }
    notifyListeners();
  }

  set valuesValidator(ValuesValidator<T>? value) {
    _valuesValidator = value;
    notifyListeners();
    log.info('Set valuesValidator to $value for $_formFieldType with id: $_id!');
  }

  set validator(FormFieldValidator<T>? value) {
    _valueValidator = value;
    notifyListeners();
    log.info('Set validator to $value for $_formFieldType with id: $_id!');
  }

  set isEnabled(bool value) {
    _isEnabled = value;
    notifyListeners();
    log.info('Set isEnabled to $value for $_formFieldType with id: $_id!');
  }

  set inputFormatters(List<TextInputFormatter>? value) {
    _inputFormatters = value;
    notifyListeners();
    log.info('Set inputFormatters to $value for $_formFieldType with id: $_id!');
  }

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
    log.info('Set obscureText to $value for $_formFieldType with id: $_id!');
  }

// 🏗️ HELPERS ------------------------------------------------------------------------------- \\

// 📍 LOCATOR ------------------------------------------------------------------------------- \\
}

extension FormFieldConfigStringExtension on FormFieldConfig<String> {
  bool get valueTrimIsEmpty => _value?.trimIsEmpty ?? true;
}
