part of 'applicant_profile_bloc.dart';

@freezed
class ApplicantProfileState with _$ApplicantProfileState {
  const factory ApplicantProfileState({
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required ApplicantDto account,
  }) = _ApplicantProfileState;

  factory ApplicantProfileState.initial() => ApplicantProfileState(
        account: ApplicantDto(),
        isErrorInAPI: false,
        isLoading: false,
        isNoDataFound: false,
      );
}
