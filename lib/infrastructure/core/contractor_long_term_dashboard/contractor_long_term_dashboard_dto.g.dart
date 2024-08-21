// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contractor_long_term_dashboard_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContractorLongTermDashboardDtoImpl
    _$$ContractorLongTermDashboardDtoImplFromJson(Map<String, dynamic> json) =>
        _$ContractorLongTermDashboardDtoImpl(
          id: (json['id'] as num?)?.toInt(),
          role_lists_name: json['role_lists_name'] as String?,
          company_name: json['company_name'] as String?,
          post_id: (json['post_id'] as num?)?.toInt(),
          employer_post_user_id:
              (json['employer_post_user_id'] as num?)?.toInt(),
          listing_id: json['listing_id'] as String?,
          last_ago: json['last_ago'] as String?,
          distance: json['distance'] as String?,
          profile: json['profile'] as String?,
          job_type: json['job_type'] as String?,
          compensation_type: json['compensation_type'] as String?,
          shift_schedule_type: json['shift_schedule_type'] as String?,
          position: json['position'] as String?,
          specialties_list: json['specialties_list'] as String?,
          specialties_detail: json['specialties_detail'] as String?,
          industry_id: (json['industry_id'] as num?)?.toInt(),
          request: (json['request'] as num?)?.toInt(),
          urgent_action: (json['urgent_action'] as num?)?.toInt(),
          start_date: const DateTimeConverter()
              .fromJson((json['start_date'] as num?)?.toInt()),
          estimated_weekly_hours: const TimeConverter()
              .fromJson(json['estimated_weekly_hours'] as String?),
          end_date: const DateTimeConverter()
              .fromJson((json['end_date'] as num?)?.toInt()),
          total_vacancy: (json['total_vacancy'] as num?)?.toInt(),
          rate_hour: (json['rate_hour'] as num?)?.toDouble(),
          total_payable_hour: (json['total_payable_hour'] as num?)?.toInt(),
          number_of_vacancie: (json['number_of_vacancie'] as num?)?.toInt(),
          application_deadline: const DateTimeConverter()
              .fromJson((json['application_deadline'] as num?)?.toInt()),
          total_weeks: (json['total_weeks'] as num?)?.toInt(),
          applied_proposal_status:
              (json['applied_proposal_status'] as num?)?.toInt(),
          applied_date: (json['applied_date'] as num?)?.toInt(),
          offer_expires: const DateTimeConverter()
              .fromJson((json['offer_expires'] as num?)?.toInt()),
          total_months: (json['total_months'] as num?)?.toInt(),
          button: (json['button'] as num?)?.toInt(),
          last_request: (json['last_request'] as num?)?.toInt(),
          counter_proposal_button:
              (json['counter_proposal_button'] as num?)?.toInt(),
          latitude: (json['latitude'] as num?)?.toDouble(),
          offer_expires_status: json['offer_expires_status'] as bool?,
          location: json['location'] == null
              ? null
              : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
          deleteAt: json['deleteAt'] as bool?,
        );

Map<String, dynamic> _$$ContractorLongTermDashboardDtoImplToJson(
        _$ContractorLongTermDashboardDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role_lists_name': instance.role_lists_name,
      'company_name': instance.company_name,
      'post_id': instance.post_id,
      'employer_post_user_id': instance.employer_post_user_id,
      'listing_id': instance.listing_id,
      'last_ago': instance.last_ago,
      'distance': instance.distance,
      'profile': instance.profile,
      'job_type': instance.job_type,
      'compensation_type': instance.compensation_type,
      'shift_schedule_type': instance.shift_schedule_type,
      'position': instance.position,
      'specialties_list': instance.specialties_list,
      'specialties_detail': instance.specialties_detail,
      'industry_id': instance.industry_id,
      'request': instance.request,
      'urgent_action': instance.urgent_action,
      'start_date': const DateTimeConverter().toJson(instance.start_date),
      'estimated_weekly_hours':
          const TimeConverter().toJson(instance.estimated_weekly_hours),
      'end_date': const DateTimeConverter().toJson(instance.end_date),
      'total_vacancy': instance.total_vacancy,
      'rate_hour': instance.rate_hour,
      'total_payable_hour': instance.total_payable_hour,
      'number_of_vacancie': instance.number_of_vacancie,
      'application_deadline':
          const DateTimeConverter().toJson(instance.application_deadline),
      'total_weeks': instance.total_weeks,
      'applied_proposal_status': instance.applied_proposal_status,
      'applied_date': instance.applied_date,
      'offer_expires': const DateTimeConverter().toJson(instance.offer_expires),
      'total_months': instance.total_months,
      'button': instance.button,
      'last_request': instance.last_request,
      'counter_proposal_button': instance.counter_proposal_button,
      'latitude': instance.latitude,
      'offer_expires_status': instance.offer_expires_status,
      'location': instance.location,
      'deleteAt': instance.deleteAt,
    };
