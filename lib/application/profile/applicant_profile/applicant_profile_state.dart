part of 'applicant_profile_bloc.dart';

@freezed
class ApplicantProfileState with _$ApplicantProfileState {
  const factory ApplicantProfileState({
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required Account account,
  }) = _ApplicantProfileState;

  factory ApplicantProfileState.initial() => ApplicantProfileState(
        account: Account(),
        isErrorInAPI: false,
        isLoading: false,
        isNoDataFound: false,
      );
}
