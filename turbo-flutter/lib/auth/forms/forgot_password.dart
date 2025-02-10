import 'package:get_it/get_it.dart';

import 'package:turbo_template/forms/constants/k_value_validators.dart';
import 'package:turbo_template/forms/enums/form_field_type.dart';
import 'package:turbo_template/forms/abstracts/form_config.dart';
import 'package:turbo_template/forms/config/form_field_config.dart';
import 'package:turbo_template/localizations/globals/g_strings.dart';

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
      formFieldType: FormFieldType.textInput,
      valueValidator: kValueValidatorsMultiple(
        [
          kValueValidatorsRequired(errorText: () => gStrings.fillInYourEmail),
          kValueValidatorsEmail(errorText: () => gStrings.pleaseEnterAValidEmailAddress),
        ],
      ),
    ),
  };
}
