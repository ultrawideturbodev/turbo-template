import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:informers/informer.dart';

import '../../../core/strings/gen/l10n.dart';
import '../enums/supported_language.dart';
import 'local_storage_service.dart';

class LanguageService {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static LanguageService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(LanguageService.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  late final _localStorageService = LocalStorageService.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

  late final _language = Informer<SupportedLanguage>(SupportedLanguage.en);
  // late final _language = Informer<SupportedLanguage>(_hiveService.language);

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
