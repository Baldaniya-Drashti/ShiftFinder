// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_long_full_term_dashboard_dto.dart';

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
          position: json['position'] as String?,
          shift_schedule_type: json['shift_schedule_type'] as String?,
          industry: (json['industry'] as num?)?.toInt(),
          job_type: (json['job_type'] as num?)?.toInt(),
          location: json['location'] == null
              ? null
              : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
          start_date: const DateTimeConverter()
              .fromJson((json['start_date'] as num?)?.toInt()),
          end_date: const DateTimeConverter()
              .fromJson((json['end_date'] as num?)?.toInt()),
          application_deadline: const DateTimeConverter()
              .fromJson((json['application_deadline'] as num?)?.toInt()),
          estimated_weekly_hours: const TimeConverter()
              .fromJson(json['estimated_weekly_hours'] as String?),
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
          user: (json['user'] as List<dynamic>?)
              ?.map((e) => UserDto.fromJson(e as Map<String, dynamic>))
              .toList(),
          total_user: (json['total_user'] as num?)?.toInt(),
          hired_user: (json['hired_user'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$EmployerLongTermOpenPositionDtoImplToJson(
        _$EmployerLongTermOpenPositionDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listing_id': instance.listing_id,
      'roles_list_name': instance.roles_list_name,
      'last_ago': instance.last_ago,
      'position': instance.position,
      'shift_schedule_type': instance.shift_schedule_type,
      'industry': instance.industry,
      'job_type': instance.job_type,
      'location': instance.location,
      'start_date': const DateTimeConverter().toJson(instance.start_date),
      'end_date': const DateTimeConverter().toJson(instance.end_date),
      'application_deadline':
          const DateTimeConverter().toJson(instance.application_deadline),
      'estimated_weekly_hours':
          const TimeConverter().toJson(instance.estimated_weekly_hours),
      'number_of_vacancie': instance.number_of_vacancie,
      'pending_vacancie': instance.pending_vacancie,
      'total_application_counts': instance.total_application_counts,
      'total_application_profiles': instance.total_application_profiles,
      'isEditable': instance.isEditable,
      'user': instance.user,
      'total_user': instance.total_user,
      'hired_user': instance.hired_user,
    };

_$UserDtoImpl _$$UserDtoImplFromJson(Map<String, dynamic> json) =>
    _$UserDtoImpl(
      user_id: (json['user_id'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      profile: json['profile'] as String?,
    );

Map<String, dynamic> _$$UserDtoImplToJson(_$UserDtoImpl instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'profile': instance.profile,
    };
