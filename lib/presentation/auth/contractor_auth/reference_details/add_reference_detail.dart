// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/auth/contractor_auth/reference_bloc/reference_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/auth/contractor_auth/reference_details/personal_reference.dart';
import 'package:shift/presentation/auth/contractor_auth/reference_details/professional_reference.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'addReferenceDetailScreen')
class AddReferenceDetail extends StatelessWidget {
  final bool isFromSplash;

  AddReferenceDetail({super.key, this.isFromSplash = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReferenceBloc>(),
      child: GestureDetector(
        onTap: () {
          AppFocus.unfocus(context);
        },
        child: Scaffold(
          appBar: CommonAppBar(
            isShowBackBtn: !isFromSplash,
            title: StringConstant.reference,
            onBackPressed: () {
              context.router.maybePop();
            },
          ),
          body: BlocConsumer<ReferenceBloc, ReferenceState>(
            listener: (context, state) {
              state.authFailureOrSuccessOptionProfessional.fold(
                () {},
                (either) => either.fold(
                  (failure) {
                    showError(
                      message: failure.maybeMap(
                        showAPIResponseMessage: (value) => value.message,
                        networkError: (value) =>
                            'Please check your internet connectivity',
                        orElse: () => "Server Error. Try again later.",
                      ),
                    ).show(context);
                  },
                  (r) {
                    Navigator.pop(context, true);
                  },
                ),
              );
              state.authFailureOrSuccessOptionPersonal.fold(
                () {},
                (either) => either.fold(
                  (failure) {
                    showError(
                      message: failure.maybeMap(
                        showAPIResponseMessage: (value) => value.message,
                        networkError: (value) =>
                            'Please check your internet connectivity',
                        orElse: () => "Server Error. Try again later.",
                      ),
                    ).show(context);
                  },
                  (r) {
                    Navigator.pop(context, true);
                  },
                ),
              );
            },
            builder: (context, state) {
              print("state.selectedTab--->  ${state.selectedTab}");
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                child: DefaultTabController(
                  length: 2,
                  initialIndex: state.selectedTab,
                  child: Column(
                    children: [
                      tabbar(context, state),
                      SizedBox(
                        height: getSize(20),
                      ),
                      Expanded(
                        child: (state.selectedTab == 0)
                            ? const ProfessionalReferenceWidget()
                            : const PersonalReferenceWidget(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget tabbar(BuildContext context, ReferenceState state) {
    return Container(
      height: getSize(50),
      padding: EdgeInsets.symmetric(vertical: getSize(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
        color: AppColors.white,
      ),
      child: TabBar(
        onTap: (value) {
          context
              .read<ReferenceBloc>()
              .add(ReferenceEvent.tabChangeEvent(value));
        },
        padding: EdgeInsets.zero,
        labelStyle: TextStyle(
          fontSize: getFontSize(14),
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: getFontSize(14),
          color: Colors.black.withOpacity(0.5),
          fontWeight: FontWeight.w500,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: AppColors.white,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          color: AppColors.primaryColor,
        ),
        tabs: const [
          Tab(text: StringConstant.professional),
          Tab(text: StringConstant.personal),
        ],
      ),
    );
  }
}
