import 'package:feedback_response/feedback_response.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants/k_sizes.dart';
import '../extensions/context_extension.dart';
import '../extensions/num_extension.dart';
import 'tu_button.dart';
import 'tu_card.dart';

class TuOkCancelDialog<T> extends StatefulWidget {
  const TuOkCancelDialog({
    required this.cancelButtonText,
    required this.feedbackLevel,
    required this.message,
    required this.okButtonText,
    required this.title,
    required this.okButtonType,
    required this.cancelButtonType,
    super.key,
    this.content,
  }) : assert(
          (title != null && message != null) || content != null,
          'Either title and message or content must be provided',
        );

  final FeedbackLevel feedbackLevel;
  final String cancelButtonText;
  final String okButtonText;
  final String? message;
  final String? title;
  final WidgetBuilder? content;
  final TuButtonType okButtonType;
  final TuButtonType cancelButtonType;

  @override
  State<TuOkCancelDialog<T>> createState() => _TuOkCancelDialogState<T>();
}

class _TuOkCancelDialogState<T> extends State<TuOkCancelDialog<T>> {
  final focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const horizontalMargin = kSizesAppPadding * 1.5;
    return Center(
      child: TuCard(
        margin: EdgeInsets.only(
          left: horizontalMargin,
          right: horizontalMargin,
          bottom: (context.sizes.bottomSafeAreaWithMinimum + horizontalMargin)
              .minimum(horizontalMargin),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.content != null)
              widget.content!.call(context)
            else ...[
              Row(
                children: [
                  const Icon(Icons.info_outline_rounded),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      widget.title!,
                      style: context.texts.dialogHeader,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const Gap(kSizesAppPadding / 2),
              Text(widget.message!, style: context.texts.primaryText),
              const Gap(kSizesAppPadding / 1.5),
            ],
            Row(
              children: [
                Expanded(
                  child: TuButton(
                    buttonType: widget.cancelButtonType,
                    onPressed: () => Navigator.of(context).pop(false),
                    text: widget.cancelButtonText,
                  ),
                ),
                const Gap(kSizesAppPadding / 2),
                Expanded(
                  child: TuButton(
                    buttonType: widget.okButtonType,
                    onPressed: () => Navigator.of(context).pop(true),
                    text: widget.okButtonText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
