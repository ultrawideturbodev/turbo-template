part of 'context_extension.dart';

class _Sizes {
  _Sizes(this.context);
  final BuildContext context;

  // 📍 THEME --------------------------------------------------------------------------------- \\

  double get formFieldBorderRadius => 10.0;

  double get labelFontSize => 14.0;
  FontWeight get labelFontWeight => FontWeight.bold;

  double get buttonFontSize => 14.0;
  double get buttonBorderRadius => 10.0;
  FontWeight get buttonFontWeight => FontWeight.bold;

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  double get bottomSafeAreaWithMinimum => max(context.media.viewPadding.bottom, 16);
  double get bottomViewInsets => context.media.viewInsets.bottom;
  double get height => context.media.size.height;
  double get topSafeArea => context.media.viewPadding.top;
  double get topViewInsets => context.media.viewInsets.top;
  double get width => context.media.size.width;
  double get navBarWidth => 258;
  double get prototypeWidth {
    switch (context.deviceType) {
      case DeviceType.mobile:
        return 393.0;
      case DeviceType.tablet:
      case DeviceType.web:
        return 1440;
    }
  }

  double get prototypeHeight {
    switch (context.deviceType) {
      case DeviceType.mobile:
        return 852;
      case DeviceType.tablet:
      case DeviceType.web:
        return 1024;
    }
  }

  /// Provides a design scaled value based on given [value], [width] and given [screenWidthInDesign].
  ///
  /// Where [screenWidthInDesign] is the width of the screen in your original UI design file.
  double scaledPerWidth({
    required double value,
    required double screenWidthInDesign,
    double speed = 1.0,
  }) {
    final widthScale = width / screenWidthInDesign;
    final adjustedScale = pow(widthScale, speed);
    return value * adjustedScale;
  }

  /// Provides a design scaled value based on given [value], [width] and given [screenWidthInDesign].
  ///
  /// Where [screenHeightInDesign] is the height of the screen in your original UI design file.
  double scaledPerHeight({
    required double value,
    required double screenHeightInDesign,
    double speed = 1.0,
  }) {
    final heightScale = height / screenHeightInDesign;
    final adjustedScale = pow(heightScale, speed);
    return value * adjustedScale;
  }

  /// Provides a design scaled value based on given [value], [width], [height]
  /// and given [screenWidthInDesign] and [screenHeightInDesign].
  ///
  /// Where [screenWidthInDesign] is the width of the screen in your original UI design file.
  /// Where [screenHeightInDesign] is the height of the screen in your original UI design file.
  double scaledPerWidthAndHeight({
    required double value,
    required double screenWidthInDesign,
    required double screenHeightInDesign,
    double speed = 1.0,
  }) {
    final widthScale = width / screenWidthInDesign;
    final heightScale = height / screenHeightInDesign;
    final scale = min(widthScale, heightScale);
    final adjustedScale = pow(scale, speed);
    return value * adjustedScale;
  }

  void printDesignWidthAndHeight() {
    if (kDebugMode) {
      print('''


screenWidthInDesign: $width,
screenHeightInDesign: $height,
''');
    }
  }
}
