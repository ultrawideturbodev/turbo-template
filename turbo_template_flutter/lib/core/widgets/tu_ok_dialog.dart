import 'package:feedback_response/feedback_response.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants/k_sizes.dart';
import '../extensions/context_extension.dart';
import '../extensions/num_extension.dart';
import 'tu_button.dart';
import 'turbo_card.dart';

class TuOkDialog<T> extends StatefulWidget {
  const TuOkDialog({
    required this.feedbackLevel,
    required this.message,
    required this.okButtonText,
    required this.title,
    super.key,
    this.content,
  }) : assert(
          (title != null && message != null) || content != null,
          'Either title and message or content must be provided',
        );

  final FeedbackLevel feedbackLevel;
  final String okButtonText;
  final String? message;
  final String? title;
  final WidgetBuilder? content;

  @override
  State<TuOkDialog<T>> createState() => _TuOkDialogState<T>();
}

class _TuOkDialogState<T> extends State<TuOkDialog<T>> {
  final focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = kSizesAppPadding * 1.5;
    return Center(
      child: TurboCard(
        padding: const EdgeInsets.all(kSizesAppPadding),
        margin: EdgeInsets.only(
          left: horizontalPadding,
          right: horizontalPadding,
          bottom: (context.tSizes.bottomSafeAreaWithMinimum + horizontalPadding)
              .minimum(horizontalPadding),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.content != null)
              widget.content!.call(context)
            else ...[
              const Gap(horizontalPadding),
              Row(
                children: [
                  const Icon(Icons.info_outline_rounded),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      widget.title!,
                      style: context.tTexts.dialogHeader,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const Gap(16),
              Text(widget.message!, style: context.tTexts.primaryText),
              const Gap(16),
            ],
            Wrap(
              alignment: WrapAlignment.end,
              children: [
                TurboButton.primary(
                  text: widget.okButtonText,
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
