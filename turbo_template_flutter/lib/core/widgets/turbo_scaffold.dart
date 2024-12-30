import 'package:flutter/material.dart';
import 'package:turbo_template/core/extensions/context_extension.dart';

class TurboScaffold extends StatelessWidget {
  const TurboScaffold({
    super.key,
    this.appBar,
    this.backgroundColor,
    this.body,
    this.bottomNavigationBar,
    this.drawer,
    this.floatingActionButton,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.centerFloat,
    this.resizeToAvoidBottomInset = false,
    this.extendBodyBehindAppBar = true,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final bool? resizeToAvoidBottomInset;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: drawer,
    bottomNavigationBar: bottomNavigationBar,
    resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    floatingActionButton: floatingActionButton,
    floatingActionButtonLocation: floatingActionButtonLocation,
    appBar: appBar,
    backgroundColor: backgroundColor ?? context.colors.background,
    extendBodyBehindAppBar: extendBodyBehindAppBar,
    body: Stack(
      children: [
        if (body != null) SafeArea(child: body!),
      ],
    ),
  );
}
