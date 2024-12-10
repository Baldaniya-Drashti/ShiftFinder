// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_invoice_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployerInvoiceDTOImpl _$$EmployerInvoiceDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployerInvoiceDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      post_id: (json['post_id'] as num?)?.toInt(),
      employer_id: (json['employer_id'] as num?)?.toInt(),
      employer_profile: json['employer_profile'] as String?,
      employer_company_name: json['employer_company_name'] as String?,
      industry: (json['industry'] as num?)?.toInt(),
      listing_id: json['listing_id'] as String?,
      location: json['location'] == null
          ? null
          : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
      contractor_first_name: json['contractor_first_name'] as String?,
      contractor_email: json['contractor_email'] as String?,
      contractor_last_name: json['contractor_last_name'] as String?,
      contractor_location: json['contractor_location'] as String?,
      shift_type: json['shift_type'] as String?,
      roles_list_name: json['roles_list_name'] as String?,
      date: (json['date'] as num?)?.toInt(),
      total_payable_hours: json['total_payable_hours'] as String?,
      hourly_rate: (json['hourly_rate'] as num?)?.toInt(),
      total_wage: json['total_wage'] as String?,
      shiftfinder_service_fee: json['shiftfinder_service_fee'] as String?,
      total_allowance: json['total_allowance'] as String?,
      total_amount_payble: json['total_amount_payble'] as String?,
    );

Map<String, dynamic> _$$EmployerInvoiceDTOImplToJson(
        _$EmployerInvoiceDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.post_id,
      'employer_id': instance.employer_id,
      'employer_profile': instance.employer_profile,
      'employer_company_name': instance.employer_company_name,
      'industry': instance.industry,
      'listing_id': instance.listing_id,
      'location': instance.location,
      'contractor_first_name': instance.contractor_first_name,
      'contractor_email': instance.contractor_email,
      'contractor_last_name': instance.contractor_last_name,
      'contractor_location': instance.contractor_location,
      'shift_type': instance.shift_type,
      'roles_list_name': instance.roles_list_name,
      'date': instance.date,
      'total_payable_hours': instance.total_payable_hours,
      'hourly_rate': instance.hourly_rate,
      'total_wage': instance.total_wage,
      'shiftfinder_service_fee': instance.shiftfinder_service_fee,
      'total_allowance': instance.total_allowance,
      'total_amount_payble': instance.total_amount_payble,
    };
