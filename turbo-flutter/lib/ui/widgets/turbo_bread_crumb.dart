import 'dart:ui';

extension TurboBreadCrumbExtension on TurboBreadCrumb {
  String? get pText {
    switch (this) {
      case TurboTextCrumb():
        return (this as TurboTextCrumb).text;
      case TurboMoreDotsCrumb():
        return null;
    }
  }
}

sealed class TurboBreadCrumb {
  const TurboBreadCrumb({
    this.onPressed,
  });

  final VoidCallback? onPressed;
}

class TurboTextCrumb extends TurboBreadCrumb {
  const TurboTextCrumb({
    required this.text,
    super.onPressed,
  });

  final String text;
}

class TurboMoreDotsCrumb extends TurboBreadCrumb {
  const TurboMoreDotsCrumb();
}
