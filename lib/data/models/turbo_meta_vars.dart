/// A model class that holds metadata values for Turbo templates.
///
/// Contains identifying information and timestamps for tracking template data:
/// - [userId]: ID of the user who owns/created the template
/// - [now]: Timestamp of when the template was created/modified
class TurboMetaVars {
  /// Creates a new [TurboMetaVars] instance with the required metadata.
  const TurboMetaVars({
    required this.userId,
    required this.now,
  });

  /// ID of the user who owns/created this template.
  final String userId;

  /// Timestamp of when this template was created/modified.
  final DateTime now;
}
