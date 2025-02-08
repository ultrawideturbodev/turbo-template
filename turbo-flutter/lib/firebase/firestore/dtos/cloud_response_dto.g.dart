// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloudResponseDto _$CloudResponseDtoFromJson(Map<String, dynamic> json) =>
    CloudResponseDto(
      result: CloudResponseDto._castMapToStringDynamic(json['result']),
      message: json['message'] as String?,
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$CloudResponseDtoToJson(CloudResponseDto instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
      'statusCode': instance.statusCode,
    };
