import 'package:flutter/cupertino.dart';
import 'package:turbo_template/turbo/routing/base_router.dart';

BuildContext? get gContext {
  final state = BaseRouter.rootNavigatorKey.currentState;
  if (state == null) {
    return null;
  }
  return DisposableBuildContext<State<StatefulWidget>>(BaseRouter.rootNavigatorKey.currentState!)
      .context;
}
