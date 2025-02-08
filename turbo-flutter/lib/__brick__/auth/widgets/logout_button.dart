import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:{{packageName.snakeCase()}}/state/typedefs/context_def.dart';
import 'package:{{packageName.snakeCase()}}/ui/widgets/opacity_button.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key, required this.onPressed}) : super(key: key);

  final NamedContextDef onPressed;

  @override
  Widget build(BuildContext context) => OpacityButton(
        child: const Icon(
          Icons.logout_rounded,
        ),
        onPressed: () => onPressed(context: context),
      );
}
