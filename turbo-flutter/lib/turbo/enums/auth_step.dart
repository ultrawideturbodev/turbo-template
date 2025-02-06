import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum AuthStep {
  createUserDoc,
  acceptPrivacy,
  createSettingsDoc,
  // TODO(brian): Create default username, ask for display name instead | 06/02/2025
  createUsernameDoc,
  createProfileDoc,
  verifyEmail,
  ;

  static const first = createUserDoc;

  AuthStep? get next {
    final index = AuthStep.values.indexOf(this);
    if (index == AuthStep.values.length - 1) return null;
    return AuthStep.values[index + 1];
  }
}
