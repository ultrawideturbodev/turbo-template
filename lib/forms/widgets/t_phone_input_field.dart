import 'package:flutter/material.dart' hide Theme;
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/widgets/t_form_field.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';

class TPhoneInputField extends StatefulWidget {
  const TPhoneInputField({
    required this.fieldConfig,
    super.key,
    this.hintText,
    this.label,
    this.onChanged,
    this.onFocusChanged,
    this.onTap,
    this.trailing,
    this.trailingLabel,
    this.subLabel,
    this.countries,
    this.searchPlaceholder,
  });

  final String? hintText;
  final String? label;
  final String? subLabel;
  final TFieldConfig<PhoneNumber> fieldConfig;
  final ValueChanged<PhoneNumber>? onChanged;
  final ValueChanged<bool>? onFocusChanged;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Widget? trailingLabel;
  final List<Country>? countries;
  final Widget? searchPlaceholder;

  @override
  State<TPhoneInputField> createState() => _TPhoneInputFieldState();
}

class _TPhoneInputFieldState extends State<TPhoneInputField> {
  @override
  void initState() {
    assert(widget.fieldConfig.fieldType.isPhoneInput);
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
      subLabel: widget.subLabel,
      trailingLabel: widget.trailingLabel,
      child: PhoneInput(
        initialValue: formFieldConfig.value,
        onChanged: isReadOnly ? null : (value) => _onChanged(formFieldConfig, value),
        countries: widget.countries,
        searchPlaceholder: widget.searchPlaceholder,
        filterPlusCode: true,
        filterZeroCode: true,
        filterCountryCode: true,
        onlyNumber: true,
      ),
    );
  }

  void _onChanged(TFieldConfig<PhoneNumber> formFieldConfig, PhoneNumber value) {
    formFieldConfig.silentUpdateValue(value);
    if (formFieldConfig.shouldValidate.value) {
      formFieldConfig.isValid;
    }
    widget.onChanged?.call(value);
  }
}
