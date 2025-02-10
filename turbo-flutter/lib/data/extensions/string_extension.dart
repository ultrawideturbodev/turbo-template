import 'package:turbo_template/state/constants/k_limits.dart';
import 'package:turbo_template/routing/constants/k_params.dart';

extension StringExtension on String {
  String withHouseholdId({required String householdId}) => '$householdId-$this';
  String withId(String id) => replaceAll(kParamsId, id);

  String capitalize({bool forceLowercase = false}) {
    if (isEmpty) {
      return '';
    }
    return forceLowercase
        ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
        : '${this[0].toUpperCase()}${substring(1)}';
  }

  String? get nullIfEmpty => trimIsEmpty ? null : this;
  String get asRootPath => '/$this';
  double? get tryAsDouble => double.tryParse(this);
  int? get tryAsInt => int.tryParse(this);
  bool get trimIsEmpty => trim().isEmpty;
  String get naked => toLowerCase().trim();
  bool containsAny(List<String> values) => values.any(contains);

  String get capitalized => '${this[0].toUpperCase()}${substring(1)}';
  bool get isValidUsername {
    if (length < kLimitsMinUsernameLength || length > kLimitsMaxNameLength) return false;
    return _validUsernameRegExp.hasMatch(this);
  }

  /// Parsed NLP sentence ready for processing
  ///
  /// This method:
  /// - Converts to lowercase
  /// - Trims leading/trailing whitespace
  /// - Replaces multiple spaces with single space
  /// - Preserves dots and punctuation
  ///
  /// Example:
  /// ```dart
  /// 'Hello   World...   Test'.lowerCaseMaxOneSpace // 'hello world... test'
  /// ```
  String get normalized => replaceAll(RegExp(r'\s+'), ' ').trim();

  static final RegExp _validUsernameRegExp =
      RegExp(r'^[a-zA-Z\d](?:[a-zA-Z\d_-]{1,28}[a-zA-Z\d])?$');

  bool isNewerThan(String? otherVersion) {
    if (otherVersion == null) return true;
    final thisParts = split('.').map(int.parse).toList();
    final otherParts = otherVersion.split('.').map(int.parse).toList();
    for (int i = 0; i < 3; i++) {
      if (thisParts[i] > otherParts[i]) return true;
      if (thisParts[i] < otherParts[i]) return false;
    }
    return false;
  }
}

extension ListStringExtension on List<String> {
  String get asId => where((e) => e.isNotEmpty).join('-').toLowerCase();
}
