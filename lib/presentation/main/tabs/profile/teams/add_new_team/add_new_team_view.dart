import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/main_tab/profile/profile_sections/teams/teams_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/main/employer_team/get_teams_dto.dart';
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
  final bool isUpdateMember;

  final GetTeamsListDTO? getTeamsListDTO;
  const AddNewTeamView(
      {super.key, this.isUpdateMember = false, this.getTeamsListDTO});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TeamsBloc>()
        ..add(TeamsEvent.getLocationListAPI())
        ..add(
          TeamsEvent.prefillDataForUpdateTeam(
            getTeamsListDTO ?? GetTeamsListDTO(),
            isUpdateMember,
            getTeamsListDTO?.id.toString() ?? "",
          ),
        ),
      child: BlocConsumer<TeamsBloc, TeamsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: state.isEdit
                  ? StringConstant.updateTeam
                  : StringConstant.addNewTeam,
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
                    Visibility(
                      visible: !state.isEdit,
                      child: Column(
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
                            text: StringConstant.createATeam,
                            fontSize: 22,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Aclonica',
                          ),
                          SizedBox(height: getSize(10)),
                          BaseText(
                            text: StringConstant.createTeamDesc,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                            textColor: AppColors.black.withValues(alpha: 0.7),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getSize(30)),
                    Row(
                      children: [
                        BaseText(
                          text: StringConstant.location,
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
                      valueController: state.singleValueDropDownController,
                      list: state.locationList,
                      hintText: StringConstant.location,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Please select location';
                        } else {
                          return null;
                        }
                      },
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
                      text: StringConstant.teamName,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: getSize(8)),
                    CustomTextField(
                      key: state.isEdit ? Key('Team Name') : null,
                      hintText: StringConstant.teamName,
                      initialValue: state.isEdit
                          ? state.teamNameTextField.getValue() ?? ""
                          : null,
                      textCapitalization: TextCapitalization.words,
                      validator: (p0, p1) => state.teamNameTextField.value.fold(
                        (l) => l.maybeMap(
                          empty: (_) => 'Please add team name',
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
                    if (state.isEdit) {
                      context.read<TeamsBloc>().add(
                            TeamsEvent.updateTeam(
                                getTeamsListDTO?.id?.toString() ?? ""),
                          );
                    } else {
                      context.read<TeamsBloc>().add(TeamsEvent.createTeam());
                    }
                  },
                  buttonText: state.isEdit
                      ? StringConstant.update
                      : StringConstant.create,
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
                if (state.isEdit) {
                  context.router.maybePop(true);
                } else {
                  context.router.maybePop(true);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
