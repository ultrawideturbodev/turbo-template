import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../constants/k_durations.dart';
import '../extensions/context_extension.dart';
import 'multi_listenable_builder.dart';
import 'shrinks.dart';

class FormFieldError extends StatelessWidget {
  const FormFieldError({
    required ValueListenable<String?> errorText,
    required ValueListenable<bool> shouldValidate,
    this.leftPadding = 10,
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
            padding: EdgeInsets.only(top: topPadding),
            child: Row(
              children: [
                SizedBox(width: leftPadding),
                Flexible(
                  child: Text(
                    _errorText.value ?? '',
                    style: context.t.texts.formFieldError,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
