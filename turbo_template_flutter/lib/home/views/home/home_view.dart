import 'package:flutter/material.dart';
import 'package:veto/data/models/base_view_model.dart';

import '../../../core/constants/k_sizes.dart';
import '../../../core/constants/k_widgets.dart';
import '../../../core/widgets/custom_scaffold.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  static const String path = 'home';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>(
      builder: (context, model, isInitialised, child) {
        if (!isInitialised) return kWidgetsNothing;
        return const CustomScaffold(
          buttonHeight: kSizesButtonHeight,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [],
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel.locate,
    );
  }
}
