import 'package:flutter/widgets.dart';

import '../constants/k_sizes.dart';
import '../extensions/context_extension.dart';
import 'hover_builder.dart';
import 'leading_icon.dart';
import 'opacity_button.dart';
import 'trailing_icon.dart';

enum TuButtonType {
  primary,
  secondary,
  ;

  static const okButtonDefault = TuButtonType.primary;
  static const cancelButtonDefault = TuButtonType.secondary;
}

class TurboButton extends StatelessWidget {
  const TurboButton({
    Key? key,
    required this.buttonType,
    required this.onPressed,
    required this.text,
    this.focusNode,
    this.leadingIcon,
    this.trailingIcon,
  }) : super(key: key);

  factory TurboButton.primary({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    LeadingIcon Function(Color backgroundColor, Color textColor)? leadingIcon,
    TrailingIcon Function(Color backgroundColor, Color textColor)? trailingIcon,
    FocusNode? focusNode,
  }) =>
      TurboButton(
        key: key,
        text: text,
        onPressed: onPressed,
        leadingIcon: leadingIcon,
        trailingIcon: trailingIcon,
        buttonType: TuButtonType.primary,
        focusNode: focusNode,
      );

  factory TurboButton.secondary({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    LeadingIcon Function(Color backgroundColor, Color textColor)? leadingIcon,
    TrailingIcon Function(Color backgroundColor, Color textColor)? trailingIcon,
    FocusNode? focusNode,
  }) =>
      TurboButton(
        key: key,
        text: text,
        onPressed: onPressed,
        leadingIcon: leadingIcon,
        trailingIcon: trailingIcon,
        buttonType: TuButtonType.secondary,
        focusNode: focusNode,
      );

  final String text;
  final VoidCallback onPressed;
  final LeadingIcon Function(Color backgroundColor, Color textColor)? leadingIcon;
  final TrailingIcon Function(Color backgroundColor, Color textColor)? trailingIcon;
  final TuButtonType buttonType;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    const buttonHeight = kSizesButtonHeight;
    final borderRadius = BorderRadius.circular(context.tSizes.buttonBorderRadius);
    switch (buttonType) {
      case TuButtonType.primary:
        final backgroundColor = context.tColors.primaryButtonBackground;
        final textColor = context.tColors.primaryButtonText;
        return OpacityButton(
          onPressed: onPressed,
          focusNode: focusNode,
          child: Container(
            height: buttonHeight,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius,
            ),
            padding: const EdgeInsets.symmetric(horizontal: kSizesHorizontalButtonPadding),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leadingIcon != null) leadingIcon!(backgroundColor, textColor),
                Text(
                  text,
                  style: context.tTexts.primaryButton,
                ),
                if (trailingIcon != null) trailingIcon!(backgroundColor, textColor),
              ],
            ),
          ),
        );
      case TuButtonType.secondary:
        final backgroundColor = context.tColors.secondaryButtonBackground;
        final textColor = context.tColors.secondaryButtonText;
        return OpacityButton(
          onPressed: onPressed,
          focusNode: focusNode,
          child: HoverBuilder(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leadingIcon != null) leadingIcon!(backgroundColor, textColor),
                Text(
                  text,
                  style: context.tTexts.secondaryButton,
                ),
                if (trailingIcon != null) trailingIcon!(backgroundColor, textColor),
              ],
            ),
            builder: (context, isHovered, child) => Container(
              height: buttonHeight,
              decoration: BoxDecoration(
                color: switch (isHovered) {
                  false => backgroundColor,
                  true => context.tColors.secondaryButtonHover,
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
