import 'package:flutter/material.dart';
import 'package:turbo_template/core/constants/k_durations.dart';
import 'package:turbo_template/core/constants/k_sizes.dart';
import 'package:turbo_template/core/enums/emoji.dart';
import 'package:turbo_template/core/extensions/animation_extension.dart';
import 'package:turbo_template/core/extensions/context_extension.dart';
import 'package:turbo_template/core/globals/g_strings.dart';
import 'package:turbo_template/core/widgets/form_field_checkbox.dart';
import 'package:turbo_template/core/widgets/form_field_text.dart';
import 'package:turbo_template/core/widgets/gap.dart';
import 'package:turbo_template/core/widgets/ho_padding.dart';
import 'package:turbo_template/core/widgets/shrinks.dart';
import 'package:turbo_template/core/widgets/tu_button.dart';
import 'package:turbo_template/core/widgets/turbo_card.dart';
import 'package:turbo_template/core/widgets/turbo_scaffold.dart';
import 'package:turbo_template/features/auth/enums/auth_view_mode.dart';
import 'package:turbo_template/features/auth/widgets/accept_privacy_text.dart';
import 'package:veto/data/models/base_view_model.dart';

import 'auth_view_model.dart';

class AuthView extends StatelessWidget {
  const AuthView({
    super.key,
  });

  static const String path = 'auth';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>(
      builder: (context, model, isInitialised, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: TurboScaffold(
            body: isInitialised
                ? Center(
                  child: SafeArea(
                    child: Container(
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
                                  HoPadding(
                                    padding: kSizesAppPadding * 1.5,
                                    child: TurboCard(
                                      padding: const EdgeInsets.all(kSizesAppPadding * 2),
                                      child: ValueListenableBuilder<AuthViewMode>(
                                        valueListenable: model.authViewMode,
                                        builder: (context, authViewMode, child) {
                                          return FocusTraversalGroup(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  '${Emoji.wavingHand} ${gStrings.welcome}',
                                                  textAlign: TextAlign.center,
                                                  style: context.tTexts.scaffoldHeader,
                                                ),
                                                const Gap(8),
                                                Text(
                                                  'to Turboland',
                                                  style: context.tTexts.primaryText,
                                                  textAlign: TextAlign.center,
                                                ),
                                                const Gap.section(),
                                                FormFieldText(
                                                  key: ValueKey(authViewMode.name + 'email'),
                                                  formFieldConfig: model.emailField,
                                                  fadingFocusIcon: Icons.email_rounded,
                                                  label: gStrings.email,
                                                  hintText: gStrings.emailHint,
                                                  onSubmitted: model.onEmailSubmitted,
                                                ),
                                                const Gap.element(),
                                                FormFieldText(
                                                  key: ValueKey(authViewMode.name + 'password'),
                                                  formFieldConfig: model.passwordField,
                                                  fadingFocusIcon: Icons.lock_open_rounded,
                                                  hintText: '••••••••',
                                                  label: gStrings.password,
                                                  onSubmitted: (value) =>
                                                      model.onPasswordSubmitted(
                                                    value: value,
                                                    context: context,
                                                  ),
                                                ),
                                                VerticalShrink(
                                                  show: authViewMode.isRegister,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                      top: kSizesFormFieldGap,
                                                      bottom: kSizesFormFieldGap,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        FormFieldText(
                                                          formFieldConfig:
                                                              model.confirmPasswordField,
                                                          fadingFocusIcon: Icons.lock_rounded,
                                                          label: 'Confirm Password',
                                                          onChanged:
                                                              model.onConfirmPasswordChanged,
                                                          onSubmitted:
                                                              model.onConfirmPasswordSubmitted,
                                                        ),
                                                        ValueListenableBuilder<bool>(
                                                          valueListenable:
                                                              model.showAgreeToPrivacyCheckBox,
                                                          builder: (
                                                            context,
                                                            showAgreeToPrivacyCheckBox,
                                                            child,
                                                          ) =>
                                                              VerticalShrink(
                                                            alignment: Alignment.bottomCenter,
                                                            show: showAgreeToPrivacyCheckBox,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(
                                                                left: 8,
                                                                top: 8,
                                                              ),
                                                              child: FormFieldCheckbox(
                                                                formFieldConfig:
                                                                    model.agreePrivacyField,
                                                                color: Colors.white,
                                                                label: Padding(
                                                                  padding:
                                                                      const EdgeInsets.only(
                                                                    left: 16,
                                                                  ),
                                                                  child: MouseRegion(
                                                                    cursor: SystemMouseCursors
                                                                        .click,
                                                                    child: AcceptPrivacyText(
                                                                      onPrivacyPolicyTap: model
                                                                          .onPrivacyPolicyPressed,
                                                                      onTermsOfServiceTap: model
                                                                          .onTermsOfServicePressed,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Gap.section(),
                                                VerticalShrink(
                                                  show: authViewMode.isLogin,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                      top: kSizesFormFieldGap,
                                                      bottom: kSizesFormFieldGap,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: TurboButton.primary(
                                                            onPressed: () =>
                                                                model.onLoginPressed(
                                                              authViewMode: authViewMode,
                                                            ),
                                                            text: 'Login',
                                                            focusNode:
                                                                model.loginButtonFocusNode,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                TurboButton.primary(
                                                  text: '''Register''',
                                                  focusNode: model.registerButtonFocusNode,
                                                  onPressed: () => model.onRegisterPressed(
                                                    authViewMode: authViewMode,
                                                  ),
                                                ),
                                                const Gap.section(),
                                                AnimatedSwitcher(
                                                  duration: kDurationsAnimation,
                                                  child: Row(
                                                    key: ValueKey(
                                                      authViewMode.name + 'forgotPassword',
                                                    ),
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      TurboButton.secondary(
                                                        text: authViewMode.isLogin
                                                            ? '''Forgot password?'''
                                                            : '''Click here to login''',
                                                        focusNode:
                                                            model.registerButtonFocusNode,
                                                        onPressed: authViewMode.isLogin
                                                            ? model.onForgotPasswordPressed
                                                            : () => model.onLoginPressed(
                                                                  authViewMode: authViewMode,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                              mainAxisSize: MainAxisSize.min,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ).slideBottomUpWithFade(
                  begin: 0.05,
                )
                : const SizedBox.shrink(),
          ),
        );
      },
      viewModelBuilder: () => AuthViewModel.locate,
    );
  }
}
