import 'package:get_it/get_it.dart';

import 'package:turbo_template/forms/constants/k_value_validators.dart';
import 'package:turbo_template/forms/enums/t_field_type.dart';
import 'package:turbo_template/forms/abstracts/form_config.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/localizations/globals/g_strings.dart';

enum _RegisterFormField {
  email,
  password,
  confirmPassword,
  agreePrivacy,
}

class RegisterForm extends FormConfig {
  static RegisterForm get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(RegisterForm.new);

  TFieldConfig<String> get email => formFieldConfig(_RegisterFormField.email);
  TFieldConfig<String> get password => formFieldConfig(_RegisterFormField.password);
  TFieldConfig<bool> get agreePrivacy => formFieldConfig(_RegisterFormField.agreePrivacy);
  TFieldConfig<String> get confirmPassword =>
      formFieldConfig(_RegisterFormField.confirmPassword);

  @override
  late final formFieldConfigs = {
    _RegisterFormField.email: TFieldConfig<String>(
      id: _RegisterFormField.email,
      fieldType: TFieldType.textInput,
      valueValidator: kValueValidatorsMultiple(
        [
          kValueValidatorsRequired(errorText: () => gStrings.enterYourEmail),
          kValueValidatorsEmail(errorText: () => gStrings.enterAValidEmail),
        ],
      ),
    ),
    _RegisterFormField.password: TFieldConfig<String>(
      id: _RegisterFormField.password,
      fieldType: TFieldType.textInput,
      obscureText: true,
      valueValidator: kValueValidatorsMultiple(
        [
          kValueValidatorsRequired(errorText: () => gStrings.enterYourPassword),
          kValueValidatorsMinLength(
            minLength: 0,
            errorText: () => gStrings.yourPasswordMustBeAtLeast8CharactersLong,
          ),
        ],
      ),
    ),
    _RegisterFormField.confirmPassword: TFieldConfig<String>(
      id: _RegisterFormField.confirmPassword,
      fieldType: TFieldType.textInput,
      obscureText: true,
      valueValidator: kValueValidatorsMultiple(
        [
          kValueValidatorsRequired(errorText: () => gStrings.confirmYourPassword),
          kValueValidatorsEquals(
            () => password.value,
            errorText: () => gStrings.passwordDoesNotMatch,
          ),
        ],
      ),
    ),
    _RegisterFormField.agreePrivacy: TFieldConfig<bool>(
      id: _RegisterFormField.agreePrivacy,
      fieldType: TFieldType.checkbox,
      valueValidator: kValueValidatorsMultiple(
        [
          kValueValidatorsIsTrue(errorText: () => gStrings.pleaseReadAndAcceptOurPrivacyPolicy),
        ],
      ),
    ),
  };
}
