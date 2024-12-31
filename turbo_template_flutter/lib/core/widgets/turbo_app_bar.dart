import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turbo_template/core/extensions/context_extension.dart';
import 'package:turbo_template/core/widgets/custom_back_button.dart';

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
          backgroundColor: backgroundColor ?? context.tColors.shellBackground,
          centerTitle: centerTitle,
          titleSpacing: switch (header != null) {
            true => 0,
            (_) => 4,
          },
          title: header ??
              (title != null
                  ? AutoSizeText(
                      title,
                      style: textStyle ?? context.tTexts.scaffoldHeader,
                    )
                  : null),
          titleTextStyle: textStyle ?? context.tTexts.scaffoldHeader,
          automaticallyImplyLeading: onBackPressed == null && automaticallyImplyLeading,
          leading: onBackPressed == null
              ? (automaticallyImplyLeading
                  ? leading ?? (context.canPop() ? const CustomBackButton() : null)
                  : null)
              : CustomBackButton(onPressed: onBackPressed),
        );
}
