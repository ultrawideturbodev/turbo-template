import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/extensions/string_extension.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/widgets/t_form_field.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';

class LeadingIcon extends StatelessWidget {
  final IconData? icon;
  final bool focused;
  final BuildContext context;

  const LeadingIcon({
    super.key,
    required this.icon,
    required this.focused,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    if (icon == null) return const SizedBox.shrink();
    return Icon(
      icon,
      color: focused ? null : context.colors.input,
    );
  }
}

class TTextInputField extends StatefulWidget {
  const TTextInputField({
    required this.fieldConfig,
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
    this.subLabel,
  });

  final CrossAxisAlignment crossAxisAlignment;
  final IconData? leadingIcon;
  final String? hintText;
  final String? label;
  final String? subLabel;
  final TFieldConfig<String> fieldConfig;
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
  List<String> _currentSuggestions = [];

  @override
  void initState() {
    assert(widget.fieldConfig.fieldType.isTextInput);
    widget.fieldConfig.addListener(_rebuild);
    if (widget.onFocusChanged != null) {
      widget.fieldConfig.focusNode.addListener(_onFocusChanged);
    }
    super.initState();
  }

  void _onFocusChanged() => widget.onFocusChanged?.call(widget.fieldConfig.focusNode.hasFocus);

  void _rebuild() => setState(() {});

  void _updateSuggestions(String value) {
    final autoCompleteValues = widget.fieldConfig.autoCompleteValues;
    if (value.isEmpty || autoCompleteValues == null) {
      if (_currentSuggestions.isEmpty) return;
      setState(() {
        _currentSuggestions = [];
      });
      return;
    }
    setState(() {
      _currentSuggestions =
          autoCompleteValues.where((element) => element.naked.contains(value.naked)).toList();
    });
  }

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
            child: Column(
              children: [
                if (formFieldConfig.autoCompleteValues != null)
                  AutoComplete(
                    controller: formFieldConfig.textEditingController,
                    suggestions: _currentSuggestions,
                    onChanged: (value) {
                      _onChanged(formFieldConfig, value);
                      _updateSuggestions(value);
                    },
                    leading: widget.leading ??
                        (widget.leadingIcon == null
                            ? null
                            : StatedWidget.builder(
                                builder: (context, states) => Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: LeadingIcon(
                                    icon: widget.leadingIcon,
                                    focused: states.focused,
                                    context: context,
                                  ),
                                ),
                              )),
                    trailing: widget.trailing,
                    hintText: hintText,
                    keyboardType: widget.keyboardType,
                    onTap: widget.onTap,
                    readOnly: isReadOnly,
                    focusNode: formFieldConfig.focusNode,
                    obscureText: formFieldConfig.obscureText,
                    style: formFieldTextStyle,
                    onSubmitted: widget.onSubmitted,
                    onAcceptSuggestion: (value) {
                      final suggestion = _currentSuggestions[value];
                      formFieldConfig.textEditingController.text = suggestion;
                      formFieldConfig.silentUpdateValue(suggestion);
                      setState(() {
                        _currentSuggestions = [];
                      });
                    },
                  )
                else
                  TextField(
                    leading: widget.leading ??
                        (widget.leadingIcon == null
                            ? null
                            : StatedWidget.builder(
                                builder: (context, states) => Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: LeadingIcon(
                                    icon: widget.leadingIcon,
                                    focused: states.focused,
                                    context: context,
                                  ),
                                ),
                              )),
                    trailing: widget.trailing,
                    hintText: hintText,
                    keyboardType: widget.keyboardType,
                    onTap: widget.onTap,
                    controller: formFieldConfig.textEditingController,
                    onChanged: (value) => _onChanged(formFieldConfig, value),
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

  void _onChanged(TFieldConfig<String> formFieldConfig, String value) {
    formFieldConfig.silentUpdateValue(value);
    if (formFieldConfig.shouldValidate.value) {
      formFieldConfig.isValid;
    }
    widget.onChanged?.call(value);
  }
}
