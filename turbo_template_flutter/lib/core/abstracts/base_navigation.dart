import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loglytics/loglytics.dart';

import '../enums/navigation_tab.dart';
import '../routing/base_router.dart';
import '../services/navigation_tab_service.dart';
import 'view_arguments.dart';

abstract class BaseNavigation with Loglytics {
  final _baseRouter = BaseRouter.locate;
  final _navigationTabService = NavigationTabService.locate;

  String get root;
  NavigationTab? get navigationTab;
  NavigationTab get currentNavigationTab => _navigationTabService.navigationTab.value;

  void goBranch({
    required StatefulNavigationShell statefulNavigationShell,
  }) {
    final initialLocation = currentNavigationTab;
    statefulNavigationShell.goBranch(
      navigationTab!.branchIndex,
      initialLocation: switch (navigationTab!) {
        NavigationTab.home => initialLocation.isHome,
      },
    );
  }

  void go({
    required String location,
    List<ViewArguments>? extra,
    BuildContext? context,
  }) {
    log.debug('Going to route: $location');
    context == null
        ? _baseRouter.context.go(
            location,
            extra: extra?.toExtraArguments,
          )
        : context.go(
            location,
            extra: extra?.toExtraArguments,
          );
  }

  Future<T?> push<T>({
    required String location,
    List<ViewArguments>? extra,
    BuildContext? context,
  }) {
    log.info('Pushing route: $location');
    return context == null
        ? _baseRouter.context.push<T>(
            location,
            extra: extra?.toExtraArguments,
          )
        : context.push<T?>(
            location,
            extra: extra?.toExtraArguments,
          );
  }

  void pushReplacement({
    required String location,
    List<ViewArguments>? extra,
    BuildContext? context,
  }) {
    log.info('Pushing route: $location');
    return context == null
        ? _baseRouter.context.pushReplacement(
            location,
            extra: extra?.toExtraArguments,
          )
        : context.pushReplacement(
            location,
            extra: extra?.toExtraArguments,
          );
  }

  bool canPop({BuildContext? context}) {
    log.debug('Checking if route can pop');
    final canPop = context == null ? _baseRouter.context.canPop() : context.canPop();
    log.info('Can pop: $canPop');
    return canPop;
  }
}
