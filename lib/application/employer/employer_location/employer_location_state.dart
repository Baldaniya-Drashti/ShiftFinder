part of 'employer_location_bloc.dart';

@freezed
class EmployerLocationState with _$EmployerLocationState {
  const factory EmployerLocationState({
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required bool postDataLoading,
    required List<LocationDTO> locationList,
  }) = _EmployerLocationState;

  factory EmployerLocationState.initial() => EmployerLocationState(
        locationList: [],
        isNoDataFound: false,
        isErrorInAPI: false,
        isLoading: false,
        postDataLoading: false,
      );
}
