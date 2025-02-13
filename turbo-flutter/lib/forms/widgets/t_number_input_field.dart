import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/widgets/t_form_field.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';

class TNumberInputField extends StatefulWidget {
  const TNumberInputField({
    required this.formFieldConfig,
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.label,
    this.onChanged,
    this.onFocusChanged,
    this.onSubmitted,
    this.trailing,
    this.trailingLabel,
  });

  final CrossAxisAlignment crossAxisAlignment;
  final String? label;
  final TFieldConfig<double> formFieldConfig;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onSubmitted;
  final ValueChanged<bool>? onFocusChanged;
  final Widget? trailing;
  final Widget? trailingLabel;

  @override
  State<TNumberInputField> createState() => _TNumberInputFieldState();
}

class _TNumberInputFieldState extends State<TNumberInputField> {
  @override
  void initState() {
    widget.formFieldConfig.addListener(_rebuild);
    if (widget.onFocusChanged != null) {
      widget.formFieldConfig.focusNode.addListener(_onFocusChanged);
    }
    super.initState();
  }

  void _onFocusChanged() => widget.onFocusChanged?.call(widget.formFieldConfig.focusNode.hasFocus);

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    widget.formFieldConfig.removeListener(_rebuild);
    if (widget.onFocusChanged != null) {
      widget.formFieldConfig.focusNode.removeListener(_onFocusChanged);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formFieldConfig = widget.formFieldConfig;
    final formFieldTextStyle = context.texts.formField;

    return TFormField(
      formFieldConfig: formFieldConfig,
      label: widget.label,
      trailingLabel: widget.trailingLabel,
      child: Row(
        crossAxisAlignment: widget.crossAxisAlignment,
        children: [
          Expanded(
            child: NumberInput(
              initialValue: formFieldConfig.initialValue ?? 0,
              onChanged: (value) => _onChanged(formFieldConfig, value),
              onEditingComplete: () {
                // ensure min / max are enforced
                final min = formFieldConfig.minValue;
                final max = formFieldConfig.maxValue;
                // clamp
                final pValue = formFieldConfig.value;
                if (pValue == null) return;
                if (pValue < min) {
                  _onChanged(formFieldConfig, min.toDouble());
                } else if (pValue > max) {
                  _onChanged(formFieldConfig, max.toDouble());
                }
              },
              style: formFieldTextStyle,
              showButtons: true,
            ),
          ),
          if (widget.trailing != null) widget.trailing!,
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
    widget.onSubmitted?.call(value);
  }
}
