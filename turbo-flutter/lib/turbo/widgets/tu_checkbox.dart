import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:informers/informer.dart';

import '../constants/k_durations.dart';
import '../constants/k_svgs.dart';
import '../extensions/color_extension.dart';
import '../extensions/context_extension.dart';
import '../globals/g_vibrate.dart';
import 'scale_button.dart';

class TuCheckbox extends StatelessWidget {
  TuCheckbox({
    required this.child,
    Informer<bool>? isCheckedNotifier,
    Informer<bool>? mutuallyExclusiveNotifier,
    bool? initialValue,
    this.color = Colors.green,
    this.size = 20,
    this.uncheckedColor = Colors.transparent,
    this.animationDuration = kDurationsAnimationX0p5,
    this.checkedCurve = Curves.easeInOut,
    this.uncheckedCurve = Curves.easeInOut,
    this.onChanged,
    this.padding,
    this.hitBoxPadding,
    this.borderRadius,
    Key? key,
  })  : _isChecked = isCheckedNotifier ?? Informer(initialValue ?? false),
        _mutuallyExclusiveNotifier = mutuallyExclusiveNotifier,
        super(key: key);

  factory TuCheckbox.check({
    Informer<bool>? isCheckedNotifier,
    Informer<bool>? mutuallyExclusiveNotifier,
    ValueChanged<bool?>? onChanged,
    EdgeInsets? hitBoxPadding,
    EdgeInsets? padding,
    Color? color,
    bool? initialValue,
    double size = 20,
    Key? key,
    Color uncheckedColor = Colors.transparent,
    BorderRadius? borderRadius,
  }) {
    final localColor = color ?? Colors.green;
    return TuCheckbox(
      child: SvgPicture.asset(
        kSvgsCheck,
        colorFilter: ColorFilter.mode(localColor.onColor, BlendMode.srcIn),
      ),
      color: localColor,
      uncheckedColor: uncheckedColor,
      padding: padding ?? const EdgeInsets.all(3),
      isCheckedNotifier: isCheckedNotifier,
      mutuallyExclusiveNotifier: mutuallyExclusiveNotifier,
      onChanged: onChanged,
      hitBoxPadding: hitBoxPadding,
      initialValue: initialValue,
      size: size,
      borderRadius: borderRadius,
      key: key,
    );
  }

  factory TuCheckbox.cross({
    Informer<bool>? isCheckedNotifier,
    Informer<bool>? mutuallyExclusiveNotifier,
    ValueChanged<bool?>? onChanged,
    EdgeInsets? hitBoxPadding,
    EdgeInsets? padding,
    Color? color,
    bool? initialValue,
    double size = 20,
    Key? key,
    BorderRadius? borderRadius,
  }) =>
      TuCheckbox(
        child: SvgPicture.asset(kSvgsHyphen),
        color: color ?? Colors.red,
        padding: padding ?? const EdgeInsets.all(2),
        isCheckedNotifier: isCheckedNotifier,
        mutuallyExclusiveNotifier: mutuallyExclusiveNotifier,
        onChanged: onChanged,
        hitBoxPadding: hitBoxPadding,
        initialValue: initialValue,
        size: size,
        borderRadius: borderRadius,
        key: key,
      );

  final Widget child;
  final Color color;
  final double size;
  final Informer<bool> _isChecked;
  final Informer<bool>? _mutuallyExclusiveNotifier;
  final Color uncheckedColor;
  final Duration animationDuration;
  final Curve checkedCurve;
  final Curve uncheckedCurve;
  final ValueChanged<bool?>? onChanged;
  final EdgeInsets? padding;
  final EdgeInsets? hitBoxPadding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isChecked,
      builder: (_, isChecked, __) {
        final animatedContainer = AnimatedContainer(
          duration: animationDuration,
          curve: isChecked ? checkedCurve : uncheckedCurve,
          height: size,
          width: size,
          padding: padding,
          decoration: BoxDecoration(
            color: isChecked ? color : uncheckedColor,
            border: isChecked
                ? null
                : Border.all(
                    color: context.colors.border,
                    width: 1,
                  ),
            borderRadius: borderRadius ?? BorderRadius.circular(10),
          ),
          child: AnimatedScale(
            scale: isChecked ? 1 : 0,
            duration: animationDuration,
            curve: isChecked ? checkedCurve : uncheckedCurve,
            child: AnimatedOpacity(
              opacity: isChecked ? 1 : 0,
              duration: animationDuration,
              curve: isChecked ? checkedCurve : uncheckedCurve,
              child: child,
            ),
          ),
        ).animate(target: isChecked ? 1 : 0).shake(duration: kDurationsAnimation);
        return ScaleButton(
          onPressed: () {
            _isChecked.update(!_isChecked.value);
            final isChecked = _isChecked.value;
            onChanged?.call(isChecked);
            if (isChecked && (_mutuallyExclusiveNotifier?.value == isChecked)) {
              _mutuallyExclusiveNotifier!.update(!isChecked);
            }
            gVibrateSelection();
          },
          child: hitBoxPadding == null
              ? animatedContainer
              : Padding(
                  padding: hitBoxPadding!,
                  child: animatedContainer,
                ),
        );
      },
    );
  }
}
