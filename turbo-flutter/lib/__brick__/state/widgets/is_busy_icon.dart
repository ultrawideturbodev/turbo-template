import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:veto/data/enums/busy_type.dart';
import 'package:veto/data/models/busy_model.dart';

import '../../ui/constants/k_widgets.dart';
import '../../animations/widgets/fade_in.dart';

class IsBusyIcon extends StatelessWidget {
  const IsBusyIcon({
    required this.busyModel,
    this.isNotBusyWidget,
    this.height = 80,
    this.fontSize,
    this.padding = 48,
    super.key,
  });

  final Widget? isNotBusyWidget;
  final double height;
  final BusyModel busyModel;
  final double? fontSize;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final isBusy = busyModel.isBusy;
    final busyType = busyModel.busyType;
    return FadeIn(
      fadeIn: isBusy,
      fadeInChild: RepaintBoundary(
        child: Stack(
          fit: StackFit.expand,
          children: [
            switch (busyType) {
              BusyType.none => kWidgetsNothing,
              BusyType.indicator => kWidgetsNothing,
              BusyType.indicatorIgnorePointer => kWidgetsNothing,
              BusyType.indicatorBackdrop => IgnorePointer(
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              BusyType.indicatorBackdropIgnorePointer => Container(
                  color: Colors.black.withOpacity(0.3),
                ),
            },
            switch (busyType) {
              BusyType.none => kWidgetsNothing,
              (_) => const Center(
                  child: CircularProgressIndicator(
                    size: 32,
                  ),
                ),
            },
          ],
        ),
      ),
      fadeOutChild: isNotBusyWidget,
    );
  }
}
