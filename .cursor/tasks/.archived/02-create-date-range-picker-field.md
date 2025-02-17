# Create TDateRangePickerField

Implement a form field widget for date range selection using the shadcn_flutter DateRangePicker component.

## Implementation Steps

- [x] 1. Add date range picker field type to TFieldType enum
  ```dart
  // lib/forms/enums/t_field_type.dart
  enum TFieldType {
    // ... existing types ...
    dateRangePicker,
  }
  ```

- [x] 2. Create TDateRangePickerField widget
  ```dart
  // lib/forms/widgets/t_date_range_picker_field.dart
  class TDateRangePickerField extends StatefulWidget {
    const TDateRangePickerField({
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
    final TFieldConfig<DateTimeRange> fieldConfig;
    final ValueChanged<DateTimeRange>? onChanged;
    final ValueChanged<bool>? onFocusChanged;
    final VoidCallback? onTap;
    final Widget? trailing;
    final Widget? trailingLabel;
  }
  ```

- [x] 3. Implement TDateRangePickerField state
  ```dart
  class _TDateRangePickerFieldState extends State<TDateRangePickerField> {
    @override
    void initState() {
      assert(widget.fieldConfig.fieldType.isDateRangePicker);
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

- [x] 4. Implement build method with DateRangePicker
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
            child: DateRangePicker(
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
  void _onChanged(TFieldConfig<DateTimeRange> formFieldConfig, DateTimeRange? value) {
    if (value == null) return;
    
    formFieldConfig.value = value;
    
    if (formFieldConfig.shouldValidate.value) {
      formFieldConfig.isValid;
    }
    
    widget.onChanged?.call(value);
  }
  ```

- [x] 6. Add isDateRangePicker extension to TFieldType
  ```dart
  // lib/forms/enums/t_field_type.dart
  extension TFieldTypeExtension on TFieldType {
    bool get isDateRangePicker => this == TFieldType.dateRangePicker;
  }
  ```

- [ ] 7. Export the new widget in barrel file
  ```dart
  // lib/forms/widgets.dart
  export 'widgets/t_date_range_picker_field.dart';
  ``` 