import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:veto/data/models/base_view_model.dart';

import '../../../../core/constants/k_durations.dart';
import '../../../../core/constants/k_sizes.dart';
import '../../../../core/enums/emoji.dart';
import '../../../../core/extensions/animation_extension.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/globals/g_strings.dart';
import '../../../../core/widgets/form_field_checkbox.dart';
import '../../../../core/widgets/form_field_text.dart';
import '../../../../core/widgets/gaps.dart';
import '../../../../core/widgets/ho_padding.dart';
import '../../../../core/widgets/shrinks.dart';
import '../../../../core/widgets/tu_button.dart';
import '../../../../core/widgets/tu_card.dart';
import '../../enums/auth_view_mode.dart';
import '../../widgets/accept_privacy_text.dart';
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
          child: Scaffold(
            body: isInitialised
                ? Container(
                    decoration: BoxDecoration(gradient: context.ui.gradientBackground),
                    child: Center(
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
                                        child: TuCard(
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
                                                      style: context.texts.scaffoldHeader,
                                                    ),
                                                    const Gap(8),
                                                    Text(
                                                      'to Turboland',
                                                      style: context.texts.primaryText,
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    const GapSection(),
                                                    FormFieldText(
                                                      key: ValueKey(authViewMode.name + 'email'),
                                                      formFieldConfig: model.emailField,
                                                      fadingFocusIcon: Icons.email_rounded,
                                                      label: gStrings.email,
                                                      hintText: gStrings.emailHint,
                                                      onSubmitted: model.onEmailSubmitted,
                                                    ),
                                                    const GapFormField(),
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
                                                    const GapSection(),
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
                                                    const GapSection(),
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
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
      viewModelBuilder: () => AuthViewModel.locate,
    );
  }
}
