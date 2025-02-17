import 'package:informers/informer.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/animations/widgets/shrinks.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/widgets/t_text_input_field.dart';
import 'package:turbo_template/localizations/globals/g_strings.dart';
import 'package:turbo_template/ui/widgets/opacity_button.dart';
import 'package:turbo_template/ui/widgets/t_trailing.dart';

class TSearchField extends StatefulWidget {
  const TSearchField({
    super.key,
    required this.fieldConfig,
    this.onChanged,
    this.hintText,
    this.onFocusChanged,
    this.onSubmitted,
    this.showCloseButton,
    this.onCloseSearchPressed,
    this.label,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.leadingIcon = Icons.search,
    this.keyboardType,
    this.onTap,
    this.leading,
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

  final VoidCallback? onCloseSearchPressed;
  final bool? showCloseButton;

  @override
  State<TSearchField> createState() => _TSearchFieldState();
}

class _TSearchFieldState extends State<TSearchField> {
  final _showCloseButton = Informer<bool>(false);

  @override
  Widget build(BuildContext context) => TTrailing.horizontal(
        spacing: 0,
        trailing: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ValueListenableBuilder<bool>(
            valueListenable: _showCloseButton,
            builder: (context, showCloseButton, child) => HorizontalShrink(
              alignment: Alignment.centerRight,
              show: widget.showCloseButton ?? showCloseButton,
              child: OpacityButton(
                hitTestBehavior: HitTestBehavior.translucent,
                child: Container(
                  child: const Icon(Icons.close_rounded),
                  height: kSizesButtonHeight,
                  width: kSizesButtonHeight,
                ),
                onPressed: () {
                  if (widget.onCloseSearchPressed != null &&
                      (widget.fieldConfig.value?.isEmpty ?? true)) {
                    widget.onCloseSearchPressed!();
                    return;
                  }
                  widget.fieldConfig.silentReset();
                  widget.onChanged?.call('');
                  _showCloseButton.update(false);
                },
              ),
            ),
          ),
        ),
        child: Expanded(
          child: TTextInputField(
            fieldConfig: widget.fieldConfig,
            label: widget.label,
            subLabel: widget.subLabel,
            onTap: widget.onTap,
            leading: widget.leading,
            keyboardType: widget.keyboardType,
            trailingLabel: widget.trailingLabel,
            crossAxisAlignment: widget.crossAxisAlignment,
            leadingIcon: widget.leadingIcon,
            onChanged: (value) {
              _showCloseButton.update(value.isNotEmpty);
              widget.onChanged?.call(value);
            },
            onSubmitted: widget.onSubmitted,
            trailing: widget.trailing,
            hintText: widget.hintText ?? gStrings.search,
            onFocusChanged: widget.onFocusChanged,
          ),
        ),
      );
}
