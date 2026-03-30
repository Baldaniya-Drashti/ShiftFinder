// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_proposal_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployerProposalDtoImpl _$$EmployerProposalDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployerProposalDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      listing_id: json['listing_id'] as String?,
      user_id: (json['user_id'] as num?)?.toInt(),
      profile: json['profile'] as String?,
      last_ago: json['last_ago'] as String?,
      roles_list_name: json['roles_list_name'] as String?,
      industry: (json['industry'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      complete_shift: (json['complete_shift'] as num?)?.toInt(),
      pending_users: (json['pending_users'] as List<dynamic>?)
          ?.map((e) => EmployerProposalPendingUserDto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      location: json['location'] == null
          ? null
          : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
      distance: json['distance'] as String?,
      post_id: (json['post_id'] as num?)?.toInt(),
      proposal_type: (json['proposal_type'] as num?)?.toInt(),
      last_request: (json['last_request'] as num?)?.toInt(),
      revoke_status: (json['revoke_status'] as num?)?.toInt(),
      shift_type: (json['shift_type'] as num?)?.toInt(),
      same_or_different_time: (json['same_or_different_time'] as num?)?.toInt(),
      total_shift: (json['total_shift'] as num?)?.toInt(),
      start_date: (json['start_date'] as num?)?.toInt(),
      counter_proposal_hourly_rate:
          (json['counter_proposal_hourly_rate'] as num?)?.toDouble(),
      counter_proposal_commute_allowance:
          (json['counter_proposal_commute_allowance'] as num?)?.toInt(),
      counter_proposal_accommodation_allowance:
          (json['counter_proposal_accommodation_allowance'] as num?)?.toInt(),
      end_date: (json['end_date'] as num?)?.toInt(),
      posted_start_time: (json['posted_start_time'] as num?)?.toInt(),
      posted_end_time: (json['posted_end_time'] as num?)?.toInt(),
      agreed_start_time: (json['agreed_start_time'] as num?)?.toInt(),
      agreed_end_time: (json['agreed_end_time'] as num?)?.toInt(),
      posted_hourly_rate: (json['posted_hourly_rate'] as num?)?.toDouble(),
      proposed_hourly_rate: (json['proposed_hourly_rate'] as num?)?.toDouble(),
      commute_allowance_type: (json['commute_allowance_type'] as num?)?.toInt(),
      posted_commute_allowance_rate:
          (json['posted_commute_allowance_rate'] as num?)?.toDouble(),
      posted_commute_allowance_hour_id:
          (json['posted_commute_allowance_hour_id'] as num?)?.toInt(),
      proposed_commute_allowance_rate:
          (json['proposed_commute_allowance_rate'] as num?)?.toDouble(),
      proposed_commute_allowance_hour_id:
          (json['proposed_commute_allowance_hour_id'] as num?)?.toInt(),
      accommodation_allowance_type:
          (json['accommodation_allowance_type'] as num?)?.toInt(),
      posted_accommodation_allowance_rate:
          (json['posted_accommodation_allowance_rate'] as num?)?.toDouble(),
      posted_accommodation_allowance_hour_id:
          (json['posted_accommodation_allowance_hour_id'] as num?)?.toInt(),
      proposed_accommodation_allowance_rate:
          (json['proposed_accommodation_allowance_rate'] as num?)?.toDouble(),
      proposed_accommodation_allowance_hour_id:
          (json['proposed_accommodation_allowance_hour_id'] as num?)?.toInt(),
      proposed_accommodation_allowance_hour_name:
          json['proposed_accommodation_allowance_hour_name'] as String?,
      posted_accommodation_allowance_hour_name:
          json['posted_accommodation_allowance_hour_name'] as String?,
      proposed_commute_allowance_hour_name:
          json['proposed_commute_allowance_hour_name'] as String?,
      posted_commute_allowance_hour_name:
          json['posted_commute_allowance_hour_name'] as String?,
      shift_details: (json['shift_details'] as List<dynamic>?)
          ?.map((e) => EmployerProposalShiftDetailDto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      isCardAdded: json['isCardAdded'] as bool?,
      occupied: json['occupied'] as bool?,
      agreed: json['agreed'] == null
          ? null
          : EmployerAgreedProposalDto.fromJson(
              json['agreed'] as Map<String, dynamic>),
      counter_commute_allowance_rate:
          (json['counter_commute_allowance_rate'] as num?)?.toDouble(),
      counter_commute_allowance_hour_id:
          (json['counter_commute_allowance_hour_id'] as num?)?.toInt(),
      counter_accommodation_allowance_rate:
          (json['counter_accommodation_allowance_rate'] as num?)?.toDouble(),
      counter_accommodation_allowance_hour_id:
          (json['counter_accommodation_allowance_hour_id'] as num?)?.toInt(),
      counter_commute_allowance_hour_name:
          json['counter_commute_allowance_hour_name'] as String?,
      counter_accommodation_allowance_hour_name:
          json['counter_accommodation_allowance_hour_name'] as String?,
      shift_detail: json['shift_detail'] == null
          ? null
          : EmployerAgreedShiftDetail.fromJson(
              json['shift_detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EmployerProposalDtoImplToJson(
        _$EmployerProposalDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'listing_id': instance.listing_id,
      'user_id': instance.user_id,
      'profile': instance.profile,
      'last_ago': instance.last_ago,
      'roles_list_name': instance.roles_list_name,
      'industry': instance.industry,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'complete_shift': instance.complete_shift,
      'pending_users': instance.pending_users,
      'location': instance.location,
      'distance': instance.distance,
      'post_id': instance.post_id,
      'proposal_type': instance.proposal_type,
      'last_request': instance.last_request,
      'revoke_status': instance.revoke_status,
      'shift_type': instance.shift_type,
      'same_or_different_time': instance.same_or_different_time,
      'total_shift': instance.total_shift,
      'start_date': instance.start_date,
      'counter_proposal_hourly_rate': instance.counter_proposal_hourly_rate,
      'counter_proposal_commute_allowance':
          instance.counter_proposal_commute_allowance,
      'counter_proposal_accommodation_allowance':
          instance.counter_proposal_accommodation_allowance,
      'end_date': instance.end_date,
      'posted_start_time': instance.posted_start_time,
      'posted_end_time': instance.posted_end_time,
      'agreed_start_time': instance.agreed_start_time,
      'agreed_end_time': instance.agreed_end_time,
      'posted_hourly_rate': instance.posted_hourly_rate,
      'proposed_hourly_rate': instance.proposed_hourly_rate,
      'commute_allowance_type': instance.commute_allowance_type,
      'posted_commute_allowance_rate': instance.posted_commute_allowance_rate,
      'posted_commute_allowance_hour_id':
          instance.posted_commute_allowance_hour_id,
      'proposed_commute_allowance_rate':
          instance.proposed_commute_allowance_rate,
      'proposed_commute_allowance_hour_id':
          instance.proposed_commute_allowance_hour_id,
      'accommodation_allowance_type': instance.accommodation_allowance_type,
      'posted_accommodation_allowance_rate':
          instance.posted_accommodation_allowance_rate,
      'posted_accommodation_allowance_hour_id':
          instance.posted_accommodation_allowance_hour_id,
      'proposed_accommodation_allowance_rate':
          instance.proposed_accommodation_allowance_rate,
      'proposed_accommodation_allowance_hour_id':
          instance.proposed_accommodation_allowance_hour_id,
      'proposed_accommodation_allowance_hour_name':
          instance.proposed_accommodation_allowance_hour_name,
      'posted_accommodation_allowance_hour_name':
          instance.posted_accommodation_allowance_hour_name,
      'proposed_commute_allowance_hour_name':
          instance.proposed_commute_allowance_hour_name,
      'posted_commute_allowance_hour_name':
          instance.posted_commute_allowance_hour_name,
      'shift_details': instance.shift_details,
      'isCardAdded': instance.isCardAdded,
      'occupied': instance.occupied,
      'agreed': instance.agreed,
      'counter_commute_allowance_rate': instance.counter_commute_allowance_rate,
      'counter_commute_allowance_hour_id':
          instance.counter_commute_allowance_hour_id,
      'counter_accommodation_allowance_rate':
          instance.counter_accommodation_allowance_rate,
      'counter_accommodation_allowance_hour_id':
          instance.counter_accommodation_allowance_hour_id,
      'counter_commute_allowance_hour_name':
          instance.counter_commute_allowance_hour_name,
      'counter_accommodation_allowance_hour_name':
          instance.counter_accommodation_allowance_hour_name,
      'shift_detail': instance.shift_detail,
    };

_$EmployerProposalPendingUserDtoImpl
    _$$EmployerProposalPendingUserDtoImplFromJson(Map<String, dynamic> json) =>
        _$EmployerProposalPendingUserDtoImpl(
          id: (json['id'] as num?)?.toInt(),
          first_name: json['first_name'] as String?,
          last_name: json['last_name'] as String?,
          profile: json['profile'] as String?,
          user_id: (json['user_id'] as num?)?.toInt(),
          last_request: (json['last_request'] as num?)?.toInt(),
          revoke_status: (json['revoke_status'] as num?)?.toInt(),
          revoke_start: (json['revoke_start'] as num?)?.toInt(),
          duration: json['duration'] == null
              ? null
              : Duration(microseconds: (json['duration'] as num).toInt()),
          sent_received_status: (json['sent_received_status'] as num?)?.toInt(),
          deleteAt: (json['deleteAt'] as num?)?.toInt(),
          accept_btn_toggle: json['accept_btn_toggle'] as bool?,
          occupied: json['occupied'] as bool?,
        );

Map<String, dynamic> _$$EmployerProposalPendingUserDtoImplToJson(
        _$EmployerProposalPendingUserDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'profile': instance.profile,
      'user_id': instance.user_id,
      'last_request': instance.last_request,
      'revoke_status': instance.revoke_status,
      'revoke_start': instance.revoke_start,
      'duration': instance.duration?.inMicroseconds,
      'sent_received_status': instance.sent_received_status,
      'deleteAt': instance.deleteAt,
      'accept_btn_toggle': instance.accept_btn_toggle,
      'occupied': instance.occupied,
    };

_$EmployerProposalShiftDetailDtoImpl
    _$$EmployerProposalShiftDetailDtoImplFromJson(Map<String, dynamic> json) =>
        _$EmployerProposalShiftDetailDtoImpl(
          id: (json['id'] as num?)?.toInt(),
          start_date: (json['start_date'] as num?)?.toInt(),
          posted_start_time: (json['posted_start_time'] as num?)?.toInt(),
          posted_end_time: (json['posted_end_time'] as num?)?.toInt(),
          proposed_start_time: (json['proposed_start_time'] as num?)?.toInt(),
          proposed_end_time: (json['proposed_end_time'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$EmployerProposalShiftDetailDtoImplToJson(
        _$EmployerProposalShiftDetailDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_date': instance.start_date,
      'posted_start_time': instance.posted_start_time,
      'posted_end_time': instance.posted_end_time,
      'proposed_start_time': instance.proposed_start_time,
      'proposed_end_time': instance.proposed_end_time,
    };

_$EmployerAgreedProposalDtoImpl _$$EmployerAgreedProposalDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployerAgreedProposalDtoImpl(
      agreed_hourly_rate: (json['agreed_hourly_rate'] as num?)?.toDouble(),
      agreed_commute_allowance_rate:
          (json['agreed_commute_allowance_rate'] as num?)?.toDouble(),
      agreed_commute_allowance_hour_id:
          (json['agreed_commute_allowance_hour_id'] as num?)?.toInt(),
      agreed_commute_allowance_hour_name:
          json['agreed_commute_allowance_hour_name'] as String?,
      agreed_accommodation_allowance_rate:
          (json['agreed_accommodation_allowance_rate'] as num?)?.toDouble(),
      agreed_accommodation_allowance_hour_id:
          (json['agreed_accommodation_allowance_hour_id'] as num?)?.toInt(),
      agreed_accommodation_allowance_hour_name:
          json['agreed_accommodation_allowance_hour_name'] as String?,
    );

Map<String, dynamic> _$$EmployerAgreedProposalDtoImplToJson(
        _$EmployerAgreedProposalDtoImpl instance) =>
    <String, dynamic>{
      'agreed_hourly_rate': instance.agreed_hourly_rate,
      'agreed_commute_allowance_rate': instance.agreed_commute_allowance_rate,
      'agreed_commute_allowance_hour_id':
          instance.agreed_commute_allowance_hour_id,
      'agreed_commute_allowance_hour_name':
          instance.agreed_commute_allowance_hour_name,
      'agreed_accommodation_allowance_rate':
          instance.agreed_accommodation_allowance_rate,
      'agreed_accommodation_allowance_hour_id':
          instance.agreed_accommodation_allowance_hour_id,
      'agreed_accommodation_allowance_hour_name':
          instance.agreed_accommodation_allowance_hour_name,
    };

_$EmployerAgreedShiftDetailImpl _$$EmployerAgreedShiftDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployerAgreedShiftDetailImpl(
      payables: json['payables'] == null
          ? null
          : EmployerAgreedProposalEmployerAgreedShiftDetail.fromJson(
              json['payables'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EmployerAgreedShiftDetailImplToJson(
        _$EmployerAgreedShiftDetailImpl instance) =>
    <String, dynamic>{
      'payables': instance.payables,
    };

_$EmployerAgreedProposalEmployerAgreedShiftDetailImpl
    _$$EmployerAgreedProposalEmployerAgreedShiftDetailImplFromJson(
            Map<String, dynamic> json) =>
        _$EmployerAgreedProposalEmployerAgreedShiftDetailImpl(
          total_payable_hour: json['total_payable_hour'] as String?,
          rate_hour: json['rate_hour'] as String?,
          total_wage: json['total_wage'] as String?,
          commute_allowance: json['commute_allowance'] as String?,
          accommodation_allowance: json['accommodation_allowance'] as String?,
          total_allowance: json['total_allowance'] as String?,
          service_fee: json['service_fee'] as String?,
          total_one_shift: json['total_one_shift'] as String?,
          number_of_vacancie: (json['number_of_vacancie'] as num?)?.toInt(),
          total_amount_payable: json['total_amount_payable'] as String?,
          total_one_allowance: json['total_one_allowance'] as String?,
          number_of_shift: (json['number_of_shift'] as num?)?.toInt(),
          service_one_fee: json['service_one_fee'] as String?,
          third_party_fee: json['third_party_fee'] as String?,
          third_party_tax_fee: json['third_party_tax_fee'] as String?,
          total_amount_payable_contractor:
              json['total_amount_payable_contractor'] as String?,
        );

Map<String, dynamic>
    _$$EmployerAgreedProposalEmployerAgreedShiftDetailImplToJson(
            _$EmployerAgreedProposalEmployerAgreedShiftDetailImpl instance) =>
        <String, dynamic>{
          'total_payable_hour': instance.total_payable_hour,
          'rate_hour': instance.rate_hour,
          'total_wage': instance.total_wage,
          'commute_allowance': instance.commute_allowance,
          'accommodation_allowance': instance.accommodation_allowance,
          'total_allowance': instance.total_allowance,
          'service_fee': instance.service_fee,
          'total_one_shift': instance.total_one_shift,
          'number_of_vacancie': instance.number_of_vacancie,
          'total_amount_payable': instance.total_amount_payable,
          'total_one_allowance': instance.total_one_allowance,
          'number_of_shift': instance.number_of_shift,
          'service_one_fee': instance.service_one_fee,
          'third_party_fee': instance.third_party_fee,
          'third_party_tax_fee': instance.third_party_tax_fee,
          'total_amount_payable_contractor':
              instance.total_amount_payable_contractor,
        };
