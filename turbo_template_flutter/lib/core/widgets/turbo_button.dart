import 'package:flutter/widgets.dart';

import '../constants/k_sizes.dart';
import '../extensions/context_extension.dart';
import 'hover_builder.dart';
import 'leading_icon.dart';
import 'opacity_button.dart';
import 'trailing_icon.dart';

class TurboButton extends StatelessWidget {
  const TurboButton._({
    Key? key,
    required this.text,
    required this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    required this.buttonType,
    this.focusNode,
  }) : super(key: key);

  factory TurboButton.primary({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    LeadingIcon? leadingIcon,
    TrailingIcon? trailingIcon,
    FocusNode? focusNode,
  }) =>
      TurboButton._(
        key: key,
        text: text,
        onPressed: onPressed,
        leadingIcon: leadingIcon,
        trailingIcon: trailingIcon,
        buttonType: _ButtonType.primary,
        focusNode: focusNode,
      );

  factory TurboButton.secondary({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    LeadingIcon? leadingIcon,
    TrailingIcon? trailingIcon,
    FocusNode? focusNode,
  }) =>
      TurboButton._(
        key: key,
        text: text,
        onPressed: onPressed,
        leadingIcon: leadingIcon,
        trailingIcon: trailingIcon,
        buttonType: _ButtonType.secondary,
        focusNode: focusNode,
      );

  final String text;
  final VoidCallback onPressed;
  final LeadingIcon? leadingIcon;
  final TrailingIcon? trailingIcon;
  final _ButtonType buttonType;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    const buttonHeight = kSizesButtonHeight;
    final borderRadius = BorderRadius.circular(context.sizes.buttonBorderRadius);
    switch (buttonType) {
      case _ButtonType.primary:
        return OpacityButton(
          onPressed: onPressed,
          focusNode: focusNode,
          child: Container(
            height: buttonHeight,
            decoration: BoxDecoration(
              color: context.colors.primaryButtonBackground,
              borderRadius: borderRadius,
            ),
            padding: const EdgeInsets.symmetric(horizontal: kSizesHorizontalButtonPadding),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leadingIcon != null) leadingIcon!,
                Text(
                  text,
                  style: context.texts.primaryButton,
                ),
                if (trailingIcon != null) trailingIcon!,
              ],
            ),
          ),
        );
      case _ButtonType.secondary:
        return OpacityButton(
          onPressed: onPressed,
          focusNode: focusNode,
          child: HoverBuilder(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leadingIcon != null) leadingIcon!,
                Text(
                  text,
                  style: context.texts.secondaryButton,
                ),
                if (trailingIcon != null) trailingIcon!,
              ],
            ),
            builder: (context, isHovered, child) => Container(
              height: buttonHeight,
              decoration: BoxDecoration(
                color: switch (isHovered) {
                  false => context.colors.secondaryButtonBackground,
                  true => context.colors.secondaryButtonHover,
                },
                borderRadius: borderRadius,
              ),
              padding: const EdgeInsets.symmetric(horizontal: kSizesHorizontalButtonPadding),
              child: child,
            ),
          ),
        );
    }
  }
}

enum _ButtonType { primary, secondary }
