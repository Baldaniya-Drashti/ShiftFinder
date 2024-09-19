// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_dashboard_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployerDashboardDTOImpl _$$EmployerDashboardDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployerDashboardDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      shift_type: (json['shift_type'] as num?)?.toInt(),
      listing_id: json['listing_id'] as String?,
      roles_list: (json['roles_list'] as List<dynamic>?)
          ?.map((e) => RolesList.fromJson(e as Map<String, dynamic>))
          .toList(),
      roles_list_name: json['roles_list_name'] as String?,
      company_name: json['company_name'] as String?,
      last_ago: json['last_ago'] as String?,
      industry: (json['industry'] as num?)?.toInt(),
      distance: json['distance'] as String?,
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      shift_date: (json['shift_date'] as List<dynamic>?)
          ?.map((e) => ShiftDate.fromJson(e as Map<String, dynamic>))
          .toList(),
      start_date: (json['start_date'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_date: (json['end_date'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      total_shift: (json['total_shift'] as num?)?.toInt(),
      total_application_counts:
          (json['total_application_counts'] as num?)?.toInt(),
      total_application_profiles:
          json['total_application_profiles'] as List<dynamic>?,
      total_proposal_counts: (json['total_proposal_counts'] as num?)?.toInt(),
      total_proposal_profiles:
          json['total_proposal_profiles'] as List<dynamic>?,
      specialties_list: json['specialties_list'] as String?,
      rate_hour: (json['rate_hour'] as num?)?.toInt(),
      total_payable_hour: json['total_payable_hour'] as String?,
      total_vacancy: (json['total_vacancy'] as num?)?.toInt(),
      accommodation_allowance:
          (json['accommodation_allowance'] as num?)?.toInt(),
      commute_allowance: (json['commute_allowance'] as num?)?.toInt(),
      total_amount: (json['total_amount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$EmployerDashboardDTOImplToJson(
        _$EmployerDashboardDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shift_type': instance.shift_type,
      'listing_id': instance.listing_id,
      'roles_list': instance.roles_list,
      'roles_list_name': instance.roles_list_name,
      'company_name': instance.company_name,
      'last_ago': instance.last_ago,
      'industry': instance.industry,
      'distance': instance.distance,
      'location': instance.location,
      'shift_date': instance.shift_date,
      'start_date': instance.start_date,
      'start_time': instance.start_time,
      'end_date': instance.end_date,
      'end_time': instance.end_time,
      'total_shift': instance.total_shift,
      'total_application_counts': instance.total_application_counts,
      'total_application_profiles': instance.total_application_profiles,
      'total_proposal_counts': instance.total_proposal_counts,
      'total_proposal_profiles': instance.total_proposal_profiles,
      'specialties_list': instance.specialties_list,
      'rate_hour': instance.rate_hour,
      'total_payable_hour': instance.total_payable_hour,
      'total_vacancy': instance.total_vacancy,
      'accommodation_allowance': instance.accommodation_allowance,
      'commute_allowance': instance.commute_allowance,
      'total_amount': instance.total_amount,
    };

_$RolesListImpl _$$RolesListImplFromJson(Map<String, dynamic> json) =>
    _$RolesListImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$RolesListImplToJson(_$RolesListImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) =>
    _$LocationImpl(
      id: (json['id'] as num?)?.toInt(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      location: json['location'] as String?,
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'location': instance.location,
    };

_$ShiftDateImpl _$$ShiftDateImplFromJson(Map<String, dynamic> json) =>
    _$ShiftDateImpl(
      start_date: (json['start_date'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_date: (json['end_date'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ShiftDateImplToJson(_$ShiftDateImpl instance) =>
    <String, dynamic>{
      'start_date': instance.start_date,
      'start_time': instance.start_time,
      'end_date': instance.end_date,
      'end_time': instance.end_time,
    };
