import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:informers/informer.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_response/turbo_response.dart';
import 'package:turbo_template/local_storage/services/local_storage_service.dart';
import 'package:turbo_template/localizations/strings/gen/l10n.dart';
import 'package:turbo_template/localizations/enums/supported_language.dart';

class LanguageService with Loglytics {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static LanguageService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(
        LanguageService.new,
      );

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _localStorageService = LocalStorageService.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  Future<void> initialise() async {
    try {
      await _localStorageService.isReady;
      log.debug('Initializing language');
      final savedLanguage = _localStorageService.language;
      log.debug('Loading saved language: $savedLanguage');
      await Strings.load(savedLanguage.toLocale);
      _language.update(savedLanguage);
    } catch (error, stackTrace) {
      log.error(
        '$error caught while initializing language',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  // 🎩 STATE ------------------------------------------------------------------------------- \\

  late final _language = Informer<SupportedLanguage>(SupportedLanguage.en);

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  ValueListenable<SupportedLanguage> get language => _language;
  String get languageCode => _language.value.languageCode;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<TurboResponse> switchLanguage() async {
    try {
      final newLanguage =
          _language.value == SupportedLanguage.nl ? SupportedLanguage.en : SupportedLanguage.nl;
      log.debug('Switching language to: $newLanguage');
      await Strings.load(newLanguage.toLocale);
      await _localStorageService.updateLanguage(language: newLanguage);
      _language.update(newLanguage);
      return const TurboResponse.successAsBool();
    } catch (error, stackTrace) {
      log.error(
        '$error caught while switching language',
        error: error,
        stackTrace: stackTrace,
      );
      return const TurboResponse.failAsBool();
    }
  }
}
