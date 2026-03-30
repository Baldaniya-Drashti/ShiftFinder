part of 'support_ticket_bloc.dart';

@freezed
class SupportTicketEvent with _$SupportTicketEvent {
  const factory SupportTicketEvent.onAttachmentSelected(
      {required String path}) = OnAttachmentSelected;
  const factory SupportTicketEvent.onRemoveAttachment() = OnRemoveAttachment;
  const factory SupportTicketEvent.onCountrySelected(
      {required String code, required String flag}) = OnCountrySelected;
  const factory SupportTicketEvent.fetchLocationList(
      {required BuildContext context}) = FetchLocationList;
  const factory SupportTicketEvent.onLocationChanged(
      {required LocationDTO selectedLocation}) = OnLocationChanged;
  const factory SupportTicketEvent.onSubmit({
    required String companyName,
    required String name,
    required String email,
    required String subject,
    required String description,
    required String phoneNumber,
    required BuildContext context,
  }) = OnSubmit;
}
