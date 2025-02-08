enum AuthViewMode {
  login,
  register;

  static const defaultValue = AuthViewMode.login;

  bool get isLogin => this == AuthViewMode.login;
  bool get isRegister => this == AuthViewMode.register;
}
