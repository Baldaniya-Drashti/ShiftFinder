import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';

part 'review_post_event.dart';
part 'review_post_state.dart';
part 'review_post_bloc.freezed.dart';

@injectable
class ReviewPostBloc extends Bloc<ReviewPostEvent, ReviewPostState> {
  final IMainFacade mainFacade;

  ReviewPostBloc(this.mainFacade) : super(ReviewPostState.initial()) {
    on<ReviewPostEvent>((event, emit) async {
      await event.map(
        getShiftData: (e) async {
          if (e.postId != null) {
            Either<MainFailure, HealthcarePostDTO> failureOrSuccess =
                await mainFacade.getPostApi(
              postId: e.postId!,
            );
            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isLoading: false,
                ),
              ),
              (r) {
                return emit(
                  state.copyWith(
                    post: r,
                  ),
                );
              },
            );
          } else {
            emit(
              state.copyWith(
                post: e.post ?? HealthcarePostDTO(),
              ),
            );
          }
        },
      );
    });
  }
}
