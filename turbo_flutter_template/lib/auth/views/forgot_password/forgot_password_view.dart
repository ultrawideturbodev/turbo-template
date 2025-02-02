import 'package:flutter/material.dart';
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/constants/k_widgets.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';
import 'package:turbo_template/turbo/globals/g_strings.dart';
import 'package:turbo_template/turbo/widgets/form_field_text.dart';
import 'package:turbo_template/turbo/widgets/gap.dart';
import 'package:turbo_template/turbo/widgets/turbo_button.dart';
import 'package:turbo_template/turbo/widgets/turbo_card.dart';
import 'package:turbo_template/auth/enums/forgot_password_origin.dart';
import 'package:veto/data/models/base_view_model.dart';

import 'forgot_password_view_model.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({
    super.key,
    required this.origin,
  });

  static const String path = 'forgot-password';
  final ForgotPasswordOrigin origin;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>(
      argumentBuilder: () => origin,
      builder: (context, model, isInitialised, child) {
        if (!isInitialised) return kWidgetsNothing;
        switch (origin) {
          case ForgotPasswordOrigin.core:
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: context.t.decorations.gradientBackground,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: context.t.sizes.topSafeArea,
                          bottom: context.t.sizes.bottomSafeAreaWithMinimum,
                        ),
                        constraints: const BoxConstraints(
                          maxWidth: kSizesDialogMaxWidth,
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    TurboCard(
                                      padding: const EdgeInsets.all(kSizesAppPadding * 2),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            origin.title,
                                            style: context.t.texts.scaffoldHeader(
                                              onBackgroundColor: context.t.colors.background,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const Gap.element(),
                                          Text(
                                            gStrings.fillInYourEmailAddressAndWeWillSendYou,
                                            style: context.t.texts.primaryButton,
                                            textAlign: TextAlign.center,
                                          ),
                                          const Gap.section(),
                                          FormFieldText(
                                            formFieldConfig: model.emailField,
                                            label: gStrings.email,
                                            onSubmitted: (_) =>
                                                model.onEmailSubmitted(context: context),
                                          ),
                                          const Gap.section(),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TurboButton.primary(
                                                  onPressed: () =>
                                                      model.onSendEmailPressed(context: context),
                                                  text: gStrings.send,
                                                  focusNode: model.sendEmailButtonFocusNode,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap.section(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TurboButton.secondary(
                                          onPressed: () => model.onGoBackPressed(context: context),
                                          text: gStrings.clickHereToLogin,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          case ForgotPasswordOrigin.account:
            return const Text('Implement plx');
        }
      },
      viewModelBuilder: () => ForgotPasswordViewModel.locate,
    );
  }
}
