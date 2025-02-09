import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/constants/k_widgets.dart';
import 'package:turbo_template/ui/widgets/bottom_safe_area.dart';
import 'package:turbo_template/ui/widgets/leading_icon.dart';
import 'package:turbo_template/ui/widgets/margin.dart';
import 'package:turbo_template/ui/widgets/turbo_card.dart';
import 'package:turbo_template/ui/widgets/turbo_gap.dart';
import 'package:turbo_template/ui/widgets/turbo_scaffold.dart';
import 'package:turbo_template/ui/widgets/turbo_scroll_view.dart';
import 'package:veto/data/models/base_view_model.dart';

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
        return TurboScaffold(
          footers: switch (context.data.isMobile) {
            true => [
                BottomSafeArea(
                  child: Row(
                    children: [
                      Button.secondary(child: const Text('Skip'), onPressed: model.onSkipPressed),
                      const Spacer(),
                      ValueListenableBuilder<bool>(
                        valueListenable: model.canCheckStatus,
                        builder: (context, canCheckStatus, child) => Button.primary(
                          child: const Text('Check Status'),
                          onPressed: model.onCheckStatusPressed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            false => [],
          },
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: kSizesDialogMaxWidth,
            ),
            child: TurboScrollView(
              child: Margin.horizontal(
                child: Column(
                  children: [
                    TurboCard(
                      type: TChildCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            LeadingIcon(
                              iconData: BootstrapIcons.envelope,
                              size: 32,
                              child: Margin.left(
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
                          ],
                          mainAxisSize: MainAxisSize.min,
                        ),
                      ),
                    ),
                  ],
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
