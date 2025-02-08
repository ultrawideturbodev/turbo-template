import 'package:shadcn_flutter/shadcn_flutter.dart';

extension BoolExtensionExtension on bool {
  CheckboxState get checkboxState {
    switch (this) {
      case true:
        return CheckboxState.checked;
      case false:
        return CheckboxState.unchecked;
    }
  }
}
