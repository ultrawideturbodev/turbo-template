import 'package:flutter/material.dart';

import '../constants/k_widgets.dart';
import '../extensions/context_extension.dart';

class ResponsiveTools {
  ResponsiveTools({
    required this.screenWidthInDesign,
    required this.screenHeightInDesign,
    required this.context,
  });

  final double screenWidthInDesign;
  final double screenHeightInDesign;
  final BuildContext context;

  double scaledPerWidth(
    double value, {
    double bottomLimit = 0.75,
    double upperLimit = 1,
    double speed = 1.0,
  }) =>
      context
          .scaledPerWidth(
            value: value,
            screenWidthInDesign: screenWidthInDesign,
            speed: speed,
          )
          .clamp(
            value * bottomLimit,
            value * upperLimit,
          );

  double scaledPerHeight(
    double value, {
    double bottomLimit = 0.75,
    double upperLimit = 1.00,
    double speed = 1.0,
  }) =>
      context
          .scaledPerHeight(
            value: value,
            screenHeightInDesign: screenHeightInDesign,
            speed: speed,
          )
          .clamp(
            value * bottomLimit,
            value * upperLimit,
          );

  double scaled(
    double value, {
    double bottomLimit = 0.75,
    double upperLimit = 1.00,
    double speed = 1.00,
  }) =>
      context
          .scaledPerWidthAndHeight(
            value: value,
            screenWidthInDesign: screenWidthInDesign,
            screenHeightInDesign: screenHeightInDesign,
            speed: speed,
          )
          .clamp(
            value * bottomLimit,
            value * upperLimit,
          );

  Widget ifHeightLessThen(double height, Widget child) {
    if (context.sizes.height < height) {
      return child;
    }
    return kWidgetsNothing;
  }

  Widget ifWidthLessThen(double width, Widget child) {
    if (context.sizes.width < width) {
      return child;
    }
    return kWidgetsNothing;
  }

  Widget ifHeightMoreThen(double height, Widget child) {
    if (context.sizes.height > height) {
      return child;
    }
    return kWidgetsNothing;
  }

  Widget ifWidthMoreThen(double width, Widget child) {
    if (context.sizes.width > width) {
      return child;
    }
    return kWidgetsNothing;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponsiveTools &&
          runtimeType == other.runtimeType &&
          screenWidthInDesign == other.screenWidthInDesign &&
          screenHeightInDesign == other.screenHeightInDesign &&
          context == other.context;

  @override
  int get hashCode =>
      screenWidthInDesign.hashCode ^ screenHeightInDesign.hashCode ^ context.hashCode;
}
