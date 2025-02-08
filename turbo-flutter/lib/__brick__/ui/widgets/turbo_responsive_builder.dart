import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:{{packageName.snakeCase()}}/ui/extensions/box_constraints_extension.dart';
import 'package:{{packageName.snakeCase()}}/state/extensions/context_extension.dart';
import 'package:{{packageName.snakeCase()}}/ui/models/turbo_data.dart';
import 'package:{{packageName.snakeCase()}}/ui/utils/turbo_tools.dart';

class TurboResponsiveBuilder extends StatelessWidget {
  const TurboResponsiveBuilder({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(
    BuildContext context,
    Widget? child,
    BoxConstraints constraints,
    TurboTools tools,
    TurboData data,
  ) builder;

  final Widget? child;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => builder(
          context,
          child,
          constraints,
          context.tools.copyWith(
            currentWidth: constraints.maxWidth,
            currentHeight: constraints.maxHeight,
          ),
          context.data.copyWith(
            currentWidth: constraints.maxWidth,
            currentHeight: constraints.maxHeight,
            deviceType: constraints.turboDeviceType(
              breakpointConfig: context.breakpointConfig,
            ),
            orientation: constraints.turboOrientation,
          ),
        ),
      );
}
