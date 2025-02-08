import '../../../environment/enums/environment.dart';

enum CloudFunctionId {
  acceptHouseholdInvite,
  removeHouseholdMember;

  String get url {
    switch (Environment.current) {
      case EnvironmentType.emulators:
        const host = 'localhost:5001';
        return switch (this) {
          CloudFunctionId.acceptHouseholdInvite =>
            'http://$host/the-roomy-app/europe-west3/acceptHouseholdInvite',
          CloudFunctionId.removeHouseholdMember =>
            'http://$host/the-roomy-app/europe-west3/removeHouseholdMember',
        };
      case EnvironmentType.prod:
        const host = 'jtyrbpbxqa-ey.a.run.app';
        return switch (this) {
          CloudFunctionId.acceptHouseholdInvite => 'https://accepthouseholdinvite-$host',
          CloudFunctionId.removeHouseholdMember => 'https://removehouseholdmember-$host',
        };
    }
  }

  T? Function<T>(
    Map<String, dynamic>? json,
  ) get fromJsonResult {
    switch (this) {
      case CloudFunctionId.acceptHouseholdInvite:
      case CloudFunctionId.removeHouseholdMember:
        return <T>(Map<String, dynamic>? json) => null;
    }
  }
}
