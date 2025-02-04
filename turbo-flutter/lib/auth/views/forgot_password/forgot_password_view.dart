import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/auth/enums/forgot_password_origin.dart';
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/constants/k_widgets.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';
import 'package:turbo_template/turbo/globals/g_strings.dart';
import 'package:turbo_template/turbo/widgets/form_field_text.dart';
import 'package:turbo_template/turbo/widgets/t_gap.dart';
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
              child: Container(
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
                                    Card(
                                      padding: const EdgeInsets.all(kSizesAppPadding * 2),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            origin.title,
                                            style: context.t.texts.viewTitle,
                                            textAlign: TextAlign.center,
                                          ),
                                          const TGap.element(),
                                          Text(
                                            gStrings.fillInYourEmailAddressAndWeWillSendYou,
                                            style: context.t.texts.button,
                                            textAlign: TextAlign.center,
                                          ),
                                          const TGap.section(),
                                          FormFieldText(
                                            formFieldConfig: model.emailField,
                                            label: gStrings.email,
                                            onSubmitted: (_) =>
                                                model.onEmailSubmitted(context: context),
                                          ),
                                          const TGap.section(),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: PrimaryButton(
                                                  onPressed: () =>
                                                      model.onSendEmailPressed(context: context),
                                                  child: Text(gStrings.send),
                                                  focusNode: model.sendEmailButtonFocusNode,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const TGap.section(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        PrimaryButton(
                                          onPressed: () => model.onGoBackPressed(context: context),
                                          child:  Text(gStrings.clickHereToLogin),
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
