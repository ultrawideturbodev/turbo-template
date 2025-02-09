import 'package:flutter_animate/flutter_animate.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/animations/widgets/animated_enabled.dart';
import 'package:turbo_template/animations/widgets/shrinks.dart';
import 'package:turbo_template/auth/views/create_username/create_username_view_model.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/forms/widgets/form_field_text.dart';
import 'package:turbo_template/localizations/globals/g_strings.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/typography/extensions/text_style_extension.dart';
import 'package:turbo_template/ui/constants/k_widgets.dart';
import 'package:turbo_template/ui/enums/emoji.dart';
import 'package:turbo_template/ui/enums/turbo_device_type.dart';
import 'package:turbo_template/ui/widgets/bottom_position.dart';
import 'package:turbo_template/ui/widgets/bottom_safe_area.dart';
import 'package:turbo_template/ui/widgets/device_type_builder.dart';
import 'package:turbo_template/ui/widgets/fading_scrollable.dart';
import 'package:turbo_template/ui/widgets/leading.dart';
import 'package:turbo_template/ui/widgets/turbo_card.dart';
import 'package:turbo_template/ui/widgets/turbo_gap.dart';
import 'package:turbo_template/ui/widgets/turbo_scroll_view.dart';
import 'package:veto/data/models/base_view_model.dart';
import 'package:veto/data/models/busy_model.dart';
import 'package:turbo_template/ui/widgets/turbo_scaffold.dart';

import '../../../ui/widgets/margin.dart';

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
        final textStyle = context.texts.cardTitle;
        final deviceType = context.deviceType;
        return TurboScaffold(
          footers: switch (deviceType) {
            TurboDeviceType.mobile => [
                BottomSafeArea(
                  child: Button.primary(
                    child: Text(gStrings.save),
                    onPressed: () => model.save(context: context),
                    focusNode: model.saveButtonFocusNode,
                  ),
                ),
              ],
            TurboDeviceType.tablet || TurboDeviceType.desktop => [],
          },
          child: DeviceTypeBuilder(
            onDesktop: (context, deviceType, child) => Center(child: child),
            onMobile: (context, deviceType, child) => child,
            child: TurboScrollView(
              child: TurboDeviceTypeCard(
                deviceType: deviceType,
                type: TChildCard(
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
                                Leading.horizontal(
                                  leading: Text(
                                    Emoji.wavingHand.toString(),
                                    style: textStyle.copyWithCurrent(
                                      fontSize: (cValue) => cValue * 0.75,
                                    ),
                                  ),
                                  spacing: kSizesAppPaddingX0p5,
                                  child: Text(
                                    gStrings.helloUsername(username),
                                    style: textStyle,
                                  ),
                                ),
                                const TGap.subtitle(),
                                VerticalShrink(
                                  show: username == model.usernamePlaceholder,
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Margin.bottom(
                                        bottom: kSizesAppPadding * 0.5,
                                        child: Text(
                                          gStrings.whatNameSuitsYouBest,
                                          style: context.texts.subtitle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const TGap.appPadding(multiplier: 0.5),
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
                                          child:
                                              usernameIsAvailableNullSafe && model.usernameIsValid
                                                  ? Container(
                                                      height: kSizesButtonHeight,
                                                      alignment: Alignment.center,
                                                      margin: const EdgeInsets.only(
                                                        left: kSizesAppPadding,
                                                        right: kSizesAppPaddingX0p5,
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
                                                        right: kSizesAppPaddingX0p5,
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
                          if (!deviceType.isMobile)
                          Margin.top(
                            child: Button.primary(
                              child: Text(gStrings.save),
                              onPressed: () => model.save(context: context),
                              focusNode: model.saveButtonFocusNode,
                            ),
                          ),
                        ],
                        mainAxisSize: MainAxisSize.min,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => CreateUsernameViewModel.locate,
    );
  }
}
