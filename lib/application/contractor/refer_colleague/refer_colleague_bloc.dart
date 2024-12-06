import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/applicant_dto/applicant_dto.dart';
import 'package:shift/infrastructure/core/contractor_previus_shift_dto/contractor_previus_shift_dto.dart';
import 'package:shift/infrastructure/core/contractor_refer_collegue_dto/contractor_refer_collegue_dto.dart';

part 'refer_colleague_event.dart';
part 'refer_colleague_state.dart';
part 'refer_colleague_bloc.freezed.dart';

@injectable
class ReferColleagueBloc
    extends Bloc<ReferColleagueEvent, ReferColleagueState> {
  final IMainFacade mainFacade;

  int currentPage = 1;
  int lastPage = 1;

  final RefreshController refreshController = RefreshController();
  ReferColleagueBloc(
    this.mainFacade,
  ) : super(ReferColleagueState.initial()) {
    on<ReferColleagueEvent>((event, emit) async {
      await event.map(
        getReferredColleagueData: (GetCompletedList e) async {
          if (e.isRefresh) {
            currentPage = 1;
            emit(state.copyWith(
              collegueList: [],
              isLoading: e.isRefresh,
            ));
            refreshController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              refreshController.loadNoData();
              return;
            }
          }
          var res = await mainFacade.getReferCollegueAPI(
            page: currentPage,
          );
          currentPage++;
          res.fold(
            (l) => emit(
              state.copyWith(
                isErrorInApi: true,
                isLoading: false,
                collegueList: [],
              ),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (e.isRefresh) {
                List.from(state.collegueList).clear();
              }

              emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInApi: false,
                  noDataFound: (r.data as List<dynamic>)
                      .map((e) => ReferColleagueDTO.fromJson(e))
                      .toList()
                      .isEmpty,
                  collegueList: List.from(state.collegueList)
                    ..addAll((r.data as List<dynamic>)
                        .map((e) => ReferColleagueDTO.fromJson(e))
                        .toList()),
                ),
              );
            },
          );
        },
        getCollegueProfile: (e) async {
          Either<MainFailure, ApplicantDto>? failureOrSuccess;
          emit(state.copyWith(isLoading: true));
          failureOrSuccess =
              await mainFacade.getReferrealContractorInfoApi(id: e.id);

          failureOrSuccess.fold(
            (l) => emit(state.copyWith(
              isLoading: false,
              showErrorMessages: true,
              // shiftFailureOrSuccessOption: optionOf(failureOrSuccess),
            )),
            (r) {
              print("post--> $r");
              emit(state.copyWith(
                isLoading: false,
                showErrorMessages: false,
                account: r,
                // shiftFailureOrSuccessOption: optionOf(failureOrSuccess),
              ));
            },
          );
        },
        shareReferralEvent: (e) async {
          final byteData =
              await rootBundle.load(PngImageConstants.shiftFinderWhiteLogo);

          final tempDir = await getTemporaryDirectory();
          final file = File('${tempDir.path}/logo.png');
          await file.writeAsBytes(byteData.buffer.asUint8List());

          String message = '''
Hi! Download the ShiftFinder app and start exploring shifts that suit your schedule.
Use my referral code: ${e.referralCode} to get started.

Download now: https://shiftfinderinc.com/
  ''';
          // https://play.google.com/store/apps/details?id=com.kiloo.subwaysurf&pcampaignid=web_share
          Share.shareXFiles(
            [XFile(file.path)],
            text: message,
            subject: 'Join ShiftFinder',
          );
        },
      );
    });
  }
}
