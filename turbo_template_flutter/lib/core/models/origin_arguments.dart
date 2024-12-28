import '../abstracts/view_arguments.dart';

class OriginArguments<Origin, Arguments extends ViewArguments> {
  const OriginArguments({
    required this.origin,
    required this.data,
  });

  final Origin origin;
  final Arguments data;
}
