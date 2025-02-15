import 'package:get_it/get_it.dart';

import 'package:turbo_template/forms/constants/k_value_validators.dart';
import 'package:turbo_template/forms/enums/t_field_type.dart';
import 'package:turbo_template/forms/abstracts/form_config.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/localizations/globals/g_strings.dart';

enum _LoginFormField {
  email,
  password,
}

class LoginForm extends FormConfig {
  static LoginForm get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(LoginForm.new);

  TFieldConfig<String> get email => formFieldConfig(_LoginFormField.email);
  TFieldConfig<String> get password => formFieldConfig(_LoginFormField.password);

  @override
  late final Map<Enum, TFieldConfig> formFieldConfigs = {
    _LoginFormField.email: TFieldConfig<String>(
      id: _LoginFormField.email,
      fieldType: TFieldType.textInput,
      valueValidator: kValueValidatorsMultiple(
        [
          kValueValidatorsRequired(errorText: () => gStrings.enterYourEmail),
          kValueValidatorsEmail(errorText: () => gStrings.enterAValidEmail),
        ],
      ),
    ),
    _LoginFormField.password: TFieldConfig<String>(
      id: _LoginFormField.password,
      fieldType: TFieldType.textInput,
      obscureText: true,
      valueValidator: kValueValidatorsRequired(errorText: () => gStrings.enterYourPassword),
    ),
  };
}
