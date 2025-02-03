import 'dart:async';

import 'package:feedback_response/feedback_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../constants/k_durations.dart';
import '../extensions/completer_extension.dart';
import '../routing/base_router.dart';
import '../utils/mutex.dart';
import '../widgets/custom_notification.dart';

class NotificationService with Loglytics {
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final BaseRouter _baseRouter = BaseRouter.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\

  Completer? _completer;
  final _mutex = Mutex();

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<void> showNotification({
    BuildContext? context,
    required String title,
    String? message,
    FeedbackLevel feedbackLevel = FeedbackLevel.info,
  }) async {
    await _completer?.future;
    await _mutex.lockAndRun(
      run: (unlock) async {
        try {
          _completer = Completer();
          Timer(
            2000.milliseconds,
            () {
              _completer!.completeIfNotComplete();
            },
          );
          final localContext = context ?? _baseRouter.context;
          showTopSnackBar(
            Overlay.of(localContext),
            padding: EdgeInsets.zero,
            animationDuration: kDurationsAnimationX2,
            displayDuration: kDurationsAnimationX2,
            snackBarPosition: SnackBarPosition.top,
            curve: Curves.linearToEaseOut,
            dismissType: DismissType.none,
            IgnorePointer(
              child: CustomNotification(
                feedbackLevel: feedbackLevel,
                title: title,
              ),
            ),
          );
        } catch (error, stackTrace) {
          log.error(
            'Unexpected ${error.runtimeType} caught while showing notification',
            error: error,
            stackTrace: stackTrace,
          );
        } finally {
          unlock();
        }
      },
    );
  }

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static NotificationService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(() => NotificationService());
}
