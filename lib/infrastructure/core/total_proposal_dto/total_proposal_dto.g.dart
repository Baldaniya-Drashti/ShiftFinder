// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_proposal_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TotalProposalDtoImpl _$$TotalProposalDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$TotalProposalDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      profile: json['profile'] as String?,
      user_id: (json['user_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TotalProposalDtoImplToJson(
        _$TotalProposalDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'profile': instance.profile,
      'user_id': instance.user_id,
    };
