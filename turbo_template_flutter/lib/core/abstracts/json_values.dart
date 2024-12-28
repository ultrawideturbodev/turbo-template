abstract class LocalStorageValue<T> {
  Map<String, dynamic> toJson();
  String get toJsonString => toJson().toString();
}
