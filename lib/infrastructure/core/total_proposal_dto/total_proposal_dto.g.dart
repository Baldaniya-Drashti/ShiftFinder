// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_proposal_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TotalProposalDtoImpl _$$TotalProposalDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$TotalProposalDtoImpl(
      data: json['data'] == null
          ? null
          : TotalProposalDataDto.fromJson(json['data'] as Map<String, dynamic>),
      additional_data: json['additional_data'] == null
          ? null
          : TotalProposalAdditionalDataDto.fromJson(
              json['additional_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TotalProposalDtoImplToJson(
        _$TotalProposalDtoImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'additional_data': instance.additional_data,
    };

_$TotalProposalAdditionalDataDtoImpl
    _$$TotalProposalAdditionalDataDtoImplFromJson(Map<String, dynamic> json) =>
        _$TotalProposalAdditionalDataDtoImpl(
          id: (json['id'] as num?)?.toInt(),
          role_lists_name: json['role_lists_name'] as String?,
          industry: (json['industry'] as num?)?.toInt(),
          profile: json['profile'] as String?,
          listing_id: json['listing_id'] as String?,
          last_ago: json['last_ago'] as String?,
          location: json['location'] == null
              ? null
              : Location.fromJson(json['location'] as Map<String, dynamic>),
          start_date: (json['start_date'] as num?)?.toInt(),
          start_time: (json['start_time'] as num?)?.toInt(),
          end_time: (json['end_time'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$TotalProposalAdditionalDataDtoImplToJson(
        _$TotalProposalAdditionalDataDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role_lists_name': instance.role_lists_name,
      'industry': instance.industry,
      'profile': instance.profile,
      'listing_id': instance.listing_id,
      'last_ago': instance.last_ago,
      'location': instance.location,
      'start_date': instance.start_date,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
    };

_$TotalProposalDataDtoImpl _$$TotalProposalDataDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$TotalProposalDataDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      profile: json['profile'] as String?,
    );

Map<String, dynamic> _$$TotalProposalDataDtoImplToJson(
        _$TotalProposalDataDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'profile': instance.profile,
    };
