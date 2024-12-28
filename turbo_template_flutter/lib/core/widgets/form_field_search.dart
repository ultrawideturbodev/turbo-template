import 'package:flutter/material.dart';
import 'package:informers/informer.dart';
import '../constants/k_sizes.dart';
import '../forms/form_field_config.dart';
import '../globals/g_strings.dart';
import 'form_field_text.dart';
import 'opacity_button.dart';
import 'shrinks.dart';

class FormFieldSearch extends StatefulWidget {
  const FormFieldSearch({
    super.key,
    required this.formFieldConfig,
    this.onChanged,
    this.hintText,
    this.onFocusChanged,
    this.onSubmitted,
    this.showCloseButton,
    this.onCloseSearchPressed,
  });

  final FormFieldConfig<String> formFieldConfig;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final ValueChanged<bool>? onFocusChanged;
  final ValueChanged<String>? onSubmitted;
  final bool? showCloseButton;
  final VoidCallback? onCloseSearchPressed;

  @override
  State<FormFieldSearch> createState() => _FormFieldSearchState();
}

class _FormFieldSearchState extends State<FormFieldSearch> {
  final _showCloseButton = Informer<bool>(false);

  @override
  Widget build(BuildContext context) => FormFieldText(
        formFieldConfig: widget.formFieldConfig,
        crossAxisAlignment: CrossAxisAlignment.center,
        fadingFocusIcon: Icons.search_rounded,
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
                    (widget.formFieldConfig.value?.isEmpty ?? true)) {
                  widget.onCloseSearchPressed!();
                  return;
                }
                widget.formFieldConfig.silentReset();
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
