# Create TDatePickerField

Implement a form field widget for single date selection using the shadcn_flutter DatePicker component.

## Implementation Steps

- [x] 1. Add date picker field type to TFieldType enum
  ```dart
  // lib/forms/enums/t_field_type.dart
  enum TFieldType {
    // ... existing types ...
    datePicker,
  }
  ```

- [x] 2. Create TDatePickerField widget
  ```dart
  // lib/forms/widgets/t_date_picker_field.dart
  class TDatePickerField extends StatefulWidget {
    const TDatePickerField({
      required this.fieldConfig,
      super.key,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.hintText,
      this.label,
      this.onChanged,
      this.onFocusChanged,
      this.onTap,
      this.trailing,
      this.trailingLabel,
      this.subLabel,
    });

    final CrossAxisAlignment crossAxisAlignment;
    final String? hintText;
    final String? label;
    final String? subLabel;
    final TFieldConfig<DateTime> fieldConfig;
    final ValueChanged<DateTime>? onChanged;
    final ValueChanged<bool>? onFocusChanged;
    final VoidCallback? onTap;
    final Widget? trailing;
    final Widget? trailingLabel;
  }
  ```

- [x] 3. Implement TDatePickerField state
  ```dart
  class _TDatePickerFieldState extends State<TDatePickerField> {
    @override
    void initState() {
      assert(widget.fieldConfig.fieldType.isDatePicker);
      widget.fieldConfig.addListener(_rebuild);
      if (widget.onFocusChanged != null) {
        widget.fieldConfig.focusNode.addListener(_onFocusChanged);
      }
      super.initState();
    }

    void _onFocusChanged() => widget.onFocusChanged?.call(widget.fieldConfig.focusNode.hasFocus);
    void _rebuild() => setState(() {});

    @override
    void dispose() {
      widget.fieldConfig.removeListener(_rebuild);
      if (widget.onFocusChanged != null) {
        widget.fieldConfig.focusNode.removeListener(_onFocusChanged);
      }
      super.dispose();
    }
  }
  ```

- [x] 4. Implement build method with DatePicker
  ```dart
  @override
  Widget build(BuildContext context) {
    final formFieldConfig = widget.fieldConfig;
    final formFieldTextStyle = context.texts.formField;
    final hintText = widget.hintText;
    final isReadOnly = formFieldConfig.isReadOnly;

    return TFormField(
      formFieldConfig: formFieldConfig,
      label: widget.label,
      subLabel: widget.subLabel,
      trailingLabel: widget.trailingLabel,
      child: Row(
        crossAxisAlignment: widget.crossAxisAlignment,
        children: [
          Expanded(
            child: DatePicker(
              value: formFieldConfig.value,
              mode: PromptMode.popover,
              placeholder: hintText != null ? Text(hintText, style: formFieldTextStyle) : null,
              onChanged: isReadOnly ? null : (value) => _onChanged(formFieldConfig, value),
            ),
          ),
          if (widget.trailing != null) widget.trailing!,
        ],
      ),
    );
  }
  ```

- [x] 5. Implement onChange handler
  ```dart
  void _onChanged(TFieldConfig<DateTime> formFieldConfig, DateTime? value) {
    if (value == null) return;
    
    formFieldConfig.value = value;
    
    if (formFieldConfig.shouldValidate.value) {
      formFieldConfig.isValid;
    }
    
    widget.onChanged?.call(value);
  }
  ```

- [x] 6. Add isDatePicker extension to TFieldType
  ```dart
  // lib/forms/enums/t_field_type.dart
  extension TFieldTypeExtension on TFieldType {
    bool get isDatePicker => this == TFieldType.datePicker;
  }
  ```

- [x] 7. Add to settings view
  ```dart
  TDatePickerField(
    fieldConfig: model.form.datePicker,
    label: 'Date Picker Example',
    subLabel: 'Select a single date',
    hintText: 'Pick a date...',
    onChanged: (value) => model.form.updateDatePicker(value),
  ),
  ``` 