import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../extensions/context_extension.dart';

import 'custom_back_button.dart';

class TurboAppBar extends AppBar {
  TurboAppBar({
    Color? backgroundColor,
    Widget? leading,
    required BuildContext context,
    String? title,
    Widget? header,
    TextStyle? textStyle,
    bool centerTitle = false,
    bool automaticallyImplyLeading = true,
    VoidCallback? onBackPressed,
    super.actions,
    super.key,
    super.bottom,
  }) : super(
          scrolledUnderElevation: 0,
          shadowColor: Colors.black,
          backgroundColor: backgroundColor ?? context.colors.shellBackground,
          centerTitle: centerTitle,
          titleSpacing: switch (header != null) {
            true => 0,
            (_) => 4,
          },
          title: header ??
              (title != null
                  ? AutoSizeText(
                      title,
                      style: textStyle ??
                          context.texts.viewTitle,
                    )
                  : null),
          titleTextStyle: textStyle ??
              context.texts.viewTitle,
          automaticallyImplyLeading: onBackPressed == null ? automaticallyImplyLeading : false,
          leading: onBackPressed == null
              ? (automaticallyImplyLeading
                  ? leading ?? (context.canPop() ? const CustomBackButton() : null)
                  : null)
              : CustomBackButton(onPressed: onBackPressed),
        );
}

class CustomSliverAppBar extends SliverAppBar {
  CustomSliverAppBar({
    Color? backgroundColor,
    Widget? leading,
    required BuildContext context,
    String? title,
    TextStyle? textStyle,
    Widget? emojiHeader,
    super.actions,
    super.pinned = false,
    super.floating = true,
    super.snap = true,
    super.key,
  }) : super(
          scrolledUnderElevation: 0,
          title: emojiHeader ??
              (title != null
                  ? AutoSizeText(
                      title,
                      style: textStyle ??
                          context.texts.viewTitle,
                    )
                  : null),
          shadowColor: Colors.black,
          backgroundColor: backgroundColor ?? context.colors.shellBackground,
          centerTitle: true,
          leading: leading ?? (context.canPop() ? const CustomBackButton() : null),
          titleTextStyle: textStyle,
        );
}
