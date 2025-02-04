import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../widgets/size_reporter.dart';
import 'color_extension.dart';

extension WidgetExtension on Widget {
  Widget get withWhiteDebug => withDebug(color: Colors.white, label: 'White');
  Widget get withRedDebug => withDebug(color: Colors.red, label: 'Red');
  Widget get withGreenDebug => withDebug(color: Colors.green, label: 'Green');
  Widget get withBlueDebug => withDebug(color: Colors.blue, label: 'Blue');
  Widget get withYellowDebug => withDebug(color: Colors.yellow, label: 'Yellow');
  Widget get withPurpleDebug => withDebug(color: Colors.purple, label: 'Purple');
  Widget get withOrangeDebug => withDebug(color: Colors.orange, label: 'Orange');
  Widget get withPinkDebug => withDebug(color: Colors.pink, label: 'Pink');
  Widget get withCyanDebug => withDebug(color: Colors.cyan, label: 'Cyan');
  Widget get withTealDebug => withDebug(color: Colors.teal, label: 'Teal');

  Widget withDebug({Color? color, String? label}) {
    final iColor = color ?? Colors.blue;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: iColor.withOpacity(0.75),
          child: SizeReporter(
            child: this,
            onSizeChanged: (size) {
              if (kDebugMode) {
                print(
                  '''[🐛] [PRINT] [🌟] [with${label}Debug] [📞] [height]: ${size.height} [width]: ${size.width}''',
                );
              }
            },
          ),
        ),
        // center dot
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: iColor.onColor,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
