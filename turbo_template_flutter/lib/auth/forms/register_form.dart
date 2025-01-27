import 'package:get_it/get_it.dart';

import '../../core/constants/k_value_validators.dart';
import '../../core/enums/form_field_type.dart';
import '../../core/forms/form_config.dart';
import '../../core/forms/form_field_config.dart';
import '../../core/globals/g_strings.dart';

enum _RegisterFormField {
  email,
  password,
  confirmPassword,
  agreePrivacy,
}

class RegisterForm extends FormConfig {
  static RegisterForm get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(RegisterForm.new);

  FormFieldConfig<String> get email => formFieldConfig(_RegisterFormField.email);
  FormFieldConfig<String> get password => formFieldConfig(_RegisterFormField.password);
  FormFieldConfig<bool> get agreePrivacy => formFieldConfig(_RegisterFormField.agreePrivacy);
  FormFieldConfig<String> get confirmPassword =>
      formFieldConfig(_RegisterFormField.confirmPassword);

  @override
  late final formFieldConfigs = {
    _RegisterFormField.email: FormFieldConfig<String>(
      id: _RegisterFormField.email,
      formFieldType: FormFieldType.text,
      valueValidator: kValueValidatorsMultiple(
        [
          kValueValidatorsRequired(errorText: () => gStrings.enterYourEmail),
          kValueValidatorsEmail(errorText: () => gStrings.enterAValidEmail),
        ],
      ),
    ),
    _RegisterFormField.password: FormFieldConfig<String>(
      id: _RegisterFormField.password,
      formFieldType: FormFieldType.text,
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
    _RegisterFormField.confirmPassword: FormFieldConfig<String>(
      id: _RegisterFormField.confirmPassword,
      formFieldType: FormFieldType.text,
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
    _RegisterFormField.agreePrivacy: FormFieldConfig<bool>(
      id: _RegisterFormField.agreePrivacy,
      formFieldType: FormFieldType.checkbox,
      valueValidator: kValueValidatorsMultiple(
        [
          kValueValidatorsIsTrue(errorText: () => gStrings.pleaseReadAndAcceptOurPrivacyPolicy),
        ],
      ),
    ),
  };
}
