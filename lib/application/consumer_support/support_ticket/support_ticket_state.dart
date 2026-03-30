part of 'support_ticket_bloc.dart';

@freezed
class SupportTicketState with _$SupportTicketState {
  const factory SupportTicketState({
    String? path,
    LocationDTO? selectedLocation,
    @Default("1") String selectedCountryCode,
    @Default("🇨🇦") String selectedCountryFlag,
    @Default([]) List<LocationDTO> locationList,
    @Default(false) bool loading,
    @Default(false) bool postDataLoading,
  }) = _SupportTicketState;
}
