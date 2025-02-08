import 'package:{{packageName.snakeCase()}}/data/globals/g_now.dart';
import 'package:{{packageName.snakeCase()}}/data/globals/g_user_id.dart';
import 'package:{{packageName.snakeCase()}}/data/models/turbo_meta_vars.dart';

TurboMetaVars gMetaVars = TurboMetaVars(userId: gUserId, now: gNow);
