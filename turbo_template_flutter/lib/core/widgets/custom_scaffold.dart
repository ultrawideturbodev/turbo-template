import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants/k_sizes.dart';
import '../extensions/context_extension.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    this.addBottomSafeArea = false,
    this.appBar,
    this.backgroundColor,
    this.backgroundContent,
    this.body,
    this.buttonHeight = kSizesButtonHeight,
    this.drawer,
    this.fadeMaskBody,
    this.fadeMaskPercentage,
    this.floatingActionButton,
    this.foregroundContent,
    this.onScrollNotification,
    this.primaryButtonBuilder,
    this.resizeToAvoidBottomInset,
    this.secondaryButtonBuilder,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.centerFloat,
  }) : assert(
            (fadeMaskBody != null) == (onScrollNotification != null && fadeMaskPercentage != null),
            'Add `onScrollNotification` and `fadeMaskPercentage` when `fadeMaskBody` is not null, '
            'otherwise use `body`');

  final Color? backgroundColor;

  final NotificationListenerCallback<ScrollNotification>? onScrollNotification;
  final PreferredSizeWidget? appBar;
  final ValueListenable<double>? fadeMaskPercentage;

  final Widget Function(BoxConstraints constraints)? fadeMaskBody;
  final Widget? backgroundContent;
  final Widget? body;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Widget? foregroundContent;
  final WidgetBuilder? primaryButtonBuilder;
  final WidgetBuilder? secondaryButtonBuilder;

  final bool addBottomSafeArea;
  final bool? resizeToAvoidBottomInset;

  final double buttonHeight;

  final FloatingActionButtonLocation floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    final hasSecondaryButton = secondaryButtonBuilder != null;
    final hasPrimaryButton = primaryButtonBuilder != null;
    return Scaffold(
      drawer: drawer,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      appBar: appBar,
      backgroundColor: backgroundColor ?? context.colors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (backgroundContent != null) backgroundContent!,
          if (fadeMaskPercentage != null && fadeMaskBody != null && onScrollNotification != null)
            Positioned.fill(
              child: NotificationListener<ScrollNotification>(
                onNotification: onScrollNotification,
                child: ValueListenableBuilder<double>(
                  valueListenable: fadeMaskPercentage!,
                  builder: (context, fadePercent, child) => LayoutBuilder(
                    builder: (context, constraints) {
                      return ShaderMask(
                        child: fadeMaskBody!(constraints),
                        shaderCallback: (bounds) {
                          const maxTopFadeHeight = 72;
                          final shaderEndHeight = buttonHeight / 2 + 16; // + bottom padding

                          final shaderEnd = bounds.height - shaderEndHeight;

                          final topFadeEnd = maxTopFadeHeight * fadePercent / bounds.height;

                          return LinearGradient(
                            begin: const Alignment(0, -1),
                            end: const Alignment(0, 1),
                            colors: [
                              Colors.white.withOpacity(0),
                              Colors.white,
                            ],
                            stops: [
                              0,
                              topFadeEnd,
                            ],
                          ).createShader(
                            Rect.fromLTRB(
                              0,
                              MediaQuery.of(context).viewPadding.top,
                              bounds.width,
                              shaderEnd,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          if (body != null) body!,
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                if (hasPrimaryButton) primaryButtonBuilder!(context),
                if (hasSecondaryButton)
                  Positioned(
                    bottom: (addBottomSafeArea ? context.sizes.bottomSafeAreaWithMinimum : 0) +
                        buttonHeight +
                        8,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: buttonHeight * 2.5,
                      child: secondaryButtonBuilder!(context),
                    ),
                  ),
              ],
            ),
          ),
          if (foregroundContent != null) foregroundContent!,
        ],
      ),
    );
  }
}
