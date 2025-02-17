import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/widgets/t_form_field.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';

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
  final void Function(DateTime? value)? onChanged;
  final ValueChanged<bool>? onFocusChanged;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Widget? trailingLabel;

  @override
  State<TDatePickerField> createState() => _TDatePickerFieldState();
}

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

  void _onChanged(TFieldConfig<DateTime> formFieldConfig, DateTime? value) {
    formFieldConfig.value = value;

    if (formFieldConfig.shouldValidate.value) {
      formFieldConfig.isValid;
    }

    widget.onChanged?.call(value);
  }
}
