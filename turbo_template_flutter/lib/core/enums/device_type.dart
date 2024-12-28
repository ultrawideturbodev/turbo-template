enum DeviceType {
  mobile,
  tablet,
  web;

  bool get isMobile => this == DeviceType.mobile;
  bool get isTabletDesktop => this == DeviceType.tablet;
  bool get isWeb => this == DeviceType.web;
}
