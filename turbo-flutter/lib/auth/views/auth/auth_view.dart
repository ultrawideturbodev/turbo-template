import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/animations/widgets/turbo_button_animation.dart';
import 'package:turbo_template/auth/enums/auth_view_mode.dart';
import 'package:turbo_template/auth/widgets/accept_privacy_text.dart';
import 'package:turbo_template/turbo/constants/k_durations.dart';
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/enums/emoji.dart';
import 'package:turbo_template/turbo/extensions/animation_extension.dart';
import 'package:turbo_template/turbo/extensions/color_extension.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';
import 'package:turbo_template/turbo/globals/g_strings.dart';
import 'package:turbo_template/turbo/models/turbo_background.dart';
import 'package:turbo_template/turbo/widgets/buttons/turbo_button.dart';
import 'package:turbo_template/turbo/widgets/cards/turbo_card.dart';
import 'package:turbo_template/turbo/widgets/form_field_checkbox.dart';
import 'package:turbo_template/turbo/widgets/form_field_text.dart';
import 'package:turbo_template/turbo/widgets/ho_padding.dart';
import 'package:turbo_template/turbo/widgets/layout/turbo_scaffold.dart';
import 'package:turbo_template/turbo/widgets/shrinks.dart';
import 'package:turbo_template/turbo/widgets/t_gap.dart';
import 'package:veto/data/models/base_view_model.dart';

import 'auth_view_model.dart';

class AuthView extends StatelessWidget {
  const AuthView({
    super.key,
  });

  static const String path = '';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>(
      builder: (context, model, isInitialised, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: TurboScaffold(
            background: TurboGradientBackground(
              colors: [
                Colors.white.withOpacity(0.08),
                Colors.transparent,
              ],
            ),
            child: isInitialised
                ? Center(
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
                                    left: kSizesAppPadding * 1.5,
                                    right: kSizesAppPadding * 1.5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(kSizesAppPadding * 2),
                                      child: TurboCard(
                                        child: ValueListenableBuilder<AuthViewMode>(
                                          valueListenable: model.authViewMode,
                                          builder: (context, authViewMode, child) {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  'Welcome back',
                                                  textAlign: TextAlign.center,
                                                  style: context.t.texts.cardTitle,
                                                ),
                                                const Gap(8),
                                                Text(
                                                  'Login to your ${context.t.config.appName} account',
                                                  style: context.t.texts.cardSubtitle,
                                                  textAlign: TextAlign.center,
                                                ),
                                                const TGap.section(),
                                                FormFieldText(
                                                  key: ValueKey(authViewMode.name + 'email'),
                                                  formFieldConfig: model.emailField,
                                                  leadingIcon: Icons.email_rounded,
                                                  label: gStrings.email,
                                                  hintText: gStrings.emailHint,
                                                  onSubmitted: model.onEmailSubmitted,
                                                ),
                                                const TGap.element(),
                                                FormFieldText(
                                                  key: ValueKey(authViewMode.name + 'password'),
                                                  formFieldConfig: model.passwordField,
                                                  leadingIcon: Icons.lock_open_rounded,
                                                  hintText: '••••••••',
                                                  label: gStrings.password,
                                                  onSubmitted: (value) => model.onPasswordSubmitted(
                                                    value: value,
                                                    context: context,
                                                  ),
                                                  trailingLabel: AnimatedSwitcher(
                                                    duration: kDurationsAnimation,
                                                    child: authViewMode.isLogin
                                                        ? TurboButton(
                                                            onPressed:
                                                                model.onForgotPasswordPressed,
                                                            child: Text(
                                                              gStrings.forgotPassword + '?',
                                                              style: context
                                                                  .t.texts.trailingFormFieldLabel,
                                                            ),
                                                          )
                                                        : const SizedBox.shrink(),
                                                  ),
                                                ),
                                                VerticalShrink(
                                                  show: authViewMode.isRegister,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                      top: kSizesItemGap,
                                                      bottom: kSizesItemGap,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        FormFieldText(
                                                          formFieldConfig:
                                                              model.confirmPasswordField,
                                                          leadingIcon: Icons.lock_rounded,
                                                          label: 'Confirm Password',
                                                          hintText: '••••••••',
                                                          onChanged: model.onConfirmPasswordChanged,
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
                                                                  padding: const EdgeInsets.only(
                                                                    left: 16,
                                                                  ),
                                                                  child: MouseRegion(
                                                                    cursor:
                                                                        SystemMouseCursors.click,
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
                                                const TGap(8),
                                                VerticalShrink(
                                                  alignment: Alignment.topCenter,
                                                  show: authViewMode.isLogin,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                      top: kSizesItemGap,
                                                      bottom: kSizesItemGap,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Button.primary(
                                                            child: const Text('Login'),
                                                            onPressed: () => model.onLoginPressed(
                                                              authViewMode: authViewMode,
                                                            ),
                                                            focusNode: model.loginButtonFocusNode,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Button(
                                                  child: const Text('''Register'''),
                                                  style: switch (authViewMode) {
                                                    AuthViewMode.login => ButtonVariance.outline,
                                                    AuthViewMode.register => ButtonVariance.primary,
                                                  },
                                                  focusNode: model.registerButtonFocusNode,
                                                  onPressed: () => model.onRegisterPressed(
                                                    authViewMode: authViewMode,
                                                  ),
                                                ),
                                                const TGap.section(multiplier: 0.75),
                                                Row(
                                                  children: [
                                                    const Expanded(child: Divider()),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                      ),
                                                      child: const Text('Or continue with')
                                                          .muted()
                                                          .small(),
                                                    ),
                                                    const Expanded(child: Divider()),
                                                  ],
                                                ),
                                                const TGap.section(),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Button.outline(
                                                        onPressed: model.onGoogleAuthPressed,
                                                        child: const Icon(BootstrapIcons.google),
                                                      ),
                                                    ),
                                                    const SizedBox(width: kSizesItemGap),
                                                    Expanded(
                                                      child: Button.outline(
                                                        onPressed: model.onAppleAuthPressed,
                                                        child: const Icon(BootstrapIcons.apple),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                VerticalShrink(
                                                  alignment: Alignment.bottomCenter,
                                                  show: authViewMode.isRegister,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                      top: kSizesItemGap,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Button.outline(
                                                            child: const Text('Login'),
                                                            onPressed: () => model.onLoginPressed(
                                                              authViewMode: authViewMode,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              mainAxisSize: MainAxisSize.min,
                                            );
                                          },
                                        ),
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
