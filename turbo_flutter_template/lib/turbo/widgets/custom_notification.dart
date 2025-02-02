import 'package:auto_size_text/auto_size_text.dart';
import 'package:feedback_response/feedback_response.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants/k_sizes.dart';
import '../extensions/context_extension.dart';

class CustomNotification extends StatelessWidget {
  const CustomNotification({
    Key? key,
    required this.feedbackLevel,
    required this.title,
    this.maxLines = 4,
    this.message,
    this.showIcon = true,
  }) : super(key: key);

  final FeedbackLevel feedbackLevel;
  final String title;
  final int maxLines;
  final String? message;
  final bool showIcon;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: kSizesAppPadding),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(
              color: context.t.colors.dialogBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.t.colors.border, width: 1),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Ensure the container wraps to the content
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showIcon) const Text('Icon'),
                    const Gap(12),
                    Flexible(
                      child: AutoSizeText(
                        title,
                        maxLines: maxLines,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (message?.isNotEmpty == true) ...[
                  const Gap(8),
                  Flexible(
                    child: Text(
                      message!,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
}
