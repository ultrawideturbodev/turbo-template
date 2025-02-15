import 'package:json_annotation/json_annotation.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/data/extensions/int_extension.dart';

part 'cloud_response_dto.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class CloudResponseDto {
  const CloudResponseDto({
    this.result,
    this.message,
    required this.statusCode,
  });

  @JsonKey(fromJson: _castMapToStringDynamic)
  final Map<String, dynamic>? result;

  final String? message;
  final int statusCode;

  bool get isSuccess => statusCode.isSuccessfulStatusCode;

  static Map<String, dynamic>? _castMapToStringDynamic(Object? object) {
    try {
      if (object == null) return null;
      if (object is Map) {
        return object.map((key, value) {
          if (key is String) {
            return MapEntry(key, value);
          }
          throw ArgumentError('Failed to cast map key to String');
        });
      }
      throw ArgumentError('Failed to cast to map of <String, dynamic>');
    } catch (error, stackTrace) {
      Log(location: 'CloudResponseDto').error(
        'Unexpected ${error.runtimeType} caught while casting to map of <String, dynamic>',
        error: error,
        stackTrace: stackTrace,
      );
    }
    return null;
  }

  static const fromJsonFactory = _$CloudResponseDtoFromJson;
  factory CloudResponseDto.fromJson(Map<String, dynamic> json) => _$CloudResponseDtoFromJson(json);
  static const toJsonFactory = _$CloudResponseDtoToJson;
  Map<String, dynamic> toJson() => _$CloudResponseDtoToJson(this);
}
