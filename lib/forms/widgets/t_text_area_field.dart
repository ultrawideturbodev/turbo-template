import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/widgets/t_form_field.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';

class TTextAreaField extends StatefulWidget {
  const TTextAreaField({
    required this.fieldConfig,
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.hintText,
    this.label,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.onFocusChanged,
    this.onSubmitted,
    this.onTap,
    this.trailing,
    this.trailingLabel,
  });

  final CrossAxisAlignment crossAxisAlignment;
  final String? hintText;
  final String? label;
  final TFieldConfig<String> fieldConfig;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<bool>? onFocusChanged;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Widget? trailingLabel;

  @override
  State<TTextAreaField> createState() => _TTextAreaFieldState();
}

class _TTextAreaFieldState extends State<TTextAreaField> {
  @override
  void initState() {
    assert(widget.fieldConfig.fieldType.isTextArea);
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
      trailingLabel: widget.trailingLabel,
      child: Row(
        crossAxisAlignment: widget.crossAxisAlignment,
        children: [
          Expanded(
            child: TextField(
              maxLines: widget.maxLines,
              minLines: widget.minLines ?? 3,
              keyboardType: TextInputType.multiline,
              trailing: widget.trailing,
              hintText: hintText,
              onTap: widget.onTap,
              controller: formFieldConfig.textEditingController,
              onChanged: (value) => _onChanged(formFieldConfig, value),
              readOnly: isReadOnly,
              focusNode: formFieldConfig.focusNode,
              inputFormatters: formFieldConfig.inputFormatters,
              style: formFieldTextStyle,
              onSubmitted: widget.onSubmitted,
            ),
          ),
        ],
      ),
    );
  }

  void _onChanged(TFieldConfig<String> formFieldConfig, String value) {
    formFieldConfig.silentUpdateValue(value);
    if (formFieldConfig.shouldValidate.value) {
      formFieldConfig.isValid;
    }
    widget.onChanged?.call(value);
  }
}
