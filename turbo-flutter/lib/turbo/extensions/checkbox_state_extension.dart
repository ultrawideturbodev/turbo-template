import 'package:shadcn_flutter/shadcn_flutter.dart';

extension CheckboxStateExtensionExtension on CheckboxState {
  bool get toBool {
    switch (this) {
      case CheckboxState.checked:
        return true;
      case CheckboxState.unchecked:
      case CheckboxState.indeterminate:
        return false;
    }
  }
}
