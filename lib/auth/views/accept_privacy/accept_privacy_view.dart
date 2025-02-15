import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/ui/constants/k_widgets.dart';
import 'package:veto/data/models/base_view_model.dart';

import 'accept_privacy_view_model.dart';

class AcceptPrivacyView extends StatelessWidget {
  const AcceptPrivacyView({
    super.key,
  });

  static const String path = 'accept-privacy';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AcceptPrivacyViewModel>(
      builder: (context, model, isInitialised, child) {
        if (!isInitialised) return kWidgetsNothing;
        return const Scaffold(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [],
            ),
          ),
        );
      },
      viewModelBuilder: () => AcceptPrivacyViewModel.locate,
    );
  }
}
