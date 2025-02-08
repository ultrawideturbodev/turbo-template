import '../globals/g_now.dart';

extension DateTimeExtension on DateTime {
  bool isMoreThanHoursAgo(int hours) {
    final now = gNow;
    return isBefore(now) && now.difference(this).inHours >= hours;
  }
}
