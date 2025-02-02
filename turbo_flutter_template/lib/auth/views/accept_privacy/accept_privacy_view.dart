import 'package:flutter/material.dart';
import 'package:veto/data/models/base_view_model.dart';

import 'package:turbo_template/turbo/constants/k_widgets.dart';
import 'package:turbo_template/turbo/widgets/custom_scaffold.dart';
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
        return const CustomScaffold(
          body: SingleChildScrollView(
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
