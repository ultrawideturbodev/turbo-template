import 'package:flutter/material.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';

class TurboScaffold extends StatelessWidget {
  const TurboScaffold({
    super.key,
    this.appBar,
    this.body,
    this.drawer,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = false,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.centerFloat,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final bool? resizeToAvoidBottomInset;
  final FloatingActionButtonLocation floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: drawer,
    resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    floatingActionButton: floatingActionButton,
    floatingActionButtonLocation: floatingActionButtonLocation,
    appBar: appBar,
    backgroundColor: context.t.colors.background,
    extendBodyBehindAppBar: true,
    body: Stack(
      children: [
        Positioned.fill(
          top: -100,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: context.t.decorations.gradientBackground,
            ),
          ),
        ),
        if (body != null) SafeArea(child: body!, bottom: false),
      ],
    ),
  );
}
