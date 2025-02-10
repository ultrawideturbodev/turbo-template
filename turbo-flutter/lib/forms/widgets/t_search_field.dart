import 'package:informers/informer.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../animations/widgets/shrinks.dart';
import '../../data/constants/k_sizes.dart';
import '../../localizations/globals/g_strings.dart';
import '../../ui/widgets/opacity_button.dart';
import '../config/t_field_config.dart';
import 't_text_input_field.dart';

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
  });

  final TFieldConfig<String> fieldConfig;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final ValueChanged<bool>? onFocusChanged;
  final ValueChanged<String>? onSubmitted;
  final bool? showCloseButton;
  final VoidCallback? onCloseSearchPressed;

  @override
  State<TSearchField> createState() => _TSearchFieldState();
}

class _TSearchFieldState extends State<TSearchField> {
  final _showCloseButton = Informer<bool>(false);

  @override
  Widget build(BuildContext context) => TTextInputField(
        formFieldConfig: widget.fieldConfig,
        crossAxisAlignment: CrossAxisAlignment.center,
        leadingIcon: Icons.search_rounded,
        onChanged: (value) {
          _showCloseButton.update(value.isNotEmpty);
          widget.onChanged?.call(value);
        },
        onSubmitted: widget.onSubmitted,
        trailing: ValueListenableBuilder<bool>(
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
        hintText: widget.hintText ?? gStrings.search,
        onFocusChanged: widget.onFocusChanged,
      );
}
