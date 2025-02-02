import 'package:get_it/get_it.dart';

import 'package:turbo_template/turbo/constants/k_value_validators.dart';
import 'package:turbo_template/turbo/enums/form_field_type.dart';
import 'package:turbo_template/turbo/forms/form_config.dart';
import 'package:turbo_template/turbo/forms/form_field_config.dart';
import 'package:turbo_template/turbo/globals/g_strings.dart';

enum _LoginFormField {
  email,
  password,
}

class LoginForm extends FormConfig {
  static LoginForm get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(LoginForm.new);

  FormFieldConfig<String> get email => formFieldConfig(_LoginFormField.email);
  FormFieldConfig<String> get password => formFieldConfig(_LoginFormField.password);

  @override
  late final Map<Enum, FormFieldConfig> formFieldConfigs = {
    _LoginFormField.email: FormFieldConfig<String>(
      id: _LoginFormField.email,
      formFieldType: FormFieldType.text,
      valueValidator: kValueValidatorsMultiple(
        [
          kValueValidatorsRequired(errorText: () => gStrings.enterYourEmail),
          kValueValidatorsEmail(errorText: () => gStrings.enterAValidEmail),
        ],
      ),
    ),
    _LoginFormField.password: FormFieldConfig<String>(
      id: _LoginFormField.password,
      formFieldType: FormFieldType.text,
      obscureText: true,
      valueValidator: kValueValidatorsRequired(errorText: () => gStrings.enterYourPassword),
    ),
  };
}
