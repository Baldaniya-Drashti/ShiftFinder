// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contractor_dashboard_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContactorDashboardDTOImpl _$$ContactorDashboardDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$ContactorDashboardDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      shift_type: (json['shift_type'] as num?)?.toInt(),
      same_or_different_time: (json['same_or_different_time'] as num?)?.toInt(),
      listing_id: json['listing_id'] as String?,
      roles_list: (json['roles_list'] as List<dynamic>?)
          ?.map((e) => RolesList.fromJson(e as Map<String, dynamic>))
          .toList(),
      roles_list_name: json['roles_list_name'] as String?,
      company_name: json['company_name'] as String?,
      last_ago: json['last_ago'] as String?,
      unpaid_break: json['unpaid_break'] == null
          ? null
          : SkillDTO.fromJson(json['unpaid_break'] as Map<String, dynamic>),
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
      total_application_profiles: (json['total_application_profiles']
              as List<dynamic>?)
          ?.map((e) => ApplicationProfile.fromJson(e as Map<String, dynamic>))
          .toList(),
      total_proposal_counts: (json['total_proposal_counts'] as num?)?.toInt(),
      total_proposal_profiles: (json['total_proposal_profiles']
              as List<dynamic>?)
          ?.map((e) => ApplicationProfile.fromJson(e as Map<String, dynamic>))
          .toList(),
      specialties_list: json['specialties_list'] as String?,
      specialties_details: json['specialties_details'] as String?,
      rate_hour: json['rate_hour'] as num?,
      total_payable_hour: json['total_payable_hour'] as String?,
      total_vacancy: (json['total_vacancy'] as num?)?.toInt(),
      accommodation_allowance: json['accommodation_allowance'] as String?,
      commute_allowance: json['commute_allowance'] as String?,
      total_amount: json['total_amount'] as String?,
      total_wage: json['total_wage'] as String?,
      total_allowance: json['total_allowance'] as String?,
      isHighlightShift: json['isHighlightShift'] as bool?,
      total_amount_payable_contractor:
          json['total_amount_payable_contractor'] as String?,
    );

Map<String, dynamic> _$$ContactorDashboardDTOImplToJson(
        _$ContactorDashboardDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shift_type': instance.shift_type,
      'same_or_different_time': instance.same_or_different_time,
      'listing_id': instance.listing_id,
      'roles_list': instance.roles_list,
      'roles_list_name': instance.roles_list_name,
      'company_name': instance.company_name,
      'last_ago': instance.last_ago,
      'unpaid_break': instance.unpaid_break,
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
      'specialties_details': instance.specialties_details,
      'rate_hour': instance.rate_hour,
      'total_payable_hour': instance.total_payable_hour,
      'total_vacancy': instance.total_vacancy,
      'accommodation_allowance': instance.accommodation_allowance,
      'commute_allowance': instance.commute_allowance,
      'total_amount': instance.total_amount,
      'total_wage': instance.total_wage,
      'total_allowance': instance.total_allowance,
      'isHighlightShift': instance.isHighlightShift,
      'total_amount_payable_contractor':
          instance.total_amount_payable_contractor,
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
      facility_type: json['facility_type'] == null
          ? null
          : FacilityTypeDto.fromJson(
              json['facility_type'] as Map<String, dynamic>),
      facility_type_other: json['facility_type_other'] as String?,
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'location': instance.location,
      'facility_type': instance.facility_type,
      'facility_type_other': instance.facility_type_other,
    };

_$ShiftDateImpl _$$ShiftDateImplFromJson(Map<String, dynamic> json) =>
    _$ShiftDateImpl(
      start_date: (json['start_date'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_date: (json['end_date'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      date: (json['date'] as num?)?.toInt(),
      unpaid_break: json['unpaid_break'] == null
          ? null
          : SkillDTO.fromJson(json['unpaid_break'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ShiftDateImplToJson(_$ShiftDateImpl instance) =>
    <String, dynamic>{
      'start_date': instance.start_date,
      'start_time': instance.start_time,
      'end_date': instance.end_date,
      'end_time': instance.end_time,
      'date': instance.date,
      'unpaid_break': instance.unpaid_break,
    };

_$ApplicationProfileImpl _$$ApplicationProfileImplFromJson(
        Map<String, dynamic> json) =>
    _$ApplicationProfileImpl(
      id: (json['id'] as num?)?.toInt(),
      profile: json['profile'] as String?,
    );

Map<String, dynamic> _$$ApplicationProfileImplToJson(
        _$ApplicationProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profile': instance.profile,
    };
