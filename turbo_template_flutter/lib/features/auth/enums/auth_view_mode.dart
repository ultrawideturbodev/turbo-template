enum AuthViewMode {
  login,
  register;

  bool get isLogin => this == AuthViewMode.login;
  bool get isRegister => this == AuthViewMode.register;
}
