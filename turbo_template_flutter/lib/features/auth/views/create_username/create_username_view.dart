import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:veto/data/models/base_view_model.dart';
import 'package:veto/data/models/busy_model.dart';

import '../../../../core/constants/k_sizes.dart';
import '../../../../core/constants/k_widgets.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/widgets/animated_enabled.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../../../core/widgets/form_field_text.dart';
import '../../../../core/widgets/gaps/form_field_gap.dart';
import '../../../../core/widgets/shrinks.dart';
import '../../../../core/widgets/trailing_icon.dart';
import '../../../../core/widgets/tu_button.dart';
import 'create_username_view_model.dart';

// TODO(codaveto): Add strings to language file | 13/11/2024
class CreateUsernameView extends StatelessWidget {
  const CreateUsernameView({
    super.key,
  });

  static const String path = 'create-username';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateUsernameViewModel>(
      builder: (context, model, isInitialised, child) {
        if (!isInitialised) return kWidgetsNothing;
        final textStyle = context.texts.createUserNameTitle;
        return CustomScaffold(
          body: isInitialised
              ? SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ValueListenableBuilder<BusyModel>(
                        valueListenable: model.isBusyListenable,
                        builder: (context, busyModel, child) => AnimatedEnabled(
                          isEnabled: !busyModel.isBusy,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ValueListenableBuilder<String>(
                                valueListenable: model.username,
                                builder: (context, username, child) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const FormFieldGap(),
                                    Text(
                                      '👋 Hello @$username',
                                      style: textStyle,
                                    ),
                                    const FormFieldGap(),
                                    VerticalShrink(
                                      show: username == model.usernamePlaceholder,
                                      alignment: Alignment.topCenter,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 16),
                                            child: Text(
                                              'What name suits you best?',
                                              style: context.texts.formField,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: FormFieldText(
                                            formFieldConfig: model.usernameField,
                                            fadingFocusIcon: Icons.badge_rounded,
                                            hintText: 'Username',
                                            onSubmitted: (_) => model.save(context: context),
                                            onChanged: model.onUserNameChanged,
                                          ),
                                        ),
                                        ValueListenableBuilder<bool?>(
                                          valueListenable: model.usernameIsAvailable,
                                          builder: (context, userNameIsAvailable, child) {
                                            final usernameIsAvailableNullSafe =
                                                userNameIsAvailable ?? false;
                                            return HorizontalShrink(
                                              alignment: Alignment.centerRight,
                                              show: userNameIsAvailable != null &&
                                                  username != model.usernamePlaceholder,
                                              child: usernameIsAvailableNullSafe
                                                  ? Container(
                                                      height: kSizesButtonHeight,
                                                      alignment: Alignment.center,
                                                      margin: const EdgeInsets.only(
                                                        left: kSizesAppPadding,
                                                        right: kSizesAppPadding,
                                                      ),
                                                      child: Transform.translate(
                                                        offset: const Offset(0, 4),
                                                        child: Text('✅', style: textStyle),
                                                      ),
                                                    )
                                                      .animate(key: const ValueKey('check'))
                                                      .fade()
                                                      .then()
                                                      .shake()
                                                  : Container(
                                                      height: kSizesButtonHeight,
                                                      alignment: Alignment.center,
                                                      margin: const EdgeInsets.only(
                                                        left: kSizesAppPadding,
                                                        right: kSizesAppPadding,
                                                      ),
                                                      child: Transform.translate(
                                                        offset: const Offset(0, 4),
                                                        child: Text('❌', style: textStyle),
                                                      ),
                                                    )
                                                      .animate(key: const ValueKey('close'))
                                                      .fade()
                                                      .then()
                                                      .shake(),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const FormFieldGap(),
                              TuButton.primary(
                                text: '''Save''',
                                onPressed: () => model.save(context: context),
                                trailingIcon: (backgroundColor, textColor) => TrailingIcon(
                                  Icons.arrow_forward,
                                  color: textColor,
                                ),
                                focusNode: model.saveButtonFocusNode,
                              ),
                            ],
                            mainAxisSize: MainAxisSize.min,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        );
      },
      viewModelBuilder: () => CreateUsernameViewModel.locate,
    );
  }
}
