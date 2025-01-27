import 'package:turbo_template/core/constants/k_values.dart';

extension StringExtension on String {
  String capitalize({bool forceLowercase = false}) {
    if (isEmpty) {
      return '';
    }
    return forceLowercase
        ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
        : '${this[0].toUpperCase()}${substring(1)}';
  }

  String and(Object? other) => this + kValuesHyphen + (other?.toString() ?? kValuesNull);
  String andAll(Iterable<Object?> others) =>
      this + kValuesHyphen + others.map((e) => e?.toString() ?? kValuesNull).join(kValuesHyphen);

  String? get nullIfEmpty => trimIsEmpty ? null : this;
  String get asRootPath => '/$this';
  double? get tryAsDouble => double.tryParse(this);
  int? get tryAsInt => int.tryParse(this);
  bool get trimIsEmpty => trim().isEmpty;
  String get naked => toLowerCase().trim();
  bool containsAny(List<String> values) => values.any(contains);
  String get capitalized => '${this[0].toUpperCase()}${substring(1)}';
  bool get isValidUsername => _validUsernameRegExp.hasMatch(this);

  static final RegExp _validUsernameRegExp =
      RegExp(r'^[a-zA-Z\d](?:[a-zA-Z\d._]{1,28}[a-zA-Z\d])?$');

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
  String get asId => where((e) => e.isNotEmpty).join('_').toLowerCase();
}
