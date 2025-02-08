part of '../widgets/turbo_provider.dart';

class TurboSizes {
  TurboSizes(this.context, this.deviceType);
  final BuildContext context;
  final TurboDeviceType deviceType;

  // 📍 THEME --------------------------------------------------------------------------------- \\

  double get sideNavBarWidth {
    switch (deviceType) {
      case TurboDeviceType.mobile:
        return width * 0.8;
      case TurboDeviceType.tablet:
        return width * 0.6;
      case TurboDeviceType.desktop:
        return 400;
    }
  }

  double get formFieldBorderRadius => 10.0;

  double get labelFontSize => 14.0;
  FontWeight get labelFontWeight => FontWeight.bold;

  double get buttonFontSize => 14.0;
  double get buttonBorderRadius => 10.0;
  FontWeight get buttonFontWeight => FontWeight.bold;

  Offset get globalTopLeftPosition =>
      context.renderBox?.localToGlobal(context.renderBox!.size.topLeft(Offset.zero)) ?? Offset.zero;
  Offset get globalTopRightPosition =>
      context.renderBox?.localToGlobal(context.renderBox!.size.topRight(Offset.zero)) ??
      Offset.zero;
  Offset get globalBottomLeftPosition =>
      context.renderBox?.localToGlobal(context.renderBox!.size.bottomLeft(Offset.zero)) ??
      Offset.zero;
  Offset get globalBottomRightPosition =>
      context.renderBox?.localToGlobal(context.renderBox!.size.bottomRight(Offset.zero)) ??
      Offset.zero;
  Offset get globalCenterPosition =>
      context.renderBox?.localToGlobal(context.renderBox!.size.center(Offset.zero)) ?? Offset.zero;

  double get globalTopInPositioned => globalTopLeftPosition.dy;
  double get globalLeftInPositioned => globalTopLeftPosition.dx;
  double get globalRightInPositioned => width - globalTopRightPosition.dx;
  double get globalBottomInPositioned => height - globalBottomLeftPosition.dy;

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  double get bottomSafeArea => context.media.viewPadding.bottom;
  double get bottomSafeAreaWithMinimum => max(bottomSafeArea, 16);
  double get bottomViewInsets => context.media.viewInsets.bottom;
  double get height => context.media.size.height;
  double get topSafeArea => context.media.viewPadding.top;
  double get width => context.media.size.width;
}
