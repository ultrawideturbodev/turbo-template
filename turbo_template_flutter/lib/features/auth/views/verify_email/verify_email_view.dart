import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turbo_template/core/widgets/gap.dart';
import 'package:veto/data/models/base_view_model.dart';

import '../../../../core/constants/k_sizes.dart';
import '../../../../core/constants/k_svgs.dart';
import '../../../../core/constants/k_widgets.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../../../core/widgets/trailing_icon.dart';
import '../../../../core/widgets/tu_button.dart';
import 'verify_email_view_model.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({
    super.key,
  });

  static const String path = 'verify-email';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyEmailViewModel>(
      builder: (context, model, isInitialised, child) {
        if (!isInitialised) return kWidgetsNothing;
        return CustomScaffold(
          body: isInitialised
              ? Stack(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: context.tSizes.topSafeArea,
                          bottom: context.tSizes.bottomSafeAreaWithMinimum,
                        ),
                        constraints: const BoxConstraints(
                          maxWidth: kSizesDialogMaxWidth,
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: SvgPicture.asset(
                                    // TODO(codaveto): Add email svg | 24/11/2024
                                    kSvgsHyphen,
                                    width: 120,
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Verify Email',
                                        style: context.tTexts.verifyEmailTitle,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '''We noticed you have not verified your email address yet, please check your inbox and follow the instructions to verify your email address.''',
                                        style: context.tTexts.primaryText,
                                        textAlign: TextAlign.center,
                                      ),
                                      const Gap.appPadding(),
                                      TurboButton.primary(
                                        text: '''Send Email''',
                                        onPressed: () => model.onSendEmailPressed(context: context),
                                        trailingIcon: (backgroundColor, textColor) =>
                                            TrailingIcon(Icons.arrow_forward, color: textColor),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          const Gap.appPadding(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TurboButton.secondary(
                                                text: '''Skip''',
                                                onPressed: model.onSkipPressed,
                                                trailingIcon: (backgroundColor, textColor) =>
                                                    const TrailingIcon(
                                                  Icons.arrow_forward,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                        mainAxisSize: MainAxisSize.min,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        );
      },
      viewModelBuilder: () => VerifyEmailViewModel.locate,
    );
  }
}
