import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_durations.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/widgets/t_error_label.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';

class TTextInputField extends StatefulWidget {
  const TTextInputField({
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
  final TFieldConfig<String> formFieldConfig;
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
  State<TTextInputField> createState() => _TTextInputFieldState();
}

class _TTextInputFieldState extends State<TTextInputField> {

  @override
  void initState() {
    assert(widget.formFieldConfig.fieldType.isTextInput);
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
            TErrorLabel(
              errorText: formFieldConfig.errorText,
              shouldValidate: formFieldConfig.shouldValidate,
            ),
          ],
        ),
      ),
    );
  }
}
