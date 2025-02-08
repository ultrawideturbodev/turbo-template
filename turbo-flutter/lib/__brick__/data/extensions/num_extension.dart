extension NumExtension on num {
  T minimum<T extends num>(T other) => this >= other ? this as T : other;
  T maximum<T extends num>(T other) => this <= other ? this as T : other;
  T multiply<T extends num>(T other) => this * other as T;
  int get decimals {
    final valueAsString = toString();
    final decimalIndex = valueAsString.indexOf('.');
    if (decimalIndex == -1) {
      return 0;
    }
    return valueAsString.length - decimalIndex - 1;
  }
}
