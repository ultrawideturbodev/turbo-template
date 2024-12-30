import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:turbo_template/core/constants/k_widgets.dart';
import 'package:turbo_template/core/extensions/context_extension.dart';
import 'package:turbo_template/core/globals/g_strings.dart';
import 'package:turbo_template/core/widgets/bottom_position.dart';
import 'package:turbo_template/core/widgets/fading_scrollable.dart';
import 'package:turbo_template/core/widgets/tu_button.dart';
import 'package:turbo_template/core/widgets/turbo_scaffold.dart';
import 'package:turbo_template/features/auth/views/create_username/create_username_view_model.dart';
import 'package:veto/data/models/base_view_model.dart';
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
        return TurboScaffold(
          body: isInitialised
              ? FadingScrollable(
            foregroundContent: BottomPositioned(
              child: TurboButton.primary(
                text: gStrings.save,
                width: double.infinity,
                onPressed: () => model.save(context: context),
                trailingIcon: (backgroundColor, textColor) => TrailingIcon(
                  Icons.arrow_forward,
                  color: textColor,
                ),
                focusNode: model.saveButtonFocusNode,
              ),
            ),
            child: TurboScrollView(
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
                              const ItemGap(),
                              Text(
                                gStrings.helloUsername(username),
                                style: textStyle,
                              ),
                              const ItemGap(),
                              VerticalShrink(
                                show: username == model.usernamePlaceholder,
                                alignment: Alignment.topCenter,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: Text(
                                        gStrings.whatNameSuitsYouBest,
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
                                      hintText: gStrings.username,
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
                                          child: Text('✅', style: textStyle),
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
                                          child: Text('❌', style: textStyle),
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
