import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:informers/informer.dart';
import 'package:turbo_template/core/enums/supported_language.dart';
import 'package:turbo_template/core/strings/gen/l10n.dart';
import 'package:turbo_template/local_storage/services/local_storage_service.dart';

class LanguageService {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static LanguageService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(LanguageService.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _localStorageService = LocalStorageService.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 🎩 STATE --------------------------------------------------wind------------------------------- \\

  late final _language = Informer<SupportedLanguage>(SupportedLanguage.en);

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  ValueListenable<SupportedLanguage> get language => _language;
  String get languageCode => _language.value.languageCode;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<void> switchLanguage() async {
    if (_language.value == SupportedLanguage.nl) {
      const language = SupportedLanguage.en;
      await Strings.load(language.toLocale);
      await _localStorageService.updateLanguage(language: language);
      _language.update(SupportedLanguage.en);
    } else {
      const language = SupportedLanguage.nl;
      await Strings.load(language.toLocale);
      await _localStorageService.updateLanguage(language: language);
      _language.update(SupportedLanguage.nl);
    }
  }
}
