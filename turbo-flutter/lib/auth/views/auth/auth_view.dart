import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/auth/enums/auth_view_mode.dart';
import 'package:turbo_template/auth/widgets/accept_privacy_text.dart';
import 'package:turbo_template/turbo/constants/k_durations.dart';
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/enums/emoji.dart';
import 'package:turbo_template/turbo/extensions/animation_extension.dart';
import 'package:turbo_template/turbo/extensions/color_extension.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';
import 'package:turbo_template/turbo/globals/g_strings.dart';
import 'package:turbo_template/turbo/widgets/form_field_checkbox.dart';
import 'package:turbo_template/turbo/widgets/form_field_text.dart';
import 'package:turbo_template/turbo/widgets/ho_padding.dart';
import 'package:turbo_template/turbo/widgets/shrinks.dart';
import 'package:turbo_template/turbo/widgets/t_gap.dart';
import 'package:turbo_template/typography/widgets/button_text.dart';
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
          child: Scaffold(
            child: isInitialised
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
                                      left: kSizesAppPadding * 1.5,
                                      right: kSizesAppPadding * 1.5,
                                      child: Card(
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
                                                    style: context.t.texts.title,
                                                  ),
                                                  const Gap(8),
                                                  Text(
                                                    'to Turboland',
                                                    style: context.t.texts.title,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const TGap.section(),
                                                  FormFieldText(
                                                    key: ValueKey(authViewMode.name + 'email'),
                                                    formFieldConfig: model.emailField,
                                                    fadingFocusIcon: Icons.email_rounded,
                                                    label: gStrings.email,
                                                    hintText: gStrings.emailHint,
                                                    onSubmitted: model.onEmailSubmitted,
                                                  ),
                                                  const TGap.element(),
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
                                                  const TGap.section(),
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
                                                            child: PrimaryButton(
                                                              onPressed: () => model.onLoginPressed(
                                                                authViewMode: authViewMode,
                                                              ),
                                                              child: Text('wtf'),
                                                              focusNode: model.loginButtonFocusNode,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  PrimaryButton(
                                                    child: ButtonText(
                                                      authViewMode.isLogin
                                                          ? 'Don\'t have an account?'
                                                          : 'Already have an account?',
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                  const TGap.section(),
                                                  AnimatedSwitcher(
                                                    duration: kDurationsAnimation,
                                                    child: Row(
                                                      key: ValueKey(
                                                        authViewMode.name + 'forgotPassword',
                                                      ),
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        PrimaryButton(
                                                          child: ButtonText(
                                                            authViewMode.isLogin
                                                                ? '''Forgot password?'''
                                                                : '''Click here to login''',
                                                          ),
                                                          focusNode: model.registerButtonFocusNode,
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
