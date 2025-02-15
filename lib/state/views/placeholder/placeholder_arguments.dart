import 'package:turbo_template/routing/abstracts/view_arguments.dart';
import 'package:turbo_template/data/constants/k_keys.dart';

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
