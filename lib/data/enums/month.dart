import '../../localizations/globals/g_strings.dart';

enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december;

  String get fullName {
    switch (this) {
      case Month.january:
        return gStrings.january;
      case Month.february:
        return gStrings.february;
      case Month.march:
        return gStrings.march;
      case Month.april:
        return gStrings.april;
      case Month.may:
        return gStrings.may;
      case Month.june:
        return gStrings.june;
      case Month.july:
        return gStrings.july;
      case Month.august:
        return gStrings.august;
      case Month.september:
        return gStrings.september;
      case Month.october:
        return gStrings.october;
      case Month.november:
        return gStrings.november;
      case Month.december:
        return gStrings.december;
    }
  }

  String get abbreviation {
    switch (this) {
      case Month.january:
        return gStrings.jan;
      case Month.february:
        return gStrings.feb;
      case Month.march:
        return gStrings.mar;
      case Month.april:
        return gStrings.apr;
      case Month.may:
        return gStrings.may;
      case Month.june:
        return gStrings.jun;
      case Month.july:
        return gStrings.jul;
      case Month.august:
        return gStrings.aug;
      case Month.september:
        return gStrings.sep;
      case Month.october:
        return gStrings.oct;
      case Month.november:
        return gStrings.nov;
      case Month.december:
        return gStrings.dec;
    }
  }
}
