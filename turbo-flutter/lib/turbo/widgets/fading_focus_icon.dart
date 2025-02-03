import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/k_durations.dart';

class FadingFocusIcon extends StatelessWidget {
  FadingFocusIcon({
    required FocusNode focusNode,
    required IconData icon,
    required Color color,
    String? svgLocation,
    super.key,
  })  : _focusNode = focusNode,
        _icon = icon,
        _color = color,
        _svgLocation = svgLocation;

  final FocusNode _focusNode;
  final IconData _icon;
  final Color _color;
  final String? _svgLocation;
  late final Color _alphaColor = _color.withAlpha(80);

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: _focusNode,
        builder: (context, child) => AnimatedSwitcher(
          duration: kDurationsAnimationX0p5,
          child: _svgLocation != null
              ? SvgPicture.asset(
                  _svgLocation,
                  key: ValueKey(_focusNode.hasFocus),
                  colorFilter: ColorFilter.mode(
                    _focusNode.hasFocus ? _color : _alphaColor,
                    BlendMode.srcIn,
                  ),
                )
              : Icon(
                  key: ValueKey(_focusNode.hasFocus),
                  _icon,
                  size: 16,
                  color: !_focusNode.hasFocus ? _alphaColor : _color,
                ),
        ),
      );
}
