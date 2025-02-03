import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';
import 'package:turbo_template/turbo/widgets/leading_icon.dart';
import 'package:turbo_template/turbo/widgets/trailing_icon.dart';

class TurboButton extends StatelessWidget {
  const TurboButton({
    Key? key,
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
        focusNode: focusNode,
      );

  final String text;
  final VoidCallback onPressed;
  final LeadingIcon Function(Color backgroundColor, Color textColor)? leadingIcon;
  final TrailingIcon Function(Color backgroundColor, Color textColor)? trailingIcon;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    const buttonHeight = kSizesButtonHeight;
    final borderRadius = BorderRadius.circular(context.t.config.buttonBorderRadius);
    return ShadButton(
      child: const Text('wtf'),
      onPressed: onPressed,
    );
  }
}
