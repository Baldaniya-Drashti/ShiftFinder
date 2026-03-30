// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankDTOImpl _$$BankDTOImplFromJson(Map<String, dynamic> json) =>
    _$BankDTOImpl(
      account_number: json['account_number'] as String?,
      full_account_number: json['full_account_number'] as String?,
      transit_number: json['transit_number'] as String?,
      institution_number: json['institution_number'] as String?,
      account_type: json['account_type'] as String?,
      role_lists_name: json['role_lists_name'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      dob: (json['dob'] as num?)?.toInt(),
      bank_address: json['bank_address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postal_code: json['postal_code'] as String?,
      country: json['country'] as String?,
      country_code: json['country_code'] as String?,
      status: (json['status'] as num?)?.toInt(),
      bank_name: json['bank_name'] as String?,
      job_title: json['job_title'] as String?,
      phone: json['phone'] as String?,
      country_flag: json['country_flag'] as String?,
    );

Map<String, dynamic> _$$BankDTOImplToJson(_$BankDTOImpl instance) =>
    <String, dynamic>{
      'account_number': instance.account_number,
      'full_account_number': instance.full_account_number,
      'transit_number': instance.transit_number,
      'institution_number': instance.institution_number,
      'account_type': instance.account_type,
      'role_lists_name': instance.role_lists_name,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'dob': instance.dob,
      'bank_address': instance.bank_address,
      'city': instance.city,
      'state': instance.state,
      'postal_code': instance.postal_code,
      'country': instance.country,
      'country_code': instance.country_code,
      'status': instance.status,
      'bank_name': instance.bank_name,
      'job_title': instance.job_title,
      'phone': instance.phone,
      'country_flag': instance.country_flag,
    };
