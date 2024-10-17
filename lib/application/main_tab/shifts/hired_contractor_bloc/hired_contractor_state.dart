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
    required List<HiredContractorListDTO> hiredApproveContractorList,
  }) = _HiredContractorState;
  factory HiredContractorState.initial() => HiredContractorState(
        authFailureOrSuccessOption: none(),
        errorApi: false,
        hiredFilledContractorList: [],
        hiredApproveContractorList: [],
        isLoading: false,
        noDataFound: false,
        showErrorMessages: false,
      );
}
