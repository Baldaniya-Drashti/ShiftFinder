import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/main_tab/profile/profile_sections/teams/teams_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dropdown/custom_dropdown_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/tabs/profile/teams/add_new_team/widgets/info_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'AddNewTeamView')
class AddNewTeamView extends StatelessWidget {
  const AddNewTeamView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<TeamsBloc>()..add(TeamsEvent.getLocationListAPI()),
      child: BlocConsumer<TeamsBloc, TeamsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: 'Add New Team',
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                autovalidateMode: state.showErrorMessages
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                  children: [
                    SizedBox(height: getSize(63)),
                    Center(
                      child: Image.asset(
                        PngImageConstants.teamImage,
                        height: getSize(85),
                        width: getSize(104),
                      ),
                    ),
                    SizedBox(height: getSize(30)),
                    BaseText(
                      text: 'Create a Team',
                      fontSize: 22,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Aclonica',
                    ),
                    SizedBox(height: getSize(10)),
                    BaseText(
                      text:
                          'Organize and manage your internal teams for efficient shift notification. Select a team to notify all members via email when a shift is posted.',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      textColor: AppColors.black.withOpacity(0.7),
                    ),
                    SizedBox(height: getSize(30)),
                    Row(
                      children: [
                        BaseText(
                          text: 'Location',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(width: getSize(5)),
                        GestureDetector(
                          onTap: () {
                            InfoDialog().infoDialog(context);
                          },
                          child: SvgPicture.asset(SvgImageConstant.infoCircle),
                        )
                      ],
                    ),
                    SizedBox(height: getSize(8)),
                    CustomDropdownTextfield(
                      valueController: context
                          .read<TeamsBloc>()
                          .singleValueDropDownController,
                      list: state.locationList,
                      hintText: 'Location',
                      // onChanged: (p0) => context
                      //     .read<TeamsBloc>()
                      //     .add(TeamsEvent.changeLocation(p0)),
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Please select location';
                        } else {
                          return null;
                        }
                      },
                      // validator: (p0) => state.locationTextField.value.fold(
                      //   (l) => l.maybeMap(
                      //     empty: (_) => 'Please select location',
                      //     orElse: () => null,
                      //   ),
                      //   (r) => null,
                      // ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getSize(14),
                          vertical: getSize(14),
                        ),
                        child: SvgPicture.asset(
                          SvgImageConstant.locationIcon,
                        ),
                      ),
                    ),
                    SizedBox(height: getSize(20)),
                    BaseText(
                      text: 'Team Name',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: getSize(8)),
                    CustomTextField(
                      hintText: 'Team Name',
                      textCapitalization: TextCapitalization.words,
                      validator: (p0, p1) => state.teamNameTextField.value.fold(
                        (l) => l.maybeMap(
                          empty: (_) => 'Please enter team name',
                          orElse: () => null,
                        ),
                        (r) => null,
                      ),
                      onChanged: (p0) => context
                          .read<TeamsBloc>()
                          .add(TeamsEvent.changeTeamName(p0)),
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getSize(14),
                          vertical: getSize(14),
                        ),
                        child: SvgPicture.asset(
                          SvgImageConstant.teamIcon,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              bottom: isFullScreenDevice(context) ? true : false,
              child: Padding(
                padding: EdgeInsets.only(
                  left: getSize(20),
                  top: getSize(20),
                  right: getSize(20),
                  bottom: getSize(isFullScreenDevice(context) ? 0 : 20),
                ),
                child: CommonButton(
                  isSubmitting: state.isSubmitting,
                  onPressed: () {
                    context.read<TeamsBloc>().add(TeamsEvent.createTeam());
                  },
                  buttonText: 'Create',
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, TeamsState state) {
          state.failureOrSuccessOption.fold(
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
              (r) async {
                context.router.maybePop(true);
                // await showSuccess(message: r).show(context).then(
                //       (value) => context.router.maybePop(true),
                //     );
                //context.router.push(const PageRouteInfo(MainTabView.name));
              },
            ),
          );
        },
      ),
    );
  }
}
