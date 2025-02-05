import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:gap/gap.dart';
import 'package:informers/informer.dart';

import '../constants/k_sizes.dart';
import '../extensions/color_extension.dart';
import '../extensions/context_extension.dart';
import '../extensions/num_extension.dart';
import '../forms/form_field_config.dart';
import 'animated_enabled.dart';
import 'scale_button.dart';

class FormFieldCounter extends StatefulWidget {
  const FormFieldCounter({
    required this.formFieldConfig,
    this.onSubmitted,
    this.foregroundColor,
    this.height = kSizesButtonHeight,
    this.onChanged,
    this.allowDecimals = true,
    super.key,
  });

  final FormFieldConfig<String> formFieldConfig;
  final ValueChanged<String>? onSubmitted;
  final Color? foregroundColor;
  final double height;
  final void Function(String? value)? onChanged;
  final bool allowDecimals;

  @override
  State<FormFieldCounter> createState() => _FormFieldCounterState();
}

class _FormFieldCounterState extends State<FormFieldCounter> {
  late final int decimals;

  final enabledBorderWidth = Informer<double>(1);

  @override
  void initState() {
    decimals = widget.formFieldConfig.incrementAmount.decimals;
    widget.formFieldConfig.addListener(_rebuild);
    super.initState();
  }

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    widget.formFieldConfig.removeListener(_rebuild);
    enabledBorderWidth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formFieldConfig = widget.formFieldConfig;
    final backgroundColor = context.colors.background;
    final foregroundColor = widget.foregroundColor ?? backgroundColor.onColor;
    final height = widget.height;
    final iconHeight = height - 4;
    return AnimatedEnabled(
      isEnabled: formFieldConfig.isEnabled,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScaleButton(
            onPressed: () {
              formFieldConfig.updateCurrentValue(
                (value) {
                  final minValue = formFieldConfig.minValue;
                  final currentValue = num.tryParse(value ?? '$minValue');
                  if (currentValue != null && currentValue > minValue) {
                    final newValue = currentValue - formFieldConfig.incrementAmount;
                    if (newValue == 0) return '0';
                    return newValue.toStringAsFixed(decimals);
                  }
                  return '$minValue';
                },
              );
              if (formFieldConfig.shouldValidate.value) {
                formFieldConfig.isValid;
              }
              widget.onChanged?.call(formFieldConfig.value);
            },
            child: Container(
              height: iconHeight,
              width: iconHeight,
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(width: 2, color: foregroundColor),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.remove_rounded, color: foregroundColor),
            ),
          ),
          const Gap(12),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: height,
              ),
              child: IgnorePointer(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: formFieldConfig.textEditingController,
                  onChanged: (value) {
                    formFieldConfig.silentUpdateValue(value);
                    if (formFieldConfig.shouldValidate.value) {
                      formFieldConfig.isValid;
                    }
                    widget.onChanged?.call(value);
                  },
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: widget.allowDecimals,
                  ),
                  readOnly: formFieldConfig.isReadOnly,
                  focusNode: formFieldConfig.focusNode,
                  inputFormatters: formFieldConfig.inputFormatters,
                  obscureText: formFieldConfig.obscureText,
                  style: context.texts.button,
                  onSubmitted: widget.onSubmitted,
                ),
              ),
            ),
          ),
          const Gap(12),
          ScaleButton(
            onPressed: () {
              formFieldConfig.updateCurrentValue(
                (value) {
                  final currentValue = num.tryParse(value ?? '${formFieldConfig.minValue}');
                  if (currentValue != null && currentValue < formFieldConfig.maxValue) {
                    return (currentValue + formFieldConfig.incrementAmount)
                        .toStringAsFixed(decimals);
                  }
                  return currentValue?.toStringAsFixed(decimals) ??
                      formFieldConfig.minValue.toStringAsFixed(decimals);
                },
              );
              if (formFieldConfig.shouldValidate.value) {
                formFieldConfig.isValid;
              }
              widget.onChanged?.call(formFieldConfig.value);
            },
            child: Container(
              height: iconHeight,
              width: iconHeight,
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(width: 2, color: foregroundColor),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add_rounded, color: foregroundColor),
            ),
          ),
        ],
      ),
    );
  }
}
