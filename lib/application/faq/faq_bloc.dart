import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/faq_dto/faq_dto.dart';
part 'faq_event.dart';
part 'faq_state.dart';
part 'faq_bloc.freezed.dart';

@injectable
class FaqBloc extends Bloc<FaqEvent, FaqState> {
  final IMainFacade _mainFacade;
  int currentPage = 1;
  int lastPage = 1;
  final RefreshController refreshController = RefreshController();

  FaqBloc(this._mainFacade) : super(FaqState.initial()) {
    on<FaqEvent>((event, emit) async {
      await event.map(
        toggleExpansionEvent: (e) {
          /* final updatedStates = List<bool>.from(state.expandedStates);

          // Ensure the list size is sufficient for the requested index
          if (event.index >= updatedStates.length) {
            updatedStates.addAll(List.generate(
                event.index - updatedStates.length + 1, (_) => false));
          }

          // Toggle the expansion state for the given index
          updatedStates[event.index] = !updatedStates[event.index];
          emit(state.copyWith(expandedStates: updatedStates)); */
        },
        getFaqList: (value) async {
          if (value.refresh) {
            currentPage = 1;
            emit(state.copyWith(
              faqList: [],
              getDataLoading: value.refresh,
            ));
            refreshController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              refreshController.loadNoData();
              return;
            }
          }
          var res = await _mainFacade.getFaqList(
            page: currentPage,
          );
          currentPage++;
          res.fold(
            (l) => emit(
              state.copyWith(
                errorApi: true,
                getDataLoading: false,
                faqList: [],
              ),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (value.refresh) {
                List.from(state.faqList).clear();
              }
              return emit(
                state.copyWith(
                  getDataLoading: false,
                  errorApi: false,
                  noDataFound: (r.data as List<dynamic>)
                      .map((e) => FaqDTO.fromJson(e))
                      .toList()
                      .isEmpty,
                  faqList: List.from(state.faqList)
                    ..addAll(
                      (r.data as List<dynamic>)
                          .map((e) => FaqDTO.fromJson(e))
                          .toList(),
                    ),
                ),
              );
            },
          );
        },
        /*   getFaqList: (e) async {
          /* final List<Item> items = [
            Item(
                header: '1. Lorem ipsum dolor sit amet',
                body:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
            Item(
                header: '2. Lorem ipsum dolor sit amet',
                body:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.'),
            Item(
                header: '3. Lorem ipsum dolor sit amet',
                body:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
            Item(
                header: '4. Lorem ipsum dolor sit amet',
                body:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
          ];

          emit(state.copyWith(
            faqList: items,
          )); */
          Either<MainFailure, List<Item>>? failureOrSuccess;

          emit(state.copyWith(
            isLoading: true,
            failureOrSuccessOption: none(),
          ));

          failureOrSuccess = await _mainFacade.getFaqList();
          failureOrSuccess.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) =>
                      'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(e.context);
              emit(state.copyWith(
                isLoading: false,
                showErrorMessages: true,
                failureOrSuccessOption: none(),
              ));
            },
            (r) {
              print("FAQs List --> $r");
              emit(state.copyWith(
                isLoading: false,
                showErrorMessages: false,
                faqList: r,
                failureOrSuccessOption: optionOf(failureOrSuccess),
              ));
            },
          );
        },
       */
      );
    });
  }
}

class Item {
  Item({
    required this.header,
    required this.body,
    this.isExpanded = false,
  });

  String header;
  String body;
  bool isExpanded;
}
