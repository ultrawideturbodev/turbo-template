import 'package:get_it/get_it.dart';
import 'package:turbo_template/forms/abstracts/form_config.dart';
import 'package:turbo_template/forms/config/form_field_config.dart';
import 'package:turbo_template/forms/constants/k_value_validators.dart';
import 'package:turbo_template/forms/enums/form_field_type.dart';

enum _ExampleFormField {
  name,
  email,
}

class ExampleForm extends FormConfig {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static ExampleForm get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(ExampleForm.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

  @override
  late final Map<Enum, FormFieldConfig> formFieldConfigs = {
    _ExampleFormField.name: FormFieldConfig<String>(
      id: _ExampleFormField.name,
      formFieldType: FormFieldType.text,
      valueValidator: kValueValidatorsMultiple([
        kValueValidatorsRequired(errorText: () => 'Please enter your name'),
        kValueValidatorsMinLength(
          minLength: 2,
          errorText: () => 'Name must be at least 2 characters long',
        ),
        kValueValidatorsMaxLength(
          maxLength: 50,
          errorText: () => 'Name must be at most 50 characters long',
        ),
      ]),
    ),
    _ExampleFormField.email: FormFieldConfig<String>(
      id: _ExampleFormField.email,
      formFieldType: FormFieldType.text,
      valueValidator: kValueValidatorsMultiple([
        kValueValidatorsRequired(errorText: () => 'Please enter your email'),
        kValueValidatorsEmail(errorText: () => 'Please enter a valid email address'),
      ]),
    ),
  };

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  FormFieldConfig<String> get name => formFieldConfig(_ExampleFormField.name);
  FormFieldConfig<String> get email => formFieldConfig(_ExampleFormField.email);
  FormFieldConfig<String> get age => formFieldConfig(_ExampleFormField.age);
  FormFieldConfig<String> get bio => formFieldConfig(_ExampleFormField.bio);

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void updateName(String? value) => name.value = value;
  void updateEmail(String? value) => email.value = value;
  void updateAge(String? value) => age.value = value;
  void updateBio(String? value) => bio.value = value;
}
