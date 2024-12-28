import 'package:flutter/widgets.dart';

import '../../constants/k_sizes.dart';
import 'tu_divider.dart';

class FormFieldDivider extends StatelessWidget {
  const FormFieldDivider({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const TuDivider(
        topPadding: kSizesFormFieldGap,
        bottomPadding: 16,
      );
}
