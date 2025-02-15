import 'package:informers/informers.dart';

/// Used to provide and dispose informers in a neat way.
class InformerBox<T extends Object> {
  InformerBox({
    required T initialValue,
    bool forceUpdate = false,
  })  : _defaultValue = initialValue,
        _forceUpdate = forceUpdate;

  final T _defaultValue;
  final bool _forceUpdate;
  final Map<String, Informer<T>> _box = {};

  Informer<T> get(
    Object key, {
    T? initialValue,
    bool? forceUpdate,
  }) {
    return _box.putIfAbsent(
      key.toString(),
      () => Informer<T>(
        initialValue ?? _defaultValue,
        forceUpdate: forceUpdate ?? _forceUpdate,
      ),
    );
  }

  void remove(Object key) {
    _box.remove(key.toString());
  }

  void forEach(void Function(String key, Informer<T> informer) action) => _box.forEach(action);

  void dispose() {
    for (final informer in _box.values) {
      informer.dispose();
    }
    _box.clear();
  }

  void clear() {
    _box.clear();
  }
}
