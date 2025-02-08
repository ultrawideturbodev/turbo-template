import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:{{packageName.snakeCase()}}/auth/enums/auth_view_mode.dart';
import 'package:{{packageName.snakeCase()}}/auth/widgets/accept_privacy_text.dart';
import 'package:{{packageName.snakeCase()}}/data/constants/k_durations.dart';
import 'package:{{packageName.snakeCase()}}/data/constants/k_sizes.dart';
import 'package:{{packageName.snakeCase()}}/ui/constants/k_widgets.dart';
import 'package:{{packageName.snakeCase()}}/animations/extensions/animation_extension.dart';
import 'package:{{packageName.snakeCase()}}/state/extensions/context_extension.dart';
import 'package:{{packageName.snakeCase()}}/localizations/globals/g_strings.dart';
import 'package:{{packageName.snakeCase()}}/ui/widgets/turbo_button.dart';
import 'package:{{packageName.snakeCase()}}/ui/widgets/turbo_card.dart';
import 'package:{{packageName.snakeCase()}}/forms/widgets/form_field_checkbox.dart';
import 'package:{{packageName.snakeCase()}}/forms/widgets/form_field_text.dart';
import 'package:{{packageName.snakeCase()}}/ui/widgets/turbo_scaffold.dart';
import 'package:{{packageName.snakeCase()}}/animations/widgets/shrinks.dart';
import 'package:{{packageName.snakeCase()}}/ui/widgets/turbo_gap.dart';
import 'package:{{packageName.snakeCase()}}/ui/widgets/turbo_scroll_view.dart';
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
        // TODO(brian): Show app logo | 05/02/2025
        if (!isInitialised) return kWidgetsNothing;
        return TurboScaffold(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: kSizesDialogMaxWidth,
              ),
              child: TurboScrollView(
                child: TurboCard(
                  type: TChildCard(
                    child: ValueListenableBuilder<AuthViewMode>(
                      valueListenable: model.authViewMode,
                      builder: (context, authViewMode, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Welcome back',
                            textAlign: TextAlign.left,
                            style: context.texts.cardTitle,
                          ),
                          const TGap.subtitle(),
                          Text(
                            'Login to your Turbo account',
                            style: context.texts.subtitle,
                            textAlign: TextAlign.left,
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
                                      onPressed: model.onForgotPasswordPressed,
                                      child: Text(
                                        gStrings.forgotPassword + '?',
                                        style: context.turboProvider.texts.trailingFormFieldLabel,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ),
                          VerticalShrink(
                            show: authViewMode.isRegister,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: kSizesElementGap,
                                bottom: kSizesElementGap,
                              ),
                              child: Column(
                                children: [
                                  FormFieldText(
                                    formFieldConfig: model.confirmPasswordField,
                                    leadingIcon: Icons.lock_rounded,
                                    label: 'Confirm Password',
                                    hintText: '••••••••',
                                    onChanged: model.onConfirmPasswordChanged,
                                    onSubmitted: model.onConfirmPasswordSubmitted,
                                  ),
                                  ValueListenableBuilder<bool>(
                                    valueListenable: model.showAgreeToPrivacyCheckBox,
                                    builder: (
                                      context,
                                      showAgreeToPrivacyCheckBox,
                                      child,
                                    ) =>
                                        VerticalShrink(
                                      alignment: Alignment.bottomCenter,
                                      show: showAgreeToPrivacyCheckBox,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: kSizesElementGap),
                                        child: FormFieldCheckbox(
                                          formFieldConfig: model.agreePrivacyField,
                                          label: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: AcceptPrivacyText(
                                              onPrivacyPolicyTap: model.onPrivacyPolicyPressed,
                                              onTermsOfServiceTap: model.onTermsOfServicePressed,
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
                          const Gap(8),
                          VerticalShrink(
                            alignment: Alignment.topCenter,
                            show: authViewMode.isLogin,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: kSizesElementGap,
                                bottom: kSizesElementGap,
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
                                child: const Text('Or continue with').muted().small(),
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
                              const SizedBox(width: kSizesElementGap),
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
                                top: kSizesElementGap,
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
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ).slideBottomUpWithFade(
            begin: 0.05,
          ),
        );
      },
      viewModelBuilder: () => AuthViewModel.locate,
    );
  }
}
