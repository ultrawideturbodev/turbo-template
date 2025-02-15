import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_durations.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/widgets/t_error_label.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';

class TFormField extends StatelessWidget {
  const TFormField({
    super.key,
    required this.formFieldConfig,
    required this.child,
    this.label,
    this.subLabel,
    this.trailingLabel,
  });

  final TFieldConfig formFieldConfig;
  final Widget child;
  final String? label;
  final String? subLabel;
  final Widget? trailingLabel;

  @override
  Widget build(BuildContext context) {
    final isReadOnly = formFieldConfig.isReadOnly;
    final isEnabled = formFieldConfig.isEnabled;
    final formFieldLabelStyle = context.texts.formFieldLabel;
    final formFieldSubLabelStyle = context.texts.formFieldSubLabel;

    return AnimatedOpacity(
      duration: kDurationsAnimation,
      opacity: isEnabled ? 1 : kSizesOpacityDisabled,
      child: IgnorePointer(
        ignoring: !isEnabled || isReadOnly,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (label != null || subLabel != null || trailingLabel != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (label != null)
                          Text(
                            label!,
                            style: formFieldLabelStyle,
                          ),
                        if (subLabel != null) ...[
                          const Gap(4),
                          Text(
                            subLabel!,
                            style: formFieldSubLabelStyle,
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (trailingLabel != null) ...[
                    const Gap(8),
                    trailingLabel!,
                    const Gap(8),
                  ],
                ],
              ),
              const Gap(8),
            ],
            child,
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
