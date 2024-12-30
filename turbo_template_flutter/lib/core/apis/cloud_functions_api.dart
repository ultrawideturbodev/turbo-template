import 'package:cloud_firestore_api/abstracts/writeable.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:feedback_response/feedback_response.dart';
import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/core/dtos/cloud_response_dto.dart';
import 'package:turbo_template/core/enums/cloud_functions_api.dart';

class CloudFunctionsApi extends CloudFunctionsApiInterface {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static CloudFunctionsApi get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(CloudFunctionsApi.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\
}

abstract class CloudFunctionsApiInterface with Loglytics {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions.instance;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<FeedbackResponse<T>> callCloudFunction<T>({
    required CloudFunctionId cloudFunctionId,
    required Writeable writeable,
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
        return FeedbackResponse.successNone(result: result);
      } else {
        return FeedbackResponse.errorNone(
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
      return FeedbackResponse.errorNone();
    }
  }
}
