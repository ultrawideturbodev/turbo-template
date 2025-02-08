import 'package:gap/gap.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:{{packageName.snakeCase()}}/data/constants/k_durations.dart';
import 'package:{{packageName.snakeCase()}}/data/constants/k_sizes.dart';
import 'package:{{packageName.snakeCase()}}/state/extensions/context_extension.dart';
import 'package:{{packageName.snakeCase()}}/forms/config/form_field_config.dart';
import 'package:{{packageName.snakeCase()}}/forms/widgets/form_field_error.dart';

class FormFieldText extends StatefulWidget {
  const FormFieldText({
    required this.formFieldConfig,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.hintText,
    this.keyboardType,
    this.label,
    this.leading,
    this.leadingIcon,
    this.onChanged,
    this.onFocusChanged,
    this.onSubmitted,
    this.onTap,
    this.trailing,
    this.trailingLabel,
    super.key,
  });

  final CrossAxisAlignment crossAxisAlignment;
  final FormFieldConfig<String> formFieldConfig;
  final IconData? leadingIcon;
  final String? hintText;
  final String? label;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<bool>? onFocusChanged;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;
  final Widget? trailingLabel;

  @override
  State<FormFieldText> createState() => _FormFieldTextState();
}

class _FormFieldTextState extends State<FormFieldText> {
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
    final formFieldLabelStyle = context.texts.formFieldLabel;
    final isDisabled = formFieldConfig.isReadOnly || !formFieldConfig.isEnabled;
    final label = widget.label;
    final hintText = widget.hintText;
    return AnimatedOpacity(
      duration: kDurationsAnimation,
      opacity: formFieldConfig.isEnabled ? 1 : kSizesOpacityDisabled,
      child: IgnorePointer(
        ignoring: isDisabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (label != null) ...[
              Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: formFieldLabelStyle,
                    ),
                  ),
                  if (widget.trailingLabel != null) ...[
                    const Gap(8),
                    widget.trailingLabel!,
                    const Gap(8),
                  ],
                ],
              ),
              const Gap(8),
            ],
            Row(
              crossAxisAlignment: widget.crossAxisAlignment,
              children: [
                if (widget.leading != null) widget.leading!,
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        leading: widget.leading ??
                            StatedWidget.builder(
                              builder: (context, states) {
                                if (states.focused) {
                                  return Icon(widget.leadingIcon);
                                } else {
                                  return Icon(widget.leadingIcon, color: context.colors.input);
                                }
                              },
                            ),
                        trailing: widget.trailing,
                        hintText: hintText,
                        keyboardType: widget.keyboardType,
                        onTap: widget.onTap,
                        controller: formFieldConfig.textEditingController,
                        onChanged: (value) {
                          formFieldConfig.silentUpdateValue(value);
                          if (formFieldConfig.shouldValidate.value) {
                            formFieldConfig.isValid;
                          }
                          widget.onChanged?.call(value);
                        },
                        readOnly: formFieldConfig.isReadOnly,
                        focusNode: formFieldConfig.focusNode,
                        inputFormatters: formFieldConfig.inputFormatters,
                        obscureText: formFieldConfig.obscureText,
                        style: formFieldTextStyle,
                        onSubmitted: widget.onSubmitted,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            FormFieldError(
              errorText: formFieldConfig.errorText,
              shouldValidate: formFieldConfig.shouldValidate,
            ),
          ],
        ),
      ),
    );
  }
}
