import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/typography/extensions/text_style_extension.dart';
import 'package:turbo_template/ui/constants/k_widgets.dart';
import 'package:turbo_template/ui/enums/emoji.dart';
import 'package:turbo_template/ui/widgets/bottom_safe_area.dart';
import 'package:turbo_template/ui/widgets/t_leading.dart';
import 'package:turbo_template/ui/widgets/t_margin.dart';
import 'package:turbo_template/ui/widgets/t_card.dart';
import 'package:turbo_template/ui/widgets/t_gap.dart';
import 'package:turbo_template/ui/widgets/t_scaffold.dart';
import 'package:turbo_template/ui/widgets/t_scroll_view.dart';
import 'package:veto/data/models/base_view_model.dart';

import '../../../ui/widgets/device_type_builder.dart';
import 'verify_email_view_model.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({
    super.key,
  });

  static const String path = 'verify-email';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyEmailViewModel>(
      builder: (context, model, isInitialised, child) {
        if (!isInitialised) return kWidgetsNothing;
        final buttons = Row(
          spacing: kSizesAppPadding,
          children: [
            Expanded(
                child: Button.secondary(child: const Text('Skip'), onPressed: model.onSkipPressed)),
            Expanded(
              child: ValueListenableBuilder<bool>(
                valueListenable: model.canCheckStatus,
                builder: (context, canCheckStatus, child) => Button.primary(
                  child: const Text('Check Status'),
                  onPressed: model.onCheckStatusPressed,
                ),
              ),
            ),
          ],
        );
        return TScaffold(
          footers: switch (context.data.isMobile) {
            true => [
                BottomSafeArea(
                  child: buttons,
                ),
              ],
            false => [],
          },
          child: DeviceTypeBuilder(
            onDesktop: (context, deviceType, child) => Center(child: child),
            onMobile: (context, deviceType, child) => child,
            child: TScrollView(
              child: TCardFlex(
                deviceType: context.deviceType,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TLeading.horizontal(
                      spacing: kSizesAppPaddingX0p5,
                      leading: Text(
                        Emoji.magicWand.toString(),
                        textAlign: TextAlign.left,
                        style: context.texts.cardTitle.copyWithCurrent(
                          fontSize: (cValue) => cValue * 0.75,
                        ),
                      ),
                      child: Expanded(
                        child: Text(
                          'Verify Email',
                          textAlign: TextAlign.left,
                          style: context.texts.cardTitle,
                        ),
                      ),
                    ),
                    const TGap.subtitle(),
                    Text(
                      'Please verify your email address to continue.',
                      style: context.texts.subtitle,
                      textAlign: TextAlign.left,
                    ),
                    if (!context.deviceType.isMobile)
                    TMargin.top(
                      child: Row(
                        spacing: kSizesAppPadding,
                        children: [
                          Expanded(
                              child: Button.secondary(
                                  child: const Text('Skip'), onPressed: model.onSkipPressed)),
                          Expanded(
                            child: ValueListenableBuilder<bool>(
                              valueListenable: model.canCheckStatus,
                              builder: (context, canCheckStatus, child) => Button.primary(
                                child: const Text('Check Status'),
                                onPressed: model.onCheckStatusPressed,
                              ),
                            ),
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
        );
      },
      viewModelBuilder: () => VerifyEmailViewModel.locate,
    );
  }
}
