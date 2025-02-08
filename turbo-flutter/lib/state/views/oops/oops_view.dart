import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:veto/data/models/base_view_model.dart';

import '../../../ui/constants/k_widgets.dart';
import 'oops_view_model.dart';

class OopsView extends StatelessWidget {
  const OopsView({
    super.key,
  });

  static const String path = 'oops';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OopsViewModel>(
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
      viewModelBuilder: () => OopsViewModel.locate,
    );
  }
}
