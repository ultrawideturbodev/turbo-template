import 'dart:async';

class IdBox<KEY extends Object, VALUE extends Object> {
  IdBox({
    required VALUE Function(KEY key) defaultValue,
    FutureOr Function(VALUE value)? onDispose,
  })  : _defaultValue = defaultValue,
        _onDispose = onDispose;

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final VALUE Function(KEY key) _defaultValue;
  final FutureOr Function(VALUE value)? _onDispose;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  void dispose([KEY? key]) {
    if (key != null) {
      final removed = _box.remove(_id(key));
      if (removed != null && _onDispose != null) {
        _onDispose(removed);
      }
    } else {
      if (_onDispose != null) {
        for (final value in _box.values) {
          _onDispose(value);
        }
      }
      _box.clear();
    }
  }

  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

  final Map<String, VALUE> _box = {};

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  VALUE get(KEY key, {VALUE? initialValue}) =>
      _box.putIfAbsent(_id(key), () => initialValue ?? _defaultValue(key));

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\

  String _id(Object key) => key.toString();

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void clear() {
    _box.clear();
  }
}
