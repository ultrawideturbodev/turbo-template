import 'package:get_it/get_it.dart';

import '../../../core/constants/k_value_validators.dart';
import '../../../core/enums/form_field_type.dart';
import '../../../core/forms/form_config.dart';
import '../../../core/forms/form_field_config.dart';
import '../../../core/globals/g_strings.dart';

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
