import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/animations/extensions/animation_extension.dart';
import 'package:turbo_template/animations/widgets/shrinks.dart';
import 'package:turbo_template/auth/enums/auth_view_mode.dart';
import 'package:turbo_template/auth/widgets/accept_privacy_text.dart';
import 'package:turbo_template/data/constants/k_durations.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/forms/widgets/t_checkbox_field.dart';
import 'package:turbo_template/forms/widgets/t_text_input_field.dart';
import 'package:turbo_template/localizations/globals/g_strings.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/constants/k_widgets.dart';
import 'package:turbo_template/ui/widgets/device_type_builder.dart';
import 'package:turbo_template/ui/widgets/t_trailing.dart';
import 'package:turbo_template/ui/widgets/t_button.dart';
import 'package:turbo_template/ui/widgets/t_card.dart';
import 'package:turbo_template/ui/widgets/t_focus_order.dart';
import 'package:turbo_template/ui/widgets/t_gap.dart';
import 'package:turbo_template/ui/widgets/t_logo.dart';
import 'package:turbo_template/ui/widgets/t_scaffold.dart';
import 'package:turbo_template/ui/widgets/t_scroll_view.dart';
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
        final deviceType = context.deviceType;
        return TScaffold(
          child: DeviceTypeBuilder(
            onDesktop: (context, deviceType, child) => Center(child: child),
            onMobile: (context, deviceType, child) => child,
            child: TScrollView(
              child: TCardFlex(
                deviceType: deviceType,
                child: ValueListenableBuilder<AuthViewMode>(
                  valueListenable: model.authViewMode,
                  builder: (context, authViewMode, child) {
                    return FocusTraversalGroup(
                      policy: OrderedTraversalPolicy(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TTrailing.horizontal(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            trailing: const TLogo(),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome back',
                                    style: context.texts.cardTitle,
                                  ),
                                  const TGap.subtitle(),
                                  Text(
                                    'Login to your Turbo account',
                                    style: context.texts.subtitle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const TGap.section(),
                          TFocusOrder(
                            order: 1,
                            child: TTextInputField(
                              key: ValueKey(authViewMode.name + 'email'),
                              fieldConfig: model.emailField,
                              leadingIcon: Icons.email_rounded,
                              label: gStrings.email,
                              hintText: gStrings.emailHint,
                              onSubmitted: model.onEmailSubmitted,
                            ),
                          ),
                          const TGap.element(),
                          TFocusOrder(
                            order: 2,
                            child: TTextInputField(
                              key: ValueKey(authViewMode.name + 'password'),
                              fieldConfig: model.passwordField,
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
                                    ? TButton(
                                  onPressed: model.onForgotPasswordPressed,
                                  child: Text(
                                    gStrings.forgotPassword + '?',
                                    style:
                                    context.turboProvider.texts.trailingFormFieldLabel,
                                  ),
                                )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                          ),
                          VerticalShrink(
                            show: authViewMode.isRegister,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: kSizesSpacingGap,
                                bottom: kSizesSpacingGap,
                              ),
                              child: Column(
                                children: [
                                  TFocusOrder(
                                    order: authViewMode.isRegister ? 3 : null,
                                    child: TTextInputField(
                                      fieldConfig: model.confirmPasswordField,
                                      leadingIcon: Icons.lock_rounded,
                                      label: 'Confirm Password',
                                      hintText: '••••••••',
                                      onChanged: model.onConfirmPasswordChanged,
                                      onSubmitted: model.onConfirmPasswordSubmitted,
                                    ),
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
                                            padding: const EdgeInsets.only(top: kSizesSpacingGap),
                                            child: TCheckboxField(
                                              formFieldConfig: model.agreePrivacyField,
                                              trailing: MouseRegion(
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
                          // Top Login button: animate with VerticalShrink and remove from focus when hidden
                          VerticalShrink(
                            show: authViewMode.isLogin,
                            hideChild: const ExcludeFocus(child: Offstage()),
                            child: TFocusOrder(
                              order: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: kSizesSpacingGap,
                                  bottom: kSizesSpacingGap,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Button.primary(
                                        child: const Text('Login'),
                                        onPressed: () =>
                                            model.onLoginPressed(authViewMode: authViewMode),
                                        focusNode: model.loginButtonFocusNode,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TFocusOrder(
                            order: 4,
                            child: Button(
                              child: const Text('Register'),
                              style: switch (authViewMode) {
                                AuthViewMode.login => ButtonVariance.outline,
                                AuthViewMode.register => ButtonVariance.primary,
                              },
                              focusNode: model.registerButtonFocusNode,
                              onPressed: () => model.onRegisterPressed(
                                authViewMode: authViewMode,
                              ),
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
                                child: TFocusOrder(
                                  order: 5,
                                  child: Button.outline(
                                    onPressed: model.onGoogleAuthPressed,
                                    child: const Icon(BootstrapIcons.google),
                                  ),
                                ),
                              ),
                              const SizedBox(width: kSizesSpacingGap),
                              Expanded(
                                child: TFocusOrder(
                                  order: 6,
                                  child: Button.outline(
                                    onPressed: model.onAppleAuthPressed,
                                    child: const Icon(BootstrapIcons.apple),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Bottom Login button for register mode: animate with VerticalShrink and remove from focus when hidden
                          VerticalShrink(
                            show: authViewMode.isRegister,
                            hideChild: const ExcludeFocus(child: Offstage()),
                            child: TFocusOrder(
                              order: 7,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: kSizesSpacingGap,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Button.outline(
                                        child: const Text('Login'),
                                        onPressed: () =>
                                            model.onLoginPressed(authViewMode: authViewMode),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ).slideBottomUpWithFade(
              begin: 0.05,
            ),
          ),
        );
      },
      viewModelBuilder: () => AuthViewModel.locate,
    );
  }
}
