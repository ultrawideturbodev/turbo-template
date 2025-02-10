import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/animations/widgets/animated_enabled.dart';
import 'package:turbo_template/data/constants/k_durations.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/widgets/t_error_label.dart';

class TChipInputField extends StatefulWidget {
  const TChipInputField({
    super.key,
    required this.formFieldConfig,
    this.label,
    this.hintText,
  });

  final TFieldConfig<String> formFieldConfig;
  final String? label;
  final String? hintText;

  @override
  State<TChipInputField> createState() => _TChipInputFieldState();
}

class _TChipInputFieldState extends State<TChipInputField> {
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
    final isReadOnly = formFieldConfig.isReadOnly;
    final isEnabled = formFieldConfig.isEnabled;
    return AnimatedOpacity(
      duration: kDurationsAnimation,
      opacity: isEnabled ? 1 : kSizesOpacityDisabled,
      child: IgnorePointer(
        ignoring: !isEnabled || isReadOnly,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TODO: Implement chip input widget
            TErrorLabel(
              errorText: formFieldConfig.errorText,
              shouldValidate: formFieldConfig.shouldValidate,
              leftPadding: 0,
              topPadding: 12,
            ),
          ],
        ),
      ),
    );
  }
}
