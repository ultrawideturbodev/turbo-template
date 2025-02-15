import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_firestore_api/abstracts/turbo_writeable.dart';
import 'package:turbo_response/turbo_response.dart';
import 'package:turbo_template/firebase/firestore/dtos/cloud_response_dto.dart';
import 'package:turbo_template/firebase/cloud_functions/enums/cloud_function_id.dart';
import 'package:turbo_template/localizations/globals/g_strings.dart';

abstract class CloudFunctionsApi with Loglytics {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions.instance;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<TurboResponse<T?>> callCloudFunction<T>({
    required CloudFunctionId cloudFunctionId,
    required TurboWriteable writeable,
  }) async {
    try {
      log.info('Calling cloud function: $cloudFunctionId');
      final response = await _firebaseFunctions
          .httpsCallableFromUrl(cloudFunctionId.url)
          .call(writeable.toJson());
      log.info('Successfully called cloud function: $cloudFunctionId');
      log.debug('Response data from cloud function: $cloudFunctionId: ${response.data}');
      final cloudResponse = CloudResponseDto.fromJson(response.data);
      final result = cloudFunctionId.fromJsonResult<T>(cloudResponse.result);
      log.info('Result: $result');
      if (cloudResponse.isSuccess) {
        return TurboResponse.success(
          result: result,
          message: cloudResponse.message,
          title: 'Success',
        );
      } else {
        return TurboResponse.failAsBool(
          title: 'Failed',
          message: cloudResponse.message,
        );
      }
    } catch (error, trace) {
      log.error(
        'Failed to call cloud function: $cloudFunctionId '
        'with name: ${cloudFunctionId.url}',
        error: error,
        stackTrace: trace,
      );
      return TurboResponse.failAsBool(
        title: 'Failed',
        message: gStrings.somethingWentWrong,
      );
    }
  }
}
