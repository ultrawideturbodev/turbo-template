import 'package:flutter_animate/flutter_animate.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/auth/views/create_username/create_username_view_model.dart';
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/constants/k_widgets.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';
import 'package:turbo_template/turbo/globals/g_strings.dart';
import 'package:turbo_template/turbo/widgets/animated_enabled.dart';
import 'package:turbo_template/turbo/widgets/bottom_position.dart';
import 'package:turbo_template/turbo/widgets/fading_scrollable.dart';
import 'package:turbo_template/turbo/widgets/form_field_text.dart';
import 'package:turbo_template/turbo/widgets/shrinks.dart';
import 'package:turbo_template/turbo/widgets/t_gap.dart';
import 'package:turbo_template/turbo/widgets/turbo_scroll_view.dart';
import 'package:veto/data/models/base_view_model.dart';
import 'package:veto/data/models/busy_model.dart';

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
        final textStyle = context.texts.viewTitle;
        return Scaffold(
          child: isInitialised
              ? FadingScrollable(
            foregroundContent: BottomPositioned(
              child: PrimaryButton(
                child: Text(gStrings.save),
                onPressed: () => model.save(context: context),
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
                              const TGap.element(),
                              Text(
                                gStrings.helloUsername(username),
                                style: textStyle,
                              ),
                              const TGap.element(),
                              VerticalShrink(
                                show: username == model.usernamePlaceholder,
                                alignment: Alignment.topCenter,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: Text(
                                        gStrings.whatNameSuitsYouBest,
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
                                      leadingIcon: Icons.badge_rounded,
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
