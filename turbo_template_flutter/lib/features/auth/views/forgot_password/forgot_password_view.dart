import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:veto/data/models/base_view_model.dart';

import '../../../../core/constants/k_sizes.dart';
import '../../../../core/constants/k_widgets.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/globals/g_strings.dart';
import '../../../../core/widgets/form_field_text.dart';
import '../../../../core/widgets/gaps.dart';
import '../../../../core/widgets/tu_card.dart';
import '../../../../core/widgets/turbo_button.dart';
import '../../enums/forgot_password_origin.dart';
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
                  gradient: context.ui.gradientBackground,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: context.sizes.topSafeArea,
                          bottom: context.sizes.bottomSafeAreaWithMinimum,
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
                                    TuCard(
                                      padding: const EdgeInsets.all(kSizesAppPadding * 2),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            origin.title,
                                            style: context.texts.scaffoldHeader,
                                            textAlign: TextAlign.center,
                                          ),
                                          const Gap(8),
                                          Text(
                                            gStrings.fillInYourEmailAddressAndWeWillSendYou,
                                            style: context.texts.primaryText,
                                            textAlign: TextAlign.center,
                                          ),
                                          const GapSection(),
                                          FormFieldText(
                                            formFieldConfig: model.emailField,
                                            label: gStrings.email,
                                            onSubmitted: (_) =>
                                                model.onEmailSubmitted(context: context),
                                          ),
                                          const GapSection(),
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
                                    const GapSection(),
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
