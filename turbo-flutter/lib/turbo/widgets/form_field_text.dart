import 'package:gap/gap.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../constants/k_durations.dart';
import '../constants/k_sizes.dart';
import '../extensions/context_extension.dart';
import '../forms/form_field_config.dart';
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
    this.trailingLabel,
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
    final formFieldTextStyle = context.t.texts.formField;
    final formFieldLabelStyle = context.t.texts.formFieldLabel;
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
