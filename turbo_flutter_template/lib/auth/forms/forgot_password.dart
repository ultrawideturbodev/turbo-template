import 'package:get_it/get_it.dart';

import 'package:turbo_template/turbo/constants/k_value_validators.dart';
import 'package:turbo_template/turbo/enums/form_field_type.dart';
import 'package:turbo_template/turbo/forms/form_config.dart';
import 'package:turbo_template/turbo/forms/form_field_config.dart';
import 'package:turbo_template/turbo/globals/g_strings.dart';

enum _ForgotPasswordFormField {
  email,
}

class ForgotPasswordForm extends FormConfig {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static ForgotPasswordForm get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(ForgotPasswordForm.new);

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  FormFieldConfig<String> get email => formFieldConfig(_ForgotPasswordFormField.email);

  @override
  late final Map<Enum, FormFieldConfig> formFieldConfigs = {
    _ForgotPasswordFormField.email: FormFieldConfig<String>(
      id: _ForgotPasswordFormField.email,
      formFieldType: FormFieldType.text,
      valueValidator: kValueValidatorsMultiple(
        [
          kValueValidatorsRequired(errorText: () => gStrings.fillInYourEmail),
          kValueValidatorsEmail(errorText: () => gStrings.pleaseEnterAValidEmailAddress),
        ],
      ),
    ),
  };
}
