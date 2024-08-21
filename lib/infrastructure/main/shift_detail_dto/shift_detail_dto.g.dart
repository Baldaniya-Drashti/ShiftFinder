// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShiftDetailDTOImpl _$$ShiftDetailDTOImplFromJson(Map<String, dynamic> json) =>
    _$ShiftDetailDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      shift_type: (json['shift_type'] as num?)?.toInt(),
      same_or_different_time: (json['same_or_different_time'] as num?)?.toInt(),
      unpaid_break: json['unpaid_break'] == null
          ? null
          : SkillDTO.fromJson(json['unpaid_break'] as Map<String, dynamic>),
      total_payable_hour: json['total_payable_hour'] as String?,
      commute_allowance_type: (json['commute_allowance_type'] as num?)?.toInt(),
      commute_allowance_type_details:
          (json['commute_allowance_type_details'] as num?)?.toDouble(),
      accommodation_allowance_type:
          (json['accommodation_allowance_type'] as num?)?.toInt(),
      accommodation_allowance_type_details:
          (json['accommodation_allowance_type_details'] as num?)?.toDouble(),
      individual_shift: (json['individual_shift'] as num?)?.toInt(),
      shift_note: json['shift_note'] as String?,
      vacancie_type: (json['vacancie_type'] as num?)?.toInt(),
      number_of_vacancie: (json['number_of_vacancie'] as num?)?.toInt(),
      pending_vacancie: (json['pending_vacancie'] as num?)?.toInt(),
      recurring_status: (json['recurring_status'] as num?)?.toInt(),
      share_team_status: (json['share_team_status'] as num?)?.toInt(),
      save_template_status: (json['save_template_status'] as num?)?.toInt(),
      disclaimer: json['disclaimer'] as String?,
      teams: (json['teams'] as List<dynamic>?)
          ?.map((e) => TeamDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      detail: (json['detail'] as List<dynamic>?)
          ?.map((e) => ShiftDateDetailDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      payables: json['payables'] == null
          ? null
          : PayableDTO.fromJson(json['payables'] as Map<String, dynamic>),
      date: (json['date'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      recurring_start_date: (json['recurring_start_date'] as num?)?.toInt(),
      recurring_end_date: (json['recurring_end_date'] as num?)?.toInt(),
      recurrence_mode: json['recurrence_mode'] as String?,
      recurrence_id: (json['recurrence_id'] as num?)?.toInt(),
      days: json['days'] as String?,
      script_volume: (json['script_volume'] as num?)?.toInt(),
      assistant_on_site: (json['assistant_on_site'] as num?)?.toInt(),
      technician_on_site: (json['technician_on_site'] as num?)?.toInt(),
      posted_hourly_rate: (json['posted_hourly_rate'] as num?)?.toDouble(),
      proposed_hourly_rate: (json['proposed_hourly_rate'] as num?)?.toDouble(),
      posted_commute_allowance_rate:
          (json['posted_commute_allowance_rate'] as num?)?.toDouble(),
      posted_commute_allowance_hour_id:
          (json['posted_commute_allowance_hour_id'] as num?)?.toInt(),
      posted_commute_allowance_hour_name:
          json['posted_commute_allowance_hour_name'] as String?,
      proposed_commute_allowance_rate:
          (json['proposed_commute_allowance_rate'] as num?)?.toDouble(),
      proposed_commute_allowance_hour_id:
          (json['proposed_commute_allowance_hour_id'] as num?)?.toInt(),
      proposed_commute_allowance_hour_name:
          json['proposed_commute_allowance_hour_name'] as String?,
      posted_accommodation_allowance_rate:
          (json['posted_accommodation_allowance_rate'] as num?)?.toDouble(),
      posted_accommodation_allowance_hour_id:
          (json['posted_accommodation_allowance_hour_id'] as num?)?.toInt(),
      posted_accommodation_allowance_hour_name:
          json['posted_accommodation_allowance_hour_name'] as String?,
      proposed_accommodation_allowance_rate:
          (json['proposed_accommodation_allowance_rate'] as num?)?.toDouble(),
      proposed_accommodation_allowance_hour_id:
          (json['proposed_accommodation_allowance_hour_id'] as num?)?.toInt(),
      proposed_accommodation_allowance_hour_name:
          json['proposed_accommodation_allowance_hour_name'] as String?,
      proposal_received: json['proposal_received'] == null
          ? null
          : ProposalDTO.fromJson(
              json['proposal_received'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ShiftDetailDTOImplToJson(
        _$ShiftDetailDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shift_type': instance.shift_type,
      'same_or_different_time': instance.same_or_different_time,
      'unpaid_break': instance.unpaid_break,
      'total_payable_hour': instance.total_payable_hour,
      'commute_allowance_type': instance.commute_allowance_type,
      'commute_allowance_type_details': instance.commute_allowance_type_details,
      'accommodation_allowance_type': instance.accommodation_allowance_type,
      'accommodation_allowance_type_details':
          instance.accommodation_allowance_type_details,
      'individual_shift': instance.individual_shift,
      'shift_note': instance.shift_note,
      'vacancie_type': instance.vacancie_type,
      'number_of_vacancie': instance.number_of_vacancie,
      'pending_vacancie': instance.pending_vacancie,
      'recurring_status': instance.recurring_status,
      'share_team_status': instance.share_team_status,
      'save_template_status': instance.save_template_status,
      'disclaimer': instance.disclaimer,
      'teams': instance.teams,
      'detail': instance.detail,
      'payables': instance.payables,
      'date': instance.date,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'recurring_start_date': instance.recurring_start_date,
      'recurring_end_date': instance.recurring_end_date,
      'recurrence_mode': instance.recurrence_mode,
      'recurrence_id': instance.recurrence_id,
      'days': instance.days,
      'script_volume': instance.script_volume,
      'assistant_on_site': instance.assistant_on_site,
      'technician_on_site': instance.technician_on_site,
      'posted_hourly_rate': instance.posted_hourly_rate,
      'proposed_hourly_rate': instance.proposed_hourly_rate,
      'posted_commute_allowance_rate': instance.posted_commute_allowance_rate,
      'posted_commute_allowance_hour_id':
          instance.posted_commute_allowance_hour_id,
      'posted_commute_allowance_hour_name':
          instance.posted_commute_allowance_hour_name,
      'proposed_commute_allowance_rate':
          instance.proposed_commute_allowance_rate,
      'proposed_commute_allowance_hour_id':
          instance.proposed_commute_allowance_hour_id,
      'proposed_commute_allowance_hour_name':
          instance.proposed_commute_allowance_hour_name,
      'posted_accommodation_allowance_rate':
          instance.posted_accommodation_allowance_rate,
      'posted_accommodation_allowance_hour_id':
          instance.posted_accommodation_allowance_hour_id,
      'posted_accommodation_allowance_hour_name':
          instance.posted_accommodation_allowance_hour_name,
      'proposed_accommodation_allowance_rate':
          instance.proposed_accommodation_allowance_rate,
      'proposed_accommodation_allowance_hour_id':
          instance.proposed_accommodation_allowance_hour_id,
      'proposed_accommodation_allowance_hour_name':
          instance.proposed_accommodation_allowance_hour_name,
      'proposal_received': instance.proposal_received,
    };

_$ProposalDTOImpl _$$ProposalDTOImplFromJson(Map<String, dynamic> json) =>
    _$ProposalDTOImpl(
      commute_allowance_type: (json['commute_allowance_type'] as num?)?.toInt(),
      accommodation_allowance_type:
          (json['accommodation_allowance_type'] as num?)?.toInt(),
      posted_hourly_rate: (json['posted_hourly_rate'] as num?)?.toDouble(),
      posted_commute_allowance_rate:
          (json['posted_commute_allowance_rate'] as num?)?.toDouble(),
      posted_commute_allowance_hour_id:
          (json['posted_commute_allowance_hour_id'] as num?)?.toInt(),
      posted_accommodation_allowance_rate:
          (json['posted_accommodation_allowance_rate'] as num?)?.toDouble(),
      posted_accommodation_allowance_hour_id:
          (json['posted_accommodation_allowance_hour_id'] as num?)?.toInt(),
      proposed_hourly_rate: (json['proposed_hourly_rate'] as num?)?.toDouble(),
      proposed_commute_allowance_rate:
          (json['proposed_commute_allowance_rate'] as num?)?.toDouble(),
      proposed_commute_allowance_hour_id:
          (json['proposed_commute_allowance_hour_id'] as num?)?.toInt(),
      proposed_accommodation_allowance_rate:
          (json['proposed_accommodation_allowance_rate'] as num?)?.toDouble(),
      proposed_accommodation_allowance_hour_id:
          (json['proposed_accommodation_allowance_hour_id'] as num?)?.toInt(),
      counter_proposal_hourly_rate:
          (json['counter_proposal_hourly_rate'] as num?)?.toDouble(),
      counter_commute_allowance_rate:
          (json['counter_commute_allowance_rate'] as num?)?.toDouble(),
      counter_commute_allowance_hour_id:
          (json['counter_commute_allowance_hour_id'] as num?)?.toInt(),
      counter_accommodation_allowance_rate:
          (json['counter_accommodation_allowance_rate'] as num?)?.toDouble(),
      counter_accommodation_allowance_hour_id:
          (json['counter_accommodation_allowance_hour_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ProposalDTOImplToJson(_$ProposalDTOImpl instance) =>
    <String, dynamic>{
      'commute_allowance_type': instance.commute_allowance_type,
      'accommodation_allowance_type': instance.accommodation_allowance_type,
      'posted_hourly_rate': instance.posted_hourly_rate,
      'posted_commute_allowance_rate': instance.posted_commute_allowance_rate,
      'posted_commute_allowance_hour_id':
          instance.posted_commute_allowance_hour_id,
      'posted_accommodation_allowance_rate':
          instance.posted_accommodation_allowance_rate,
      'posted_accommodation_allowance_hour_id':
          instance.posted_accommodation_allowance_hour_id,
      'proposed_hourly_rate': instance.proposed_hourly_rate,
      'proposed_commute_allowance_rate':
          instance.proposed_commute_allowance_rate,
      'proposed_commute_allowance_hour_id':
          instance.proposed_commute_allowance_hour_id,
      'proposed_accommodation_allowance_rate':
          instance.proposed_accommodation_allowance_rate,
      'proposed_accommodation_allowance_hour_id':
          instance.proposed_accommodation_allowance_hour_id,
      'counter_proposal_hourly_rate': instance.counter_proposal_hourly_rate,
      'counter_commute_allowance_rate': instance.counter_commute_allowance_rate,
      'counter_commute_allowance_hour_id':
          instance.counter_commute_allowance_hour_id,
      'counter_accommodation_allowance_rate':
          instance.counter_accommodation_allowance_rate,
      'counter_accommodation_allowance_hour_id':
          instance.counter_accommodation_allowance_hour_id,
    };
