import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/constants/k_widgets.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';
import 'package:turbo_template/turbo/widgets/cards/turbo_card.dart';
import 'package:turbo_template/turbo/widgets/layout/turbo_scaffold.dart';
import 'package:turbo_template/turbo/widgets/t_gap.dart';
import 'package:turbo_template/turbo/widgets/turbo_scroll_view.dart';
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
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: kSizesDialogMaxWidth,
              ),
              child: TurboScrollView(
                child: TurboCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Verify Email',
                        textAlign: TextAlign.left,
                        style: context.texts.cardTitle,
                      ),
                      const TGap.subtitle(),
                      Text(
                        'Please verify your email address to continue.',
                        style: context.texts.cardSubtitle,
                        textAlign: TextAlign.left,
                      ),
                      const TGap.element(),
                      Row(
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
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
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
