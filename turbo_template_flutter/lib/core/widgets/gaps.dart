import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../constants/k_sizes.dart';

class GapFormField extends StatelessWidget {
  const GapFormField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Gap(kSizesFormFieldGap);
}

class GapAppPadding extends StatelessWidget {
  const GapAppPadding({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Gap(kSizesAppPadding);
}

class GapSection extends StatelessWidget {
  const GapSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Gap(kSizesSectionGap);
}
