/// Used to store locate calls inside a callback.
///
/// This way the actual locate call is only called when necessary.
typedef LazyLocatorDef<T extends Object> = T Function();
