import 'package:get_it/get_it.dart';

import '../../core/abstracts/base_navigation.dart';
import '../../core/enums/navigation_tab.dart';
import '../../core/extensions/string_extension.dart';
import '../views/accept_privacy/accept_privacy_view.dart';
import '../views/create_username/create_username_view.dart';
import '../views/verify_email/verify_email_view.dart';

class AuthStepRouter extends BaseNavigation {
  @override
  String get root => '/';

  @override
  NavigationTab? get navigationTab => null;

  void goAcceptPrivacyView() => go(
        location: AcceptPrivacyView.path.asRootPath,
      );

  void goVerifyEmailView() => go(
        location: VerifyEmailView.path.asRootPath,
      );

  void goCreateUsernameView() => go(
        location: CreateUsernameView.path.asRootPath,
      );

  static AuthStepRouter get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(AuthStepRouter.new);
}
