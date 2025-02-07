import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
part 'employer_full_position_detail_event.dart';
part 'employer_full_position_detail_state.dart';
part 'employer_full_position_detail_bloc.freezed.dart';

@injectable
class EmployerFullPositionDetailBloc extends Bloc<
    EmployerFullPositionDetailEvent, EmployerFullPositionDetailState> {
  final IMainFacade _iMainFacade;

  EmployerFullPositionDetailBloc(this._iMainFacade)
      : super(EmployerFullPositionDetailState.initial()) {
    on<EmployerFullPositionDetailEvent>((event, emit) async {
      await event.map(
        getPositionDetail: (value) async {
          emit(state.copyWith(isLoading: true));
          final response = await _iMainFacade.getEmployerPositionDetail(
              id: value.id, postType: 2);
          emit(state.copyWith(isLoading: false));
          response.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) =>
                      'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(value.context);
            },
            (r) {
              final data = EmployerLongTermSuccessDto.fromJson(r.data);
              emit(state.copyWith(employerLongTermSuccessDto: data));
            },
          );
        },
      );
    });
  }
}
