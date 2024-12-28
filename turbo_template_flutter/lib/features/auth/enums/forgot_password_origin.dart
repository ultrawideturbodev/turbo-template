import '../../../core/extensions/string_extension.dart';
import '../../../core/globals/g_strings.dart';
import '../views/forgot_password/forgot_password_view.dart';

enum ForgotPasswordOrigin {
  core,
  account,
  ;

  String get path {
    switch (this) {
      case ForgotPasswordOrigin.core:
        return ForgotPasswordView.path.asRootPath;
      case ForgotPasswordOrigin.account:
        return ForgotPasswordView.path;
    }
  }

  String get title {
    switch (this) {
      case ForgotPasswordOrigin.core:
        return gStrings.forgotPassword;
      case ForgotPasswordOrigin.account:
        return gStrings.changePassword;
    }
  }
}
