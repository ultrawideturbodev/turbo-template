import 'dart:ui';

extension TCrumbExtension on TCrumb {
  String? get pText {
    switch (this) {
      case TCrumbText():
        return (this as TCrumbText).text;
      case TCrumbDots():
        return null;
    }
  }
}

sealed class TCrumb {
  const TCrumb({
    this.onPressed,
  });

  final VoidCallback? onPressed;
}

class TCrumbText extends TCrumb {
  const TCrumbText({
    required this.text,
    super.onPressed,
  });

  final String text;
}

class TCrumbDots extends TCrumb {
  const TCrumbDots();
}
