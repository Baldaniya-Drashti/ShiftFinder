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
      contractor_location: json['contractor_location'] == null
          ? null
          : LocationDTO.fromJson(
              json['contractor_location'] as Map<String, dynamic>),
      shift_type: json['shift_type'] as String?,
      roles_list_name: json['roles_list_name'] as String?,
      date: (json['date'] as num?)?.toInt(),
      total_payable_hours: json['total_payable_hours'] as String?,
      hourly_rate: (json['hourly_rate'] as num?)?.toDouble(),
      total_wage: json['total_wage'] as String?,
      shiftfinder_service_fee: json['shiftfinder_service_fee'] as String?,
      total_allowance: json['total_allowance'] as String?,
      total_amount_payble: json['total_amount_payble'] as String?,
      invoice_no: (json['invoice_no'] as num?)?.toInt(),
      total_amount_payable_contractor:
          (json['total_amount_payable_contractor'] as num?)?.toDouble(),
      third_party_fee: json['third_party_fee'] as String?,
      third_party_tax_fee: json['third_party_tax_fee'] as String?,
      clock_in_clock_out: json['clock_in_clock_out'] == null
          ? null
          : InvoiceClockInOutDTO.fromJson(
              json['clock_in_clock_out'] as Map<String, dynamic>),
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
      'invoice_no': instance.invoice_no,
      'total_amount_payable_contractor':
          instance.total_amount_payable_contractor,
      'third_party_fee': instance.third_party_fee,
      'third_party_tax_fee': instance.third_party_tax_fee,
      'clock_in_clock_out': instance.clock_in_clock_out,
    };

_$InvoiceClockInOutDTOImpl _$$InvoiceClockInOutDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$InvoiceClockInOutDTOImpl(
      clock_in: (json['clock_in'] as num?)?.toInt(),
      clock_out: (json['clock_out'] as num?)?.toInt(),
      total_shift_hours: json['total_shift_hours'] as String?,
      unpaid_break: json['unpaid_break'] == null
          ? null
          : InvoiceUnpaidBreakDTO.fromJson(
              json['unpaid_break'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$InvoiceClockInOutDTOImplToJson(
        _$InvoiceClockInOutDTOImpl instance) =>
    <String, dynamic>{
      'clock_in': instance.clock_in,
      'clock_out': instance.clock_out,
      'total_shift_hours': instance.total_shift_hours,
      'unpaid_break': instance.unpaid_break,
    };

_$InvoiceUnpaidBreakDTOImpl _$$InvoiceUnpaidBreakDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$InvoiceUnpaidBreakDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      short_name: json['short_name'] as String?,
      minute: (json['minute'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$InvoiceUnpaidBreakDTOImplToJson(
        _$InvoiceUnpaidBreakDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'short_name': instance.short_name,
      'minute': instance.minute,
    };
