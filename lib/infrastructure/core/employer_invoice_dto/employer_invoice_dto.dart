import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
part 'employer_invoice_dto.freezed.dart';
part 'employer_invoice_dto.g.dart';

@freezed
class EmployerInvoiceDTO with _$EmployerInvoiceDTO {
  const factory EmployerInvoiceDTO({
    int? id,
    int? post_id,
    int? employer_id,
    String? employer_profile,
    String? employer_company_name,
    int? industry,
    String? listing_id,
    LocationDTO? location,
    String? contractor_first_name,
    String? contractor_email,
    String? contractor_last_name,
    LocationDTO? contractor_location,
    String? shift_type,
    String? roles_list_name,
    int? date,
    String? total_payable_hours,
    double? hourly_rate,
    String? total_wage,
    String? shiftfinder_service_fee,
    String? total_allowance,
    String? total_amount_payble,
    int? invoice_no,
    double? total_amount_payable_contractor,
    String? third_party_fee,
    String? third_party_tax_fee,
    InvoiceClockInOutDTO? clock_in_clock_out,
  }) = _EmployerInvoiceDTO;

  factory EmployerInvoiceDTO.fromJson(Map<String, dynamic> json) =>
      _$EmployerInvoiceDTOFromJson(json);
}

@freezed
class InvoiceClockInOutDTO with _$InvoiceClockInOutDTO {
  const factory InvoiceClockInOutDTO({
    int? clock_in,
    int? clock_out,
    String? total_shift_hours,
    InvoiceUnpaidBreakDTO? unpaid_break,
  }) = _InvoiceClockInOutDTO;

  factory InvoiceClockInOutDTO.fromJson(Map<String, dynamic> json) =>
      _$InvoiceClockInOutDTOFromJson(json);
}

@freezed
class InvoiceUnpaidBreakDTO with _$InvoiceUnpaidBreakDTO {
  const factory InvoiceUnpaidBreakDTO({
    int? id,
    String? name,
    String? short_name,
    int? minute,
  }) = _InvoiceUnpaidBreakDTO;

  factory InvoiceUnpaidBreakDTO.fromJson(Map<String, dynamic> json) =>
      _$InvoiceUnpaidBreakDTOFromJson(json);
}
