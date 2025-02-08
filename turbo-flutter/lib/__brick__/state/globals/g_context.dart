import 'package:flutter/cupertino.dart';
import 'package:{{packageName.snakeCase()}}/routing/services/base_router_service.dart';

BuildContext? get gContext {
  final state = BaseRouterService.rootNavigatorKey.currentState;
  if (state == null) {
    return null;
  }
  return DisposableBuildContext<State<StatefulWidget>>(
          BaseRouterService.rootNavigatorKey.currentState!)
      .context;
}
