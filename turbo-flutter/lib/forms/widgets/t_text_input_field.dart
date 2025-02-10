import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/widgets/t_form_field.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';

class TTextInputField extends StatefulWidget {
  const TTextInputField({
    required this.formFieldConfig,
    super.key,
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
  });

  final CrossAxisAlignment crossAxisAlignment;
  final IconData? leadingIcon;
  final String? hintText;
  final String? label;
  final TFieldConfig<String> formFieldConfig;
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
    final hintText = widget.hintText;
    final isReadOnly = formFieldConfig.isReadOnly;

    return TFormField(
      formFieldConfig: formFieldConfig,
      label: widget.label,
      trailingLabel: widget.trailingLabel,
      child: Row(
        crossAxisAlignment: widget.crossAxisAlignment,
        children: [
          Expanded(
            child: Column(
              children: [
                TextField(
                  leading: widget.leading ??
                      switch (widget.leadingIcon != null) {
                        true => StatedWidget.builder(
                            builder: (context, states) {
                              if (states.focused) {
                                return Icon(widget.leadingIcon);
                              } else {
                                return Icon(widget.leadingIcon, color: context.colors.input);
                              }
                            },
                          ),
                        false => null,
                      },
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
                  readOnly: isReadOnly,
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
    );
  }
}
