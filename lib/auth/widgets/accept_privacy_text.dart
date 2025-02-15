import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/localizations/globals/g_strings.dart';
import 'package:turbo_template/typography/extensions/text_style_extension.dart';

class AcceptPrivacyText extends StatelessWidget {
  const AcceptPrivacyText({
    required this.onPrivacyPolicyTap,
    required this.onTermsOfServiceTap,
    super.key,
  });

  final VoidCallback onPrivacyPolicyTap;
  final VoidCallback onTermsOfServiceTap;

  @override
  Widget build(BuildContext context) {
    final textStyle = context.texts.acceptPrivacy;
    return Text.rich(
      TextSpan(
        style: textStyle,
        children: [
          const TextSpan(text: 'I agree to the'),
          const TextSpan(text: ' '),
          TextSpan(
            text: 'Privacy Policy',
            style: textStyle.bold,
            recognizer: TapGestureRecognizer()..onTap = onPrivacyPolicyTap,
          ),
          const TextSpan(text: ' '),
          TextSpan(text: gStrings.and),
          const TextSpan(text: ' '),
          TextSpan(
            text: 'Terms of Service',
            style: textStyle.bold,
            recognizer: TapGestureRecognizer()..onTap = onTermsOfServiceTap,
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
