// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contractor_wallet_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContractorWalletDTOImpl _$$ContractorWalletDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$ContractorWalletDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toDouble(),
      type: (json['type'] as num?)?.toInt(),
      company_name: json['company_name'] as String?,
      filter_name: json['filter_name'] as String?,
      created: (json['created'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ContractorWalletDTOImplToJson(
        _$ContractorWalletDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'type': instance.type,
      'company_name': instance.company_name,
      'filter_name': instance.filter_name,
      'created': instance.created,
    };
