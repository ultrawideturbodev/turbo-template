import '../../localizations/globals/g_strings.dart';

enum WeekDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  String get fullName {
    switch (this) {
      case WeekDay.monday:
        return gStrings.monday;
      case WeekDay.tuesday:
        return gStrings.tuesday;
      case WeekDay.wednesday:
        return gStrings.wednesday;
      case WeekDay.thursday:
        return gStrings.thursday;
      case WeekDay.friday:
        return gStrings.friday;
      case WeekDay.saturday:
        return gStrings.saturday;
      case WeekDay.sunday:
        return gStrings.sunday;
    }
  }

  String get abbreviation {
    switch (this) {
      case WeekDay.monday:
        return gStrings.mon;
      case WeekDay.tuesday:
        return gStrings.tue;
      case WeekDay.wednesday:
        return gStrings.wed;
      case WeekDay.thursday:
        return gStrings.thu;
      case WeekDay.friday:
        return gStrings.fri;
      case WeekDay.saturday:
        return gStrings.sat;
      case WeekDay.sunday:
        return gStrings.sun;
    }
  }
}
