// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hired_contractor_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HiredContractorListDTOImpl _$$HiredContractorListDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$HiredContractorListDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      user_id: (json['user_id'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      profile: json['profile'] as String?,
      contractor_shift_type: (json['contractor_shift_type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$HiredContractorListDTOImplToJson(
        _$HiredContractorListDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'profile': instance.profile,
      'contractor_shift_type': instance.contractor_shift_type,
    };
