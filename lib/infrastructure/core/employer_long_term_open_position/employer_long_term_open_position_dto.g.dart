// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_long_term_open_position_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployerLongTermOpenPositionDtoImpl
    _$$EmployerLongTermOpenPositionDtoImplFromJson(Map<String, dynamic> json) =>
        _$EmployerLongTermOpenPositionDtoImpl(
          id: (json['id'] as num?)?.toInt(),
          listing_id: json['listing_id'] as String?,
          roles_list_name: json['roles_list_name'] as String?,
          last_ago: json['last_ago'] as String?,
          industry: (json['industry'] as num?)?.toInt(),
          location: json['location'] == null
              ? null
              : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
          start_date: const DateTimeConverter()
              .fromJson((json['start_date'] as num?)?.toInt()),
          end_date: const DateTimeConverter()
              .fromJson((json['end_date'] as num?)?.toInt()),
          application_deadline: const DateTimeConverter()
              .fromJson((json['application_deadline'] as num?)?.toInt()),
          number_of_vacancie: (json['number_of_vacancie'] as num?)?.toInt(),
          pending_vacancie: (json['pending_vacancie'] as num?)?.toInt(),
          total_application_counts:
              (json['total_application_counts'] as num?)?.toInt(),
          total_application_profiles: (json['total_application_profiles']
                  as List<dynamic>?)
              ?.map(
                  (e) => ApplicationProfile.fromJson(e as Map<String, dynamic>))
              .toList(),
          isEditable: json['isEditable'] as bool?,
        );

Map<String, dynamic> _$$EmployerLongTermOpenPositionDtoImplToJson(
        _$EmployerLongTermOpenPositionDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listing_id': instance.listing_id,
      'roles_list_name': instance.roles_list_name,
      'last_ago': instance.last_ago,
      'industry': instance.industry,
      'location': instance.location,
      'start_date': const DateTimeConverter().toJson(instance.start_date),
      'end_date': const DateTimeConverter().toJson(instance.end_date),
      'application_deadline':
          const DateTimeConverter().toJson(instance.application_deadline),
      'number_of_vacancie': instance.number_of_vacancie,
      'pending_vacancie': instance.pending_vacancie,
      'total_application_counts': instance.total_application_counts,
      'total_application_profiles': instance.total_application_profiles,
      'isEditable': instance.isEditable,
    };
