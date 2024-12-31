import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loglytics/loglytics.dart';
import 'package:veto/data/models/busy_model.dart';
import 'package:veto/services/busy_service.dart';

import 'core/config/app_setup.dart';
import 'core/constants/k_durations.dart';
import 'core/constants/k_sizes.dart';
import 'core/constants/k_values.dart';
import 'core/extensions/context_extension.dart';
import 'core/extensions/theme_mode_extension.dart';
import 'core/routing/base_router.dart';
import 'core/services/connection_service.dart';
import 'core/services/feedback_service.dart';
import 'core/services/language_service.dart';
import 'core/services/theme_service.dart';
import 'core/strings/gen/l10n.dart';
import 'core/utils/no_thumb_scroll_behaviour.dart';
import 'core/widgets/is_busy_icon.dart';
import 'core/widgets/local_settings_provider.dart';
import 'core/widgets/responsive_builder.dart';
import 'core/widgets/responsive_tools_provider.dart';
import 'core/widgets/value_listenable_builder_x2.dart';

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
  // SentryFlutter.init(
  //       (options) {
  //     options.dsn = kValuesSentryDsn;
  //     const isDebug = kDebugMode;
  //     options.environment = Environment.current.name;
  //     options.tracesSampleRate = isDebug ? 1 : 0.2;
  //     options.sampleRate = 1;
  //     options.beforeSend = (event, _) {
  //       final currentPath = BaseRouter.locate.route;
  //       event.tags?[kKeysPath] = currentPath;
  //       return event;
  //     };
  //   },
  //   appRunner: () async {
  //     await AppSetup.initialise();
  //     return runApp(Phoenix(child: const MyApp()));
  //   },
  // );
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
        return ResponsiveBuilder(
          builder: (context, child, rTools, rData) => ResponsiveToolsProvider(
            rData: rData,
            rTools: rTools,
            child: LocalSettingsProvider(
              supportedLanguage: language,
              supportedThemeMode: themeMode,
              child: AnnotatedRegion(
                value: themeMode.systemUiOverlayStyle(context),
                child: Builder(
                  builder: (context) {
                    return MaterialApp.router(
                      routerConfig: BaseRouter.locate.coreRouter,
                      scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
                      scaffoldMessengerKey: FeedbackService.locate.scaffoldKey,
                      title: 'Placeholder',
                      debugShowCheckedModeBanner: false,
                      themeMode: themeMode.toThemeMode,
                      theme: ThemeData(
                        fontFamily: kValuesFontFamily,
                      ),
                      builder: (context, child) {
                        final media = MediaQuery.of(context);
                        final themeData = context.theme;
                        return Material(
                          color: context.tColors.background,
                          child: MediaQuery(
                            data: media.copyWith(
                              textScaler: TextScaler.noScaling,
                            ),
                            child: Theme(
                              data: themeData.copyWith(
                                scaffoldBackgroundColor: context.tColors.background,
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
              ),
            ),
          ),
        );
      },
    );
  }
}
