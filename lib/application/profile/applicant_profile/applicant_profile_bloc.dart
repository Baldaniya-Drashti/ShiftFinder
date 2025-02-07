import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/applicant_dto/applicant_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
part 'applicant_profile_event.dart';
part 'applicant_profile_state.dart';
part 'applicant_profile_bloc.freezed.dart';

@injectable
class ApplicantProfileBloc
    extends Bloc<ApplicantProfileEvent, ApplicantProfileState> {
  final IMainFacade _mainFacade;

  ApplicantProfileBloc(this._mainFacade)
      : super(ApplicantProfileState.initial()) {
    on<ApplicantProfileEvent>((event, emit) async {
      await event.map(
        fetchApplicantProfile: (value) async {
          Either<MainFailure, CommonResponse>? failureOrSuccess;
          emit(state.copyWith(isLoading: true));
          failureOrSuccess = await _mainFacade.getApplicantProfile(
              id: value.id,
              postId: value.postId,
              isLongOrFull: value.isLongOrFull);
          emit(state.copyWith(isLoading: false));

          failureOrSuccess.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) =>
                      'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(value.context);
              emit(state.copyWith(isErrorInAPI: true));
            },
            (r) {
              final data = ApplicantDto.fromJson(r.data);

              emit(state.copyWith(account: data));
            },
          );
        },
      );
    });
  }
}
