enum TurboDeviceType {
  mobile,
  tablet,
  desktop;

  bool get isMobile => this == TurboDeviceType.mobile;
  bool get isTabletDesktop => this == TurboDeviceType.tablet;
  bool get isDesktop => this == TurboDeviceType.desktop;
}
