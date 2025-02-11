import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/ui/constants/k_widgets.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/localizations/globals/g_strings.dart';
import 'package:turbo_template/ui/widgets/t_card.dart';
import 'package:turbo_template/forms/widgets/t_text_input_field.dart';
import 'package:turbo_template/ui/widgets/t_scaffold.dart';
import 'package:turbo_template/ui/widgets/t_gap.dart';
import 'package:veto/data/models/base_view_model.dart';

import 'forgot_password_view_model.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({
    super.key,
  });

  static const String path = 'forgot-password';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>(
      builder: (context, model, isInitialised, child) {
        if (!isInitialised) return kWidgetsNothing;
        return TScaffold(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: kSizesDialogMaxWidth,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: TCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        gStrings.forgotPassword,
                        textAlign: TextAlign.left,
                        style: context.texts.cardTitle,
                      ),
                      const Gap(6),
                      Text(
                        gStrings.fillInYourEmailAddressAndWeWillSendYou,
                        style: context.texts.subtitle,
                        textAlign: TextAlign.left,
                      ),
                      const TGap.section(),
                      TTextInputField(
                        fieldConfig: model.emailField,
                        leadingIcon: Icons.email_rounded,
                        label: gStrings.email,
                        hintText: gStrings.emailHint,
                        onSubmitted: (_) => model.onEmailSubmitted(context: context),
                      ),
                      const TGap.section(),
                      Row(
                        children: [
                          Expanded(
                            child: Button.primary(
                              child: const Text('Send'),
                              onPressed: () => model.onSendEmailPressed(
                                context: context,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const TGap.element(),
                      Row(
                        children: [
                          Expanded(
                            child: Button.ghost(
                              child: const Text('Back to login'),
                              onPressed: () => model.onGoBackPressed(context: context),
                            ),
                          ),
                        ],
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => ForgotPasswordViewModel.locate,
    );
  }
}
