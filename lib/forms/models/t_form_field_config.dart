import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';

class TFormFieldEssentials<T> {
  final TFieldConfig<T> formFieldConfig;
  final String label;
  final String? subLabel;
  final Widget? trailingLabel;
  final String? hintText;
  final String? label;
  final String? subLabel;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<bool>? onFocusChanged;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;
  final Widget? trailingLabel;
}
