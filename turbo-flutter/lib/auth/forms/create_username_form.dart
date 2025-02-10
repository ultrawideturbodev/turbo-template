import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:turbo_template/forms/abstracts/form_config.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/forms/constants/k_value_validators.dart';
import 'package:turbo_template/forms/enums/t_field_type.dart';

enum _CreateUsernameField {
  username,
}

class CreateUsernameForm extends FormConfig {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static CreateUsernameForm get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(CreateUsernameForm.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

  @override
  late final Map<Enum, TFieldConfig> formFieldConfigs = {
    _CreateUsernameField.username: TFieldConfig<String>(
      id: _CreateUsernameField.username,
      fieldType: TFieldType.textInput,
      valueValidator: CreateUsernameForm.usernameValidator,
    ),
  };

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  TFieldConfig<String> get username => formFieldConfig(_CreateUsernameField.username);
  static FormFieldValidator get usernameValidator => kValueValidatorsMultiple(
        [
          kValueValidatorsRequired(
            errorText: () => 'This field is required',
          ),
          kValueValidatorsNoProfanity(
            profanityWords: [
              'fuck',
              'roomy',
              'shit',
              'bitch',
              'ass',
              'dick',
              'pussy',
              'damn',
              'bastard',
              'slut',
              'whore',
              'cunt',
              'fag',
              'dyke',
              'asshole',
              'crap',
              'hell',
              'bollocks',
              'bugger',
              'twat',
              'prick',
              'cocksucker',
              'motherfucker',
              'nigger',
              'kike',
              'chink',
              'gook',
              'wop',
              'spic',
              'faggot',
              'dyke',
              'queer',
              'tranny',
              'shemale',
              'dildo',
              'blowjob',
              'handjob',
              'rimjob',
              '69',
              'titfuck',
              'piss',
              'poop',
              'arse',
              'cum',
              'jizz',
              'vagina',
              'penis',
              'clitoris',
              'boob',
              'tits',
              'anal',
              'masturbate',
              'orgasm',
              'nazi',
              'sieg heil',
              'hitler',
              'nigga',
              'pussay',
              // Additional terms and sensitive topics that might be filtered
              'suicide',
              'selfharm',
              'anorexia',
              'bulimia',
              'thinspo',
              'kill',
              'murder',
              'terrorist',
              'bomb',
              'rape',
              'abuse',
              'violence',
              'phuck',
              'biatch',
              'p*ssy',
              'd*ck',
              'sh1t',
              'f*ck',
              'wtf',
              'lmfao',
              'weed',
              'cocaine',
              'meth',
              'heroin',
              'mdma',
              'ecstasy',
              'pot',
              'dope',
              'lsd',
              'acid',
            ],
            errorText: () => 'Invalid username',
          ),
          kValueValidatorsMinLength(
            minLength: 3,
            errorText: () => 'Username must be at least 3 characters long.',
          ),
          kValueValidatorsMaxLength(
            maxLength: 30,
            errorText: () => 'Username must be no more than 30 characters long.',
          ),
          kValueValidatorsIsValidUsernameNaked(
            errorText: () =>
                'Username can only contain alphanumeric characters, underscores, and periods.',
          ),
        ],
      );

// 🏗️ HELPERS ------------------------------------------------------------------------------- \\
// 🪄 MUTATORS ------------------------------------------------------------------------------ \\
}
