import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/turbo/config/app_setup.dart';
import 'package:turbo_template/turbo/constants/k_durations.dart';
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/constants/k_values.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';
import 'package:turbo_template/turbo/routing/base_router.dart';
import 'package:turbo_template/turbo/services/connection_service.dart';
import 'package:turbo_template/turbo/services/feedback_service.dart';
import 'package:turbo_template/turbo/services/language_service.dart';
import 'package:turbo_template/turbo/services/theme_service.dart';
import 'package:turbo_template/turbo/utils/no_thumb_scroll_behaviour.dart';
import 'package:turbo_template/turbo/widgets/is_busy_icon.dart';
import 'package:turbo_template/turbo/widgets/turbo_provider_builder.dart';
import 'package:turbo_template/turbo/widgets/value_listenable_builder_x2.dart';
import 'package:veto/data/models/busy_model.dart';
import 'package:veto/services/busy_service.dart';

import 'core/strings/gen/l10n.dart';

void main() {
  runZonedGuarded(
    () async {
      await AppSetup.initialise();
      runApp(const MyApp());
    },
    (error, stack) {
      Log(location: 'Zoned').error(
        'Unhandled exception caught: ${error.toString()}',
        error: error,
        stackTrace: stack,
      );
    },
  );
  return;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = ThemeService.locate;
    final languageService = LanguageService.locate;
    return ValueListenableBuilderX2(
      valueListenable: themeService.themeMode,
      valueListenable2: languageService.language,
      builder: (context, themeMode, language, _) {
        return TurboProviderBuilder(
          turboThemeMode: themeMode,
          builder: (config, themeMode, tools, data, texts, colors, decorations, context) {
            return AnnotatedRegion(
              value: themeMode.systemUiOverlayStyle(context),
              child: Builder(
                builder: (context) {
                  return MaterialApp.router(
                    routerConfig: BaseRouter.locate.coreRouter,
                    scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
                    scaffoldMessengerKey: FeedbackService.locate.scaffoldKey,
                    title: 'Placeholder',
                    debugShowCheckedModeBanner: false,
                    themeMode: themeMode.toMaterialThemeMode,
                    theme: ThemeData(
                      fontFamily: kValuesFontFamily,
                    ),
                    builder: (context, child) {
                      final media = MediaQuery.of(context);
                      final themeData = context.theme;
                      return Material(
                        color: context.t.colors.background,
                        child: MediaQuery(
                          data: media.copyWith(
                            textScaler: TextScaler.noScaling,
                          ),
                          child: Theme(
                            data: themeData.copyWith(
                              scaffoldBackgroundColor: context.t.colors.background,
                              iconTheme: themeData.iconTheme.copyWith(
                                size: 24,
                              ),
                            ),
                            child: Overlay(
                              initialEntries: [
                                OverlayEntry(
                                  builder: (_) {
                                    final busyService = BusyService.instance();
                                    final connectionService = ConnectionService.locate;
                                    return ValueListenableBuilderX2<BusyModel, bool>(
                                      valueListenable: busyService.isBusyListenable,
                                      valueListenable2: connectionService.hasInternetConnection,
                                      builder: (context, busyModel, hasInternetConnection, _) {
                                        return Column(
                                          children: [
                                            Expanded(
                                              child: Stack(
                                                fit: StackFit.expand,
                                                alignment: AlignmentDirectional.center,
                                                children: [
                                                  Positioned.fill(
                                                    child: AnimatedOpacity(
                                                      duration: kDurationsAnimation,
                                                      opacity: busyModel.isBusy
                                                          ? kSizesOpacityDisabled
                                                          : 1,
                                                      child: IgnorePointer(
                                                        ignoring: busyModel.isBusy ||
                                                            !hasInternetConnection,
                                                        child: child!,
                                                      ),
                                                    ),
                                                  ),
                                                  IsBusyIcon(
                                                    busyModel: busyModel,
                                                    height: 112,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    localizationsDelegates: const [
                      Strings.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: Strings.delegate.supportedLocales,
                    localeListResolutionCallback: (locales, supportedLocales) =>
                        languageService.language.value.toLocale,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
