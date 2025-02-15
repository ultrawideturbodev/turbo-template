import 'package:flutter/material.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/widgets/t_form_field.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';

class TSliderField extends StatefulWidget {
  const TSliderField({
    required this.fieldConfig,
    required this.min,
    required this.max,
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.divisions,
    this.label,
    this.onChanged,
    this.onFocusChanged,
    this.onTap,
    this.trailing,
    this.trailingLabel,
  });

  final CrossAxisAlignment crossAxisAlignment;
  final int? divisions;
  final String? label;
  final TFieldConfig<double> fieldConfig;
  final double min;
  final double max;
  final ValueChanged<double>? onChanged;
  final ValueChanged<bool>? onFocusChanged;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Widget? trailingLabel;

  @override
  State<TSliderField> createState() => _TSliderFieldState();
}

class _TSliderFieldState extends State<TSliderField> {
  @override
  void initState() {
    assert(widget.fieldConfig.fieldType.isSlider);
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
    final currentValue = formFieldConfig.value ?? widget.min;

    return TFormField(
      formFieldConfig: formFieldConfig,
      label: widget.label,
      trailingLabel: widget.trailingLabel,
      child: Column(
        crossAxisAlignment: widget.crossAxisAlignment,
        children: [
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.label!, style: formFieldTextStyle),
                  Text(currentValue.toStringAsFixed(1), style: formFieldTextStyle),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: currentValue,
                  min: widget.min,
                  max: widget.max,
                  divisions: widget.divisions,
                  onChanged: isReadOnly ? null : (value) => _onChanged(formFieldConfig, value),
                ),
              ),
              if (widget.trailing != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: widget.trailing!,
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _onChanged(TFieldConfig<double> formFieldConfig, double value) {
    formFieldConfig.silentUpdateValue(value);
    if (formFieldConfig.shouldValidate.value) {
      formFieldConfig.isValid;
    }
    widget.onChanged?.call(value);
  }
}
