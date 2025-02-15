import 'package:get_it/get_it.dart';
import 'package:turbo_template/forms/abstracts/form_config.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/constants/k_value_validators.dart';
import 'package:turbo_template/forms/enums/t_field_type.dart';
import 'package:turbo_template/localizations/globals/g_strings.dart';
import 'package:turbo_template/state/constants/k_limits.dart';

enum TSearchFormField {
  search,
}

class TSearchForm extends FormConfig {
  TSearchForm();

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static TSearchForm get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(TSearchForm.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

  static const List<String> _suggestions = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Grape',
    'Kiwi',
    'Lemon',
    'Mango',
    'Orange',
    'Peach',
    'Pear',
    'Pineapple',
    'Strawberry',
    'Watermelon',
  ];

  @override
  late final Map<Enum, TFieldConfig> formFieldConfigs = {
    TSearchFormField.search: TFieldConfig<String>(
      id: TSearchFormField.search,
      fieldType: TFieldType.textInput,
      autoCompleteValues: _suggestions,
      valueValidator: kValueValidatorsMultiple(
        [
          kValueValidatorsMaxLength(
            maxLength: kLimitsMaxNameLength,
            errorText: () =>
                gStrings.nameCanBeAtMostKlimitsmaxnamelengthCharactersLong(kLimitsMaxNameLength),
          ),
        ],
      ),
    ),
  };

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  TFieldConfig<String> get search => formFieldConfig(TSearchFormField.search);

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void updateSearch(String? value) => search.value = value;
}
