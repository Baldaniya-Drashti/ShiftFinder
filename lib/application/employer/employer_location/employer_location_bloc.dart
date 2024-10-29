import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';

part 'employer_location_event.dart';

part 'employer_location_state.dart';

part 'employer_location_bloc.freezed.dart';

@injectable
class EmployerLocationBloc extends Bloc<EmployerLocationEvent, EmployerLocationState> {
  final IMainFacade _mainFacade;

  final RefreshController refreshController = RefreshController();
  int page = 1;
  int lastPage = 1;

  EmployerLocationBloc(this._mainFacade) : super(EmployerLocationState.initial()) {
    on<EmployerLocationEvent>((event, emit) async {
      await event.map(
        getLocationList: (value) async {
          Either<MainFailure, CommonResponse>? failureOrSuccess;
          emit(state.copyWith(isLoading: true));
          failureOrSuccess = await _mainFacade.getLocationListApi();
          emit(state.copyWith(isLoading: false));
          failureOrSuccess.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) => 'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(value.context);
            },
            (r) {
              var account = r.data as List<dynamic>;
              var list = account.map((e) => LocationDTO.fromJson(e)).toList();
              emit(state.copyWith(locationList: list));
            },
          );
        },
        deleteLocation: (DeleteLocation value) async {
          Either<MainFailure, CommonResponse>? failureOrSuccess;
          emit(state.copyWith(postDataLoading: true));
          failureOrSuccess = await _mainFacade.deleteLocation(id: value.id);
          emit(state.copyWith(postDataLoading: false));
          failureOrSuccess.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) => 'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(value.context);
            },
            (r) {
              add(EmployerLocationEvent.getLocationList(value.context));
            },
          );
        },
      );
    });
  }
}
