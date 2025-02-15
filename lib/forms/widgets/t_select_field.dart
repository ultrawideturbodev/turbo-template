import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/widgets/t_form_field.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';

class TSelectField<T> extends StatefulWidget {
  const TSelectField({
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
  });

  final CrossAxisAlignment crossAxisAlignment;
  final String? hintText;
  final String? label;
  final TFieldConfig<T> fieldConfig;
  final ValueChanged<T>? onChanged;
  final ValueChanged<bool>? onFocusChanged;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Widget? trailingLabel;

  @override
  State<TSelectField<T>> createState() => _TSelectFieldState<T>();
}

class _TSelectFieldState<T> extends State<TSelectField<T>> {
  @override
  void initState() {
    assert(widget.fieldConfig.fieldType.isSelect);
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
    final items = formFieldConfig.items ?? [];

    return TFormField(
      formFieldConfig: formFieldConfig,
      label: widget.label,
      trailingLabel: widget.trailingLabel,
      child: Row(
        crossAxisAlignment: widget.crossAxisAlignment,
        children: [
          Expanded(
            child: Select<T>(
              value: formFieldConfig.value,
              focusNode: formFieldConfig.focusNode,
              itemBuilder: (context, item) => Text(
                formFieldConfig.labelBuilder?.call(item) ?? item.toString(),
                style: formFieldTextStyle,
              ),
              placeholder: hintText != null ? Text(hintText, style: formFieldTextStyle) : null,
              onChanged: isReadOnly ? null : (value) => _onChanged(formFieldConfig, value),
              children: items
                  .map((item) => SelectItemButton<T>(
                        value: item,
                        child: Text(
                          formFieldConfig.labelBuilder?.call(item) ?? item.toString(),
                          style: formFieldTextStyle,
                        ),
                      ))
                  .toList(),
            ),
          ),
          if (widget.trailing != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: widget.trailing!,
            ),
        ],
      ),
    );
  }

  void _onChanged(TFieldConfig<T> formFieldConfig, T? value) {
    if (value == null) return;
    formFieldConfig.silentUpdateValue(value);
    if (formFieldConfig.shouldValidate.value) {
      formFieldConfig.isValid;
    }
    widget.onChanged?.call(value);
  }
}
