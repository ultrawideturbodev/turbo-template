import 'package:shadcn_flutter/shadcn_flutter.dart';

class HoverBuilder extends StatefulWidget {
  const HoverBuilder({
    super.key,
    required this.builder,
    this.isActive = true,
    this.child,
  });

  final Widget Function(
    BuildContext context,
    bool isHovered,
    Widget? child,
  ) builder;
  final bool isActive;
  final Widget? child;

  @override
  HoverBuilderState createState() => HoverBuilderState();
}

class HoverBuilderState extends State<HoverBuilder> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) => widget.isActive
      ? MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) {
            setState(
              () {
                isHovered = true;
              },
            );
          },
          onExit: (_) {
            setState(() {
              isHovered = false;
            });
          },
          child: widget.builder(context, isHovered, widget.child),
        )
      : widget.builder(context, isHovered, widget.child);
}
