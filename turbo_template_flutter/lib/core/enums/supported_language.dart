import 'dart:ui';

enum SupportedLanguage {
  nl,
  en,
  ;

  static const defaultValue = SupportedLanguage.en;

  String get languageCode {
    switch (this) {
      case SupportedLanguage.en:
        return 'en';
      case SupportedLanguage.nl:
        return 'nl';
    }
  }

  T fold<T>(T Function(SupportedLanguage supportedLanguage) supportedLanguage) =>
      supportedLanguage(this);

  Locale get toLocale => Locale(name);
}

extension SupportedLanguagesExtension on String? {
  SupportedLanguage get toSupportedLanguage => SupportedLanguage.values.firstWhere(
        (element) => element.name == this?.trim().toLowerCase(),
        orElse: () => SupportedLanguage.nl,
      );
}
