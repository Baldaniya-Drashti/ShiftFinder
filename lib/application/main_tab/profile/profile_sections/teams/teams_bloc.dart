import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/main/employer_team/get_teams_dto.dart';

part 'teams_state.dart';
part 'teams_event.dart';
part 'teams_bloc.freezed.dart';

@injectable
class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  int page = 1;
  int lastPage = 1;
  Timer? searchOnStoppedTyping;
  bool isFetching = false;
  final RefreshController refreshController = RefreshController();
  final IMainFacade mainFacade;
  final IAccountRepository iAccountRepository;

  var locationList = [
    DropDownValueModel(name: 'Location 1', value: '1'),
    DropDownValueModel(name: 'Location 2', value: '2'),
    DropDownValueModel(name: 'Location 3', value: '3'),
    DropDownValueModel(name: 'Location 4', value: '4'),
  ];

  TeamsBloc(this.mainFacade, this.iAccountRepository)
      : super(TeamsState.initial()) {
    on<TeamsEvent>(
      (event, emit) async {
        await event.map(
          initialEvent: (e) async {},
          changeLocation: (ChangeLocation value) async {
            // emit(
            //   state.copyWith(
            //     locationTextField: InputEmptyOrNot(value.location),
            //   ),
            // );
          },
          changeTeamName: (ChangeTeamName value) async {
            emit(
              state.copyWith(
                teamNameTextField: InputEmptyOrNot(value.teamName),
              ),
            );
          },
          createTeam: (CreateTeam value) async {
            Either<MainFailure, String>? failureOrSuccess;
            //  var isLocationValid = state.locationTextField.isValid();
            var isTeamNameValid = state.teamNameTextField.isValid();
            if (state.singleValueDropDownController.dropDownValue?.name !=
                    null &&
                isTeamNameValid) {
              emit(
                state.copyWith(
                  isSubmitting: true,
                  failureOrSuccessOption: none(),
                ),
              );
              failureOrSuccess = await mainFacade.createTeamApi(
                locationId: state
                        .singleValueDropDownController.dropDownValue?.value
                        .toString() ??
                    "",
                teamName: state.teamNameTextField,
              );
            }

            emit(
              state.copyWith(
                  isSubmitting: false,
                  showErrorMessages: true,
                  failureOrSuccessOption: optionOf(failureOrSuccess)
                  // authFailureOrSuccessOption: optionOf(failureOrSuccess),
                  // verificationFailureOrSuccessOption: none(),
                  ),
            );
          },
          getTeamList: (e) async {
            if (e.isRefresh) {
              page = 1;
              emit(state.copyWith(getTeamList: [], isLoading: e.isRefresh));
              refreshController.resetNoData();
            } else {
              if (page > lastPage) {
                refreshController.loadNoData();
                return;
              }
            }

            var res = await mainFacade.getEmployerTeamsListAPI(
                page: page, id: e.teamID);

            page++;

            res.fold(
              (l) => emit(
                state.copyWith(
                  isErrorInAPI: true,
                  isLoading: false,
                  getTeamList: [],
                ),
              ),
              (r) {
                lastPage = r.meta?.lastPage ?? 1;
                if (e.isRefresh && e.teamID == null) {
                  List.from(state.getTeamList).clear();
                }
                if (e.teamID == null) {
                  return emit(
                    state.copyWith(
                      isLoading: false,
                      isErrorInAPI: false,
                      isNoDataFound: (r.data as List<dynamic>)
                          .map((e) => GetTeamsListDTO.fromJson(e))
                          .toList()
                          .isEmpty,
                      //  getProductList: []
                      getTeamList: List.from(state.getTeamList)
                        ..addAll((r.data as List<dynamic>)
                            .map((e) => GetTeamsListDTO.fromJson(e))
                            .toList()),
                    ),
                  );
                } else {
                  return emit(
                    state.copyWith(
                      isLoading: false,
                      isErrorInAPI: false,
                      teamDetail: GetTeamsListDTO.fromJson(r.data),
                    ),
                  );
                }
              },
            );
          },
          getLocationListAPI: (GetLocationListAPI value) async {
            final locationList = await iAccountRepository.getLocationListApi();

            // print("Location List ---> ${locationList}");
            locationList.fold(
              (l) => emit(
                state.copyWith(
                  isLoading: false,
                  locationList: [],
                ),
              ),
              (r) {
                var dropdownList = r
                    .map(
                      (e) => DropDownValueModel(
                          name: e.location ?? "", value: e.id),
                    )
                    .toList();
                return emit(
                  state.copyWith(
                    // isLoading: false,
                    locationList: List.from(state.locationList)
                      ..addAll(dropdownList),
                  ),
                );
              },
            );
          },
          prefillDataForUpdateTeam: (PrefillDataForUpdateTeam value) async {
            emit(
              state.copyWith(
                teamNameTextField: InputEmptyOrNot(
                  value.getTeamListDTO.name ?? "",
                ),
                isEdit: value.isEdit,
                teamIDForUpdate: value.teamID,
                singleValueDropDownController: SingleValueDropDownController(
                  data: DropDownValueModel(
                    name: value.getTeamListDTO.location?.location ?? "",
                    value: value.getTeamListDTO.location_id ?? "",
                  ),
                ),
              ),
            );
          },
          updateTeam: (UpdateTeam value) async {
            Either<MainFailure, String>? failureOrSuccess;
            //  var isLocationValid = state.locationTextField.isValid();
            var isTeamNameValid = state.teamNameTextField.isValid();
            if (state.singleValueDropDownController.dropDownValue?.name !=
                    null &&
                isTeamNameValid) {
              emit(
                state.copyWith(
                  isSubmitting: true,
                  failureOrSuccessOption: none(),
                ),
              );
              failureOrSuccess = await mainFacade.updateTeamApi(
                locationId: state
                        .singleValueDropDownController.dropDownValue?.value
                        .toString() ??
                    "",
                teamName: state.teamNameTextField,
                teamId: value.teamId,
              );
            }

            emit(
              state.copyWith(
                  isSubmitting: false,
                  showErrorMessages: true,
                  failureOrSuccessOption: optionOf(failureOrSuccess)
                  // authFailureOrSuccessOption: optionOf(failureOrSuccess),
                  // verificationFailureOrSuccessOption: none(),
                  ),
            );
          },
          deleteTeam: (DeleteTeam value) async {
            Either<MainFailure, String>? failureOrSuccess;

            emit(
              state.copyWith(
                /// isSubmitting: true,
                failureOrSuccessOption: none(),
              ),
            );
            failureOrSuccess = await mainFacade.deleteTeamApi(
              teamId: value.teamId,
            );
            emit(
              state.copyWith(
                /// isSubmitting: true,
                failureOrSuccessOption: optionOf(failureOrSuccess),
              ),
            );
          },
          setTeamDetail: (SetTeamDetail value) async {
            emit(state.copyWith(teamDetail: value.getTeamListDTO));
          },
        );
      },
    );
  }
}
