import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/widgets/t_form_field.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';

class TRadioGroupField<T> extends StatefulWidget {
  const TRadioGroupField({
    required this.fieldConfig,
    required this.options,
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.label,
    this.onChanged,
    this.onFocusChanged,
    this.onTap,
    this.trailing,
    this.trailingLabel,
  });

  final CrossAxisAlignment crossAxisAlignment;
  final String? label;
  final TFieldConfig<T> fieldConfig;
  final List<T> options;
  final ValueChanged<T>? onChanged;
  final ValueChanged<bool>? onFocusChanged;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Widget? trailingLabel;

  @override
  State<TRadioGroupField<T>> createState() => _TRadioGroupFieldState<T>();
}

class _TRadioGroupFieldState<T> extends State<TRadioGroupField<T>> {
  @override
  void initState() {
    assert(widget.fieldConfig.fieldType.isRadioGroup);
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
    final isReadOnly = formFieldConfig.isReadOnly;

    return TFormField(
      formFieldConfig: formFieldConfig,
      label: widget.label,
      trailingLabel: widget.trailingLabel,
      child: Column(
        crossAxisAlignment: widget.crossAxisAlignment,
        children: [
          ...widget.options.map(
            (option) => RadioListTile<T>(
              value: option,
              groupValue: formFieldConfig.value,
              onChanged: isReadOnly ? null : (value) => _onChanged(formFieldConfig, value!),
              title: Text(option.toString(), style: formFieldTextStyle),
            ),
          ),
        ],
      ),
    );
  }

  void _onChanged(TFieldConfig<T> formFieldConfig, T value) {
    formFieldConfig.silentUpdateValue(value);
    if (formFieldConfig.shouldValidate.value) {
      formFieldConfig.isValid;
    }
    widget.onChanged?.call(value);
  }
}
