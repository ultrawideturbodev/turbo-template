import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter/services.dart';

import '../forms/form_field_config.dart';
import 'animated_enabled.dart';
import 'form_field_error.dart';
import 'tu_checkbox.dart';

class FormFieldCheckbox extends StatefulWidget {
  const FormFieldCheckbox({
    super.key,
    required this.formFieldConfig,
    required this.label,
    this.color,
  });

  final FormFieldConfig<bool> formFieldConfig;
  final Widget label;
  final Color? color;

  @override
  State<FormFieldCheckbox> createState() => _FormFieldCheckboxState();
}

class _FormFieldCheckboxState extends State<FormFieldCheckbox> {
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
                child: TuCheckbox.check(
                  borderRadius: BorderRadius.circular(6),
                  initialValue: formFieldConfig.value ?? false,
                  onChanged: (value) {
                    formFieldConfig.value = value;
                    if (formFieldConfig.shouldValidate.value) {
                      formFieldConfig.isValid;
                    }
                  },
                ),
              ),
              Flexible(
                child: GestureDetector(
                  child: widget.label,
                  onTap: () {
                    formFieldConfig.value = !(formFieldConfig.value ?? false);
                    if (formFieldConfig.shouldValidate.value) {
                      formFieldConfig.isValid;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        FormFieldError(
          errorText: formFieldConfig.errorText,
          shouldValidate: formFieldConfig.shouldValidate,
          leftPadding: 0,
          topPadding: 12,
        ),
      ],
    );
  }
}
