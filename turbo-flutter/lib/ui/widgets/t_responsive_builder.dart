import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/extensions/box_constraints_extension.dart';
import 'package:turbo_template/ui/models/t_data.dart';
import 'package:turbo_template/ui/utils/t_tools.dart';

class TResponsiveBuilder extends StatelessWidget {
  const TResponsiveBuilder({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(
    BuildContext context,
    Widget? child,
    BoxConstraints constraints,
    TTools tools,
    TData data,
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
