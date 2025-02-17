import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Colors;
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/widgets/t_form_field.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';

class TColorPickerField extends StatefulWidget {
  const TColorPickerField({
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
    this.showAlpha = true,
    this.mode = ColorPickerMode.rgb,
    this.allowPickFromScreen = true,
  });

  final CrossAxisAlignment crossAxisAlignment;
  final String? hintText;
  final String? label;
  final String? subLabel;
  final TFieldConfig<ColorDerivative> fieldConfig;
  final ValueChanged<ColorDerivative>? onChanged;
  final ValueChanged<bool>? onFocusChanged;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Widget? trailingLabel;
  final bool showAlpha;
  final ColorPickerMode mode;
  final bool allowPickFromScreen;

  @override
  State<TColorPickerField> createState() => _TColorPickerFieldState();
}

class _TColorPickerFieldState extends State<TColorPickerField> {
  @override
  void initState() {
    assert(widget.fieldConfig.fieldType.isColorPicker);
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
            child: ColorInput(
              color: formFieldConfig.value ?? ColorDerivative.fromColor(Colors.black),
              onChanged: isReadOnly ? null : (value) => _onChanged(formFieldConfig, value),
              showAlpha: widget.showAlpha,
              pickerMode: widget.mode,
              allowPickFromScreen: widget.allowPickFromScreen,
              showLabel: true,
              placeholder: hintText != null ? Text(hintText, style: formFieldTextStyle) : null,
            ),
          ),
          if (widget.trailing != null) widget.trailing!,
        ],
      ),
    );
  }

  void _onChanged(TFieldConfig<ColorDerivative> formFieldConfig, ColorDerivative value) {
    formFieldConfig.silentUpdateValue(value);
    if (formFieldConfig.shouldValidate.value) {
      formFieldConfig.isValid;
    }
    widget.onChanged?.call(value);
  }
}
