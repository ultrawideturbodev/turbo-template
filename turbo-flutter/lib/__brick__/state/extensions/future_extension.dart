import '../../data/constants/k_durations.dart';

extension FutureExtension<T> on Future<T> {
  Future<T> withTimeout({
    Duration? duration,
    String? message,
  }) async =>
      timeout(
        kDurationsTimeOut,
        onTimeout: message == null ? null : () => Future<T>.error(message),
      );
}
