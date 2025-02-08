import 'package:{{packageName.snakeCase()}}/routing/abstracts/view_arguments.dart';
import 'package:{{packageName.snakeCase()}}/data/constants/k_keys.dart';

class PlaceholderArguments extends ViewArguments {
  PlaceholderArguments({required this.id});

  final String? id;

  @override
  Map<String, dynamic> toMap() => {
        kKeysId: id,
      };

  factory PlaceholderArguments.fromMap(Map<String, dynamic> map) => PlaceholderArguments(
        id: map[kKeysId] as String,
      );
}
