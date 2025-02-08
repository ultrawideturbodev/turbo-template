import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:provider/provider.dart';

import '../services/user_service.dart';

class UserProvider extends StatelessWidget {
  final Widget child;

  const UserProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Provider.value(
        value: UserService.locate,
        child: child,
      );
}

class UserBuilder extends StatelessWidget {
  const UserBuilder({
    required this.builder,
    super.key,
    this.child,
    this.listenableBuilder,
  });

  final Listenable? Function(UserService userService)? listenableBuilder;
  final Widget Function(BuildContext context, UserService userService, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final userService = context.read<UserService>();
    return ListenableBuilder(
      listenable: listenableBuilder?.call(userService) ?? userService.listenable,
      builder: (context, child) => builder(context, userService, child),
      child: child,
    );
  }
}

class UserProviderBuilder extends StatelessWidget {
  const UserProviderBuilder({
    required this.builder,
    super.key,
    this.child,
    this.listenableBuilder,
  });

  final Listenable? Function(UserService userService)? listenableBuilder;
  final Widget Function(BuildContext context, UserService userService, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) => UserProvider(
        child: UserBuilder(
          builder: builder,
          child: child,
          listenableBuilder: listenableBuilder,
        ),
      );
}
