part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required bool showErrorMessages,
    required Option<Either<MainFailure, String>> failureOrSuccessOption,
    required bool isSubmitting,
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required List<EmployerDashboardDTO> employerDashboardList,
  }) = _HomeState;
  factory HomeState.initial() => HomeState(
        showErrorMessages: false,
        failureOrSuccessOption: none(),
        isSubmitting: false,
        employerDashboardList: [],
        isLoading: false,
        isNoDataFound: false,
        isErrorInAPI: false,
      );
}
