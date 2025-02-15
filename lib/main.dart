import 'dart:async';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:loglytics/loglytics.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_durations.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/http/services/connection_service.dart';
import 'package:turbo_template/localizations/services/language_service.dart';
import 'package:turbo_template/localizations/strings/gen/l10n.dart';
import 'package:turbo_template/routing/services/base_router_service.dart';
import 'package:turbo_template/state/config/app_setup.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/state/widgets/is_busy_icon.dart';
import 'package:turbo_template/state/widgets/value_listenable_builder_x2.dart';
import 'package:turbo_template/state/widgets/value_listenable_builder_x3.dart';
import 'package:turbo_template/ui/config/no_thumb_scroll_behaviour.dart';
import 'package:turbo_template/ui/config/turbo_breakpoint_config.dart';
import 'package:turbo_template/ui/constants/k_widgets.dart';
import 'package:turbo_template/ui/extensions/box_constraints_extension.dart';
import 'package:turbo_template/ui/services/theme_service.dart';
import 'package:turbo_template/ui/widgets/t_provider_builder.dart';
import 'package:veto/data/models/busy_model.dart';
import 'package:veto/services/busy_service.dart';

void main() {
  runZonedGuarded(
    () async {
      await AppSetup.initialise();
      runApp(Phoenix(child: const MyApp()));
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
    const turboBreakpointConfig = TBreakpointConfig();
    final themeService = ThemeService.locate;
    final languageService = LanguageService.locate;
    final constraints = BoxConstraints(maxWidth: context.maxWidth, maxHeight: context.maxHeight);
    final deviceType = constraints.turboDeviceType(breakpointConfig: turboBreakpointConfig);
    return ValueListenableBuilderX3(
      valueListenable: themeService.themeModeListenable,
      valueListenable2: themeService.themeListenable,
      valueListenable3: languageService.language,
      builder: (context, turboThemeMode, theme, language, _) {
        return AnnotatedRegion(
          value: turboThemeMode.systemUiOverlayStyle,
          child: ShadcnApp.router(
            theme: themeService.lightTheme(deviceType: deviceType),
            darkTheme: themeService.darkTheme(deviceType: deviceType),
            themeMode: turboThemeMode.themeMode,
            routerConfig: BaseRouterService.locate.coreRouter,
            scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              final media = MediaQuery.of(context);
              return MediaQuery(
                data: media.copyWith(
                  textScaler: TextScaler.noScaling,
                ),
                child: TProviderBuilder(
                  key: ValueKey(turboThemeMode.themeMode),
                  turboTheme: themeService.theme,
                  turboBreakpointConfig: turboBreakpointConfig,
                  supportedLanguage: language,
                  turboThemeMode: turboThemeMode,
                  builder: (deviceType, themeMode, theme, tools, data, texts, colors, sizes,
                          decorations, context) =>
                      Overlay(
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
                                            opacity: busyModel.isBusy ? kSizesOpacityDisabled : 1,
                                            child: IgnorePointer(
                                              ignoring: busyModel.isBusy || !hasInternetConnection,
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
          ),
        );
      },
    );
  }
}
