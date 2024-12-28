import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants/k_durations.dart';
import '../constants/k_sizes.dart';
import '../extensions/context_extension.dart';
import '../forms/form_field_config.dart';
import 'fading_focus_icon.dart';
import 'form_field_error.dart';

class FormFieldText extends StatefulWidget {
  const FormFieldText({
    required this.formFieldConfig,
    this.hintText,
    this.label,
    this.leading,
    this.trailing,
    this.onSubmitted,
    this.fadingFocusIcon,
    this.onTap,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.onChanged,
    this.keyboardType,
    this.onFocusChanged,
    super.key,
  });

  final FormFieldConfig<String> formFieldConfig;
  final String? hintText;
  final String? label;
  final Widget? leading;
  final Widget? trailing;
  final ValueChanged<String>? onSubmitted;
  final IconData? fadingFocusIcon;
  final VoidCallback? onTap;
  final CrossAxisAlignment crossAxisAlignment;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onFocusChanged;
  final TextInputType? keyboardType;

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
    final iconColor = context.colors.formFieldText;
    final cursorColor = context.colors.formFieldText;
    final formFieldLabelStyle = context.texts.formFieldLabel;
    final isDisabled = formFieldConfig.isReadOnly || !formFieldConfig.isEnabled;
    final backgroundColor = switch (isDisabled) {
      false => context.colors.activeFormFieldBackground,
      true => context.colors.inactiveFormFieldBackground,
    };
    final label = widget.label;
    final borderRadius = context.sizes.formFieldBorderRadius;
    final borderColor = context.colors.formFieldBorder;
    const minVerticalPadding = kSizesFormFieldHeight / 2;
    const leftPadding = 12.0;
    final hasIcon = widget.fadingFocusIcon != null;
    return AnimatedOpacity(
      duration: kDurationsAnimation,
      opacity: formFieldConfig.isEnabled ? 1 : kSizesOpacityDisabled,
      child: IgnorePointer(
        ignoring: isDisabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (label != null) ...[
              Text(
                label,
                style: formFieldLabelStyle,
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
                        keyboardType: widget.keyboardType,
                        onTap: widget.onTap,
                        decoration: InputDecoration(
                          isDense: true,
                          fillColor: backgroundColor,
                          hintText: widget.hintText,
                          hintStyle: context.texts.secondaryHint,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                            borderSide: BorderSide(
                              width: 1,
                              color: borderColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                            borderSide: BorderSide(
                              color: context.colors.activeFormFieldBorder,
                              style: BorderStyle.solid,
                              strokeAlign: BorderSide.strokeAlignCenter,
                            ),
                          ),
                          prefixIcon: hasIcon
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    left: leftPadding,
                                    right: 7,
                                  ),
                                  child: FadingFocusIcon(
                                    color: iconColor,
                                    icon: widget.fadingFocusIcon!,
                                    focusNode: formFieldConfig.focusNode,
                                  ),
                                )
                              : null,
                          contentPadding: EdgeInsets.only(
                            top: minVerticalPadding - 11,
                            bottom: minVerticalPadding - 11,
                            left: hasIcon ? 0 : leftPadding,
                            right: 0,
                          ),
                          prefixIconConstraints: const BoxConstraints(),
                        ),
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
                        cursorColor: cursorColor,
                        cursorWidth: 1.5,
                        cursorHeight: 16,
                        cursorRadius: const Radius.circular(2),
                        style: formFieldTextStyle,
                        onSubmitted: widget.onSubmitted,
                      ),
                    ],
                  ),
                ),
                if (widget.trailing != null) widget.trailing!,
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
