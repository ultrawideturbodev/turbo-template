import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../data/constants/k_durations.dart';
import '../../state/extensions/context_extension.dart';
import '../../state/widgets/multi_listenable_builder.dart';
import '../../animations/widgets/shrinks.dart';

class TErrorLabel extends StatelessWidget {
  const TErrorLabel({
    required ValueListenable<String?> errorText,
    required ValueListenable<bool> shouldValidate,
    this.leftPadding = 8,
    this.topPadding = 8,
    super.key,
  })  : _errorText = errorText,
        _shouldValidate = shouldValidate;

  final ValueListenable<String?> _errorText;
  final ValueListenable<bool> _shouldValidate;
  final double leftPadding;
  final double topPadding;

  @override
  Widget build(BuildContext context) => MultiListenableBuilder(
        listenables: [_errorText, _shouldValidate],
        builder: (context, _, __) => VerticalShrink(
          alignment: Alignment.bottomCenter,
          fadeDuration: kDurationsAnimationX0p5,
          sizeDuration: kDurationsAnimationX0p5,
          show: _shouldValidate.value && (_errorText.value?.isNotEmpty ?? false),
          child: Padding(
            padding: EdgeInsets.only(
              top: topPadding,
              bottom: 4,
            ),
            child: Row(
              children: [
                SizedBox(width: leftPadding),
                Flexible(
                  child: Text(
                    _errorText.value ?? '',
                    style: context.texts.formFieldError,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
