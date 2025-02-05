import 'package:auto_size_text/auto_size_text.dart';
import 'package:feedback_response/feedback_response.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:gap/gap.dart';

import '../constants/k_sizes.dart';
import '../extensions/context_extension.dart';
import '../typedefs/context_def.dart';
import 'custom_back_button.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    this.feedbackLevel,
    this.title,
    this.message,
    this.content,
    this.onPressed,
    this.buttonText,
    this.trailing,
    this.onLeftPressed,
    this.onRightPressed,
    this.backButtonPadding = 0,
    this.leading,
    super.key,
  });

  final FeedbackLevel? feedbackLevel;
  final String? title;
  final String? message;
  final Widget? content;
  final ContextDef? onPressed;
  final ContextDef? onLeftPressed;
  final ContextDef? onRightPressed;
  final String? buttonText;
  final WidgetBuilder? trailing;
  final double backButtonPadding;
  final Widget Function(BuildContext context)? leading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: kSizesAppPadding,
          bottom: kSizesAppPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomBackButton(
                    onPressed: () => context.popNavigator(),
                  ),
                  Gap(16 + backButtonPadding),
                  if (leading != null) leading!.call(context),
                  Expanded(
                    child: AutoSizeText(
                      title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (trailing != null) trailing!(context) else const Gap(24),
                ],
              ),
            ],
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                textAlign: TextAlign.center,
              ),
            ],
            if (content != null) ...[
              const SizedBox(height: kSizesAppPadding),
              content!,
            ],
            if (onPressed != null) ...[
              const SizedBox(height: kSizesAppPadding),
              SafeArea(
                child: Builder(
                  builder: (context) {
                    const customButton = Text('button');
                    if (onLeftPressed != null || onRightPressed != null) {
                      return Row(
                        children: [
                          if (onLeftPressed != null)
                            Padding(
                              padding: EdgeInsets.only(right: 16 + backButtonPadding),
                              child: const Text('left button'),
                            ),
                          const Expanded(child: customButton),
                          if (onRightPressed != null)
                            const Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text('right button'),
                            ),
                        ],
                      );
                    }
                    return customButton;
                  },
                ),
              ),
            ] else
              SizedBox(height: context.sizes.bottomSafeAreaWithMinimum),
          ],
        ),
      );
}
