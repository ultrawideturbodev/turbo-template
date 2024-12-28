import 'package:cloud_firestore_api/abstracts/firestore_logger.dart';
import 'package:cloud_firestore_api/data/models/sensitive_data.dart';
import 'package:loglytics/loglytics.dart';

class JsonStoreLogger implements FirestoreLogger {
  JsonStoreLogger({
    required String location,
  }) : _log = Log(location: location);

  final Log _log;

  @override
  void error({
    required String message,
    Object? error,
    StackTrace? stackTrace,
    required SensitiveData? sensitiveData,
  }) {
    _log.error(message, error: error, stackTrace: stackTrace);
    if (sensitiveData != null) {
      _log.error(sensitiveData.toString());
    }
  }

  @override
  void info({
    required String message,
    SensitiveData? sensitiveData,
  }) {
    _log.info(message);
    if (sensitiveData != null) {
      _log.info(sensitiveData.toString());
    }
  }

  @override
  void success({
    required String message,
    SensitiveData? sensitiveData,
  }) {
    _log.info(message);
    if (sensitiveData != null) {
      _log.info(sensitiveData.toString());
    }
  }

  @override
  void warning({
    required String message,
    SensitiveData? sensitiveData,
  }) {
    _log.warning(message);
    if (sensitiveData != null) {
      _log.warning(sensitiveData.toString());
    }
  }
}
