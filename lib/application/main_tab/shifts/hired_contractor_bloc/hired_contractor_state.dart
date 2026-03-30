part of 'hired_contractor_bloc.dart';

@freezed
class HiredContractorState with _$HiredContractorState {
  factory HiredContractorState({
    required bool isLoading,
    required bool showErrorMessages,
    required Option<Either<AccountFailure, List<HiredContractorListDTO>>>
        authFailureOrSuccessOption,
    required bool noDataFound,
    required bool errorApi,
    required List<HiredContractorListDTO> hiredFilledContractorList,
    required List<HiredContractorListDTO> hiredCancelledContractorList,
    required List<HiredContractorListDTO> hiredApproveContractorList,
    required int? clockIn,
    required int? clockOut,
    required bool showClockTimeError,
    required bool isSubmitting,
  }) = _HiredContractorState;
  factory HiredContractorState.initial() => HiredContractorState(
        authFailureOrSuccessOption: none(),
        errorApi: false,
        hiredFilledContractorList: [],
        hiredCancelledContractorList: [],
        hiredApproveContractorList: [],
        isLoading: false,
        isSubmitting: false,
        noDataFound: false,
        showErrorMessages: false,
        clockIn: null,
        clockOut: null,
        showClockTimeError: false,
      );
}
