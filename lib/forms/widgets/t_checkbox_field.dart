import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/animations/widgets/animated_enabled.dart';
import 'package:turbo_template/data/extensions/bool_extension.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/widgets/t_error_label.dart';
import 'package:turbo_template/state/extensions/checkbox_state_extension.dart';
import 'package:turbo_template/ui/widgets/t_button.dart';

class TCheckboxField extends StatefulWidget {
  const TCheckboxField({
    super.key,
    required this.formFieldConfig,
     this.trailing,
    this.leading,
  });

  final TFieldConfig<bool> formFieldConfig;
  final Widget? trailing;
  final Widget? leading;

  @override
  State<TCheckboxField> createState() => _TCheckboxFieldState();
}

class _TCheckboxFieldState extends State<TCheckboxField> {
  @override
  void initState() {
    widget.formFieldConfig.addListener(_rebuild);
    super.initState();
  }

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    widget.formFieldConfig.removeListener(_rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formFieldConfig = widget.formFieldConfig;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedEnabled(
          isEnabled: formFieldConfig.isEnabled,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              KeyboardListener(
                focusNode: formFieldConfig.focusNode,
                onKeyEvent: (value) {
                  if (value is KeyDownEvent && value.logicalKey == LogicalKeyboardKey.space) {
                    formFieldConfig.value = !(formFieldConfig.value ?? false);
                    if (formFieldConfig.shouldValidate.value) {
                      formFieldConfig.isValid;
                    }
                  }
                },
                child: Checkbox(
                  state: (formFieldConfig.value == true).checkboxState,
                  onChanged: (value) {
                    formFieldConfig.value = value.toBool;
                    if (formFieldConfig.shouldValidate.value) {
                      formFieldConfig.isValid;
                    }
                  },
                  leading: widget.leading,
                  trailing: widget.trailing,
                ),
              ),
            ],
          ),
        ),
        TErrorLabel(
          errorText: formFieldConfig.errorText,
          shouldValidate: formFieldConfig.shouldValidate,
          leftPadding: 0,
          topPadding: 12,
        ),
      ],
    );
  }
}
