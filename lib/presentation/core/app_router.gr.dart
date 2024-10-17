// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i77;
import 'package:flutter/material.dart' as _i78;
import 'package:shift/application/auth/contractor_auth/location_example.dart'
    as _i34;
import 'package:shift/infrastructure/contractor_main/shift/applied_shift_dto/applied_shift_dto.dart'
    as _i85;
import 'package:shift/infrastructure/core/contractor_home/contractor_dashboard_dto.dart'
    as _i87;
import 'package:shift/infrastructure/core/education_dto/education_dto.dart'
    as _i79;
import 'package:shift/infrastructure/core/reference_dto/reference_dto.dart'
    as _i84;
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart'
    as _i86;
import 'package:shift/infrastructure/main/employer_team/get_teams_dto.dart'
    as _i83;
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart'
    as _i81;
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart'
    as _i80;
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart'
    as _i82;
import 'package:shift/infrastructure/main/shift_detail_dto/shift_detail_dto.dart'
    as _i88;
import 'package:shift/presentation/auth/contractor_auth/add_bank_details.dart'
    as _i1;
import 'package:shift/presentation/auth/contractor_auth/add_contractor_skills.dart'
    as _i4;
import 'package:shift/presentation/auth/contractor_auth/add_experience_detail.dart'
    as _i6;
import 'package:shift/presentation/auth/contractor_auth/add_speciality_experience.dart'
    as _i11;
import 'package:shift/presentation/auth/contractor_auth/documents/document_page.dart'
    as _i21;
import 'package:shift/presentation/auth/contractor_auth/education_details/add_education_detail.dart'
    as _i5;
import 'package:shift/presentation/auth/contractor_auth/education_details/education_detail_list.dart'
    as _i23;
import 'package:shift/presentation/auth/contractor_auth/intro_quiz.dart'
    as _i30;
import 'package:shift/presentation/auth/contractor_auth/intro_video.dart'
    as _i31;
import 'package:shift/presentation/auth/contractor_auth/legal_screening_questions.dart'
    as _i32;
import 'package:shift/presentation/auth/contractor_auth/quiz_result.dart'
    as _i52;
import 'package:shift/presentation/auth/contractor_auth/reference_details/add_reference_detail.dart'
    as _i10;
import 'package:shift/presentation/auth/contractor_auth/reference_details/reference_detail_list.dart'
    as _i53;
import 'package:shift/presentation/auth/contractor_auth/terms_conditions.dart'
    as _i64;
import 'package:shift/presentation/auth/employer_auth/add_card_detail.dart'
    as _i2;
import 'package:shift/presentation/auth/employer_auth/location_detail_form.dart'
    as _i33;
import 'package:shift/presentation/auth/login/login_screen.dart' as _i35;
import 'package:shift/presentation/auth/register/register_profile.dart' as _i54;
import 'package:shift/presentation/auth/register/register_screen.dart' as _i55;
import 'package:shift/presentation/contractor/contractor_main/contractor_main_tab.dart'
    as _i17;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/contracator_home.dart'
    as _i16;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/send_proposal/propose_availability.dart'
    as _i51;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/send_proposal/send_proposal.dart'
    as _i57;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/view_contractor_shift.dart'
    as _i68;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/view_contractor_shift_dates.dart'
    as _i69;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_profile/contractor_profile.dart'
    as _i18;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/applied_shift/proposal_received.dart'
    as _i50;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/contractor_shifts.dart'
    as _i19;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/view_upcoming_shit.dart'
    as _i76;
import 'package:shift/presentation/contractor/my_calendar_view/my_calendar_view.dart'
    as _i38;
import 'package:shift/presentation/core/enum.dart' as _i89;
import 'package:shift/presentation/core/widgets/google_map/show_google_map.dart'
    as _i59;
import 'package:shift/presentation/employer/healthcare_post/add_multi_date_time.dart'
    as _i7;
import 'package:shift/presentation/employer/healthcare_post/healthcare_post.dart'
    as _i27;
import 'package:shift/presentation/employer/healthcare_post/healthcare_post_shit_type.dart'
    as _i28;
import 'package:shift/presentation/employer/healthcare_post/payable_detail.dart'
    as _i43;
import 'package:shift/presentation/employer/healthcare_post/post_shift_recurring.dart'
    as _i45;
import 'package:shift/presentation/employer/healthcare_post/review_post_detail.dart'
    as _i56;
import 'package:shift/presentation/employer/home_view/view_dates.dart' as _i70;
import 'package:shift/presentation/employer/home_view/view_shift_details.dart'
    as _i73;
import 'package:shift/presentation/employer/profile/edit_profile/edit_profile_view.dart'
    as _i22;
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_view.dart'
    as _i46;
import 'package:shift/presentation/main/main_tab.dart' as _i36;
import 'package:shift/presentation/main/tabs/employer_shift_view.dart' as _i24;
import 'package:shift/presentation/main/tabs/home/home_view.dart' as _i29;
import 'package:shift/presentation/main/tabs/home/praposals/counter_prapose/awaiting_confirmation_view.dart'
    as _i14;
import 'package:shift/presentation/main/tabs/home/praposals/counter_prapose/counter_purpose_view.dart'
    as _i20;
import 'package:shift/presentation/main/tabs/home/praposals/total_praposal_view.dart'
    as _i65;
import 'package:shift/presentation/main/tabs/home/praposals/widgets/view_person_praposal_view.dart'
    as _i74;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/view_applicant_profile.dart'
    as _i67;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/common_document_view.dart'
    as _i15;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/personal_reference_detail.dart'
    as _i44;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/professional_reference_detail.dart'
    as _i48;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_single_applicants.dart'
    as _i75;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/add_card_view.dart'
    as _i3;
import 'package:shift/presentation/main/tabs/notification_view.dart' as _i39;
import 'package:shift/presentation/main/tabs/profile/profile_view.dart' as _i49;
import 'package:shift/presentation/main/tabs/profile/teams/add_new_member/add_new_member_view.dart'
    as _i8;
import 'package:shift/presentation/main/tabs/profile/teams/add_new_team/add_new_team_view.dart'
    as _i9;
import 'package:shift/presentation/main/tabs/profile/teams/team_detail/team_detail_view.dart'
    as _i62;
import 'package:shift/presentation/main/tabs/profile/teams/teams_view.dart'
    as _i63;
import 'package:shift/presentation/main/tabs/shifts/agreed_proposal.dart'
    as _i12;
import 'package:shift/presentation/main/tabs/shifts/approved_shifts/widgets/approved_contractor_list.dart'
    as _i13;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/filled_shifts_view.dart'
    as _i26;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/filled_hired_contractor_list.dart'
    as _i25;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/view_agreed_praposal.dart'
    as _i66;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/view_filled_shifts_dates.dart'
    as _i71;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/view_filled_shifts_details.dart'
    as _i72;
import 'package:shift/presentation/main/tabs/shifts/multi_agreed_shift.dart'
    as _i37;
import 'package:shift/presentation/main/tabs/shifts/shift_actions_view.dart'
    as _i58;
import 'package:shift/presentation/main/tabs/shifts/single_agreed_shift.dart'
    as _i60;
import 'package:shift/presentation/onboarding/onboarding1.dart' as _i40;
import 'package:shift/presentation/onboarding/onboarding2.dart' as _i41;
import 'package:shift/presentation/onboarding/onboarding3.dart' as _i42;
import 'package:shift/presentation/privacy_policy/privacy_policy.dart' as _i47;
import 'package:shift/presentation/splash/splash_page.dart' as _i61;

/// generated route for
/// [_i1.AddBankDetailsScreen]
class AddBankDetailsScreen
    extends _i77.PageRouteInfo<AddBankDetailsScreenArgs> {
  AddBankDetailsScreen({
    _i78.Key? key,
    bool isFromSplash = false,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          AddBankDetailsScreen.name,
          args: AddBankDetailsScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddBankDetailsScreen';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddBankDetailsScreenArgs>(
          orElse: () => const AddBankDetailsScreenArgs());
      return _i1.AddBankDetailsScreen(
        key: args.key,
        isFromSplash: args.isFromSplash,
      );
    },
  );
}

class AddBankDetailsScreenArgs {
  const AddBankDetailsScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i78.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddBankDetailsScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i2.AddCardDetailPage]
class AddCardDetailPage extends _i77.PageRouteInfo<AddCardDetailPageArgs> {
  AddCardDetailPage({
    _i78.Key? key,
    bool isFromSplash = false,
    bool fromRegister = true,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          AddCardDetailPage.name,
          args: AddCardDetailPageArgs(
            key: key,
            isFromSplash: isFromSplash,
            fromRegister: fromRegister,
          ),
          initialChildren: children,
        );

  static const String name = 'AddCardDetailPage';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddCardDetailPageArgs>(
          orElse: () => const AddCardDetailPageArgs());
      return _i2.AddCardDetailPage(
        key: args.key,
        isFromSplash: args.isFromSplash,
        fromRegister: args.fromRegister,
      );
    },
  );
}

class AddCardDetailPageArgs {
  const AddCardDetailPageArgs({
    this.key,
    this.isFromSplash = false,
    this.fromRegister = true,
  });

  final _i78.Key? key;

  final bool isFromSplash;

  final bool fromRegister;

  @override
  String toString() {
    return 'AddCardDetailPageArgs{key: $key, isFromSplash: $isFromSplash, fromRegister: $fromRegister}';
  }
}

/// generated route for
/// [_i3.AddCardView]
class AddCardView extends _i77.PageRouteInfo<void> {
  const AddCardView({List<_i77.PageRouteInfo>? children})
      : super(
          AddCardView.name,
          initialChildren: children,
        );

  static const String name = 'AddCardView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i3.AddCardView();
    },
  );
}

/// generated route for
/// [_i4.AddContractorSkillsForm]
class AddContractorSkillsForm
    extends _i77.PageRouteInfo<AddContractorSkillsFormArgs> {
  AddContractorSkillsForm({
    _i78.Key? key,
    bool isFromSplash = false,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          AddContractorSkillsForm.name,
          args: AddContractorSkillsFormArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddContractorSkillsForm';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddContractorSkillsFormArgs>(
          orElse: () => const AddContractorSkillsFormArgs());
      return _i4.AddContractorSkillsForm(
        key: args.key,
        isFromSplash: args.isFromSplash,
      );
    },
  );
}

class AddContractorSkillsFormArgs {
  const AddContractorSkillsFormArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i78.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddContractorSkillsFormArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i5.AddEducationDetail]
class AddEducationDetailScreen
    extends _i77.PageRouteInfo<AddEducationDetailScreenArgs> {
  AddEducationDetailScreen({
    _i78.Key? key,
    bool isFromSplash = false,
    _i79.EducationDTO? educationObj,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          AddEducationDetailScreen.name,
          args: AddEducationDetailScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
            educationObj: educationObj,
          ),
          initialChildren: children,
        );

  static const String name = 'AddEducationDetailScreen';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddEducationDetailScreenArgs>(
          orElse: () => const AddEducationDetailScreenArgs());
      return _i5.AddEducationDetail(
        key: args.key,
        isFromSplash: args.isFromSplash,
        educationObj: args.educationObj,
      );
    },
  );
}

class AddEducationDetailScreenArgs {
  const AddEducationDetailScreenArgs({
    this.key,
    this.isFromSplash = false,
    this.educationObj,
  });

  final _i78.Key? key;

  final bool isFromSplash;

  final _i79.EducationDTO? educationObj;

  @override
  String toString() {
    return 'AddEducationDetailScreenArgs{key: $key, isFromSplash: $isFromSplash, educationObj: $educationObj}';
  }
}

/// generated route for
/// [_i6.AddExperienceDetail]
class AddExperienceDetailScreen
    extends _i77.PageRouteInfo<AddExperienceDetailScreenArgs> {
  AddExperienceDetailScreen({
    _i78.Key? key,
    bool isFromSplash = false,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          AddExperienceDetailScreen.name,
          args: AddExperienceDetailScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddExperienceDetailScreen';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddExperienceDetailScreenArgs>(
          orElse: () => const AddExperienceDetailScreenArgs());
      return _i6.AddExperienceDetail(
        key: args.key,
        isFromSplash: args.isFromSplash,
      );
    },
  );
}

class AddExperienceDetailScreenArgs {
  const AddExperienceDetailScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i78.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddExperienceDetailScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i7.AddMultiDateTime]
class AddMultiDateTime extends _i77.PageRouteInfo<AddMultiDateTimeArgs> {
  AddMultiDateTime({
    _i78.Key? key,
    required _i80.MultiShiftDTO selectedObj,
    _i81.HealthcarePostDTO? updateShift,
    required _i82.PostShiftDTO post,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          AddMultiDateTime.name,
          args: AddMultiDateTimeArgs(
            key: key,
            selectedObj: selectedObj,
            updateShift: updateShift,
            post: post,
          ),
          initialChildren: children,
        );

  static const String name = 'AddMultiDateTime';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddMultiDateTimeArgs>();
      return _i7.AddMultiDateTime(
        key: args.key,
        selectedObj: args.selectedObj,
        updateShift: args.updateShift,
        post: args.post,
      );
    },
  );
}

class AddMultiDateTimeArgs {
  const AddMultiDateTimeArgs({
    this.key,
    required this.selectedObj,
    this.updateShift,
    required this.post,
  });

  final _i78.Key? key;

  final _i80.MultiShiftDTO selectedObj;

  final _i81.HealthcarePostDTO? updateShift;

  final _i82.PostShiftDTO post;

  @override
  String toString() {
    return 'AddMultiDateTimeArgs{key: $key, selectedObj: $selectedObj, updateShift: $updateShift, post: $post}';
  }
}

/// generated route for
/// [_i8.AddNewMemberView]
class AddNewMemberView extends _i77.PageRouteInfo<AddNewMemberViewArgs> {
  AddNewMemberView({
    _i78.Key? key,
    bool isUpdateMember = false,
    required _i83.Members? getTeamsListDTO,
    required String teamID,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          AddNewMemberView.name,
          args: AddNewMemberViewArgs(
            key: key,
            isUpdateMember: isUpdateMember,
            getTeamsListDTO: getTeamsListDTO,
            teamID: teamID,
          ),
          initialChildren: children,
        );

  static const String name = 'AddNewMemberView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddNewMemberViewArgs>();
      return _i8.AddNewMemberView(
        key: args.key,
        isUpdateMember: args.isUpdateMember,
        getTeamsListDTO: args.getTeamsListDTO,
        teamID: args.teamID,
      );
    },
  );
}

class AddNewMemberViewArgs {
  const AddNewMemberViewArgs({
    this.key,
    this.isUpdateMember = false,
    required this.getTeamsListDTO,
    required this.teamID,
  });

  final _i78.Key? key;

  final bool isUpdateMember;

  final _i83.Members? getTeamsListDTO;

  final String teamID;

  @override
  String toString() {
    return 'AddNewMemberViewArgs{key: $key, isUpdateMember: $isUpdateMember, getTeamsListDTO: $getTeamsListDTO, teamID: $teamID}';
  }
}

/// generated route for
/// [_i9.AddNewTeamView]
class AddNewTeamView extends _i77.PageRouteInfo<AddNewTeamViewArgs> {
  AddNewTeamView({
    _i78.Key? key,
    bool isUpdateMember = false,
    _i83.GetTeamsListDTO? getTeamsListDTO,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          AddNewTeamView.name,
          args: AddNewTeamViewArgs(
            key: key,
            isUpdateMember: isUpdateMember,
            getTeamsListDTO: getTeamsListDTO,
          ),
          initialChildren: children,
        );

  static const String name = 'AddNewTeamView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddNewTeamViewArgs>(
          orElse: () => const AddNewTeamViewArgs());
      return _i9.AddNewTeamView(
        key: args.key,
        isUpdateMember: args.isUpdateMember,
        getTeamsListDTO: args.getTeamsListDTO,
      );
    },
  );
}

class AddNewTeamViewArgs {
  const AddNewTeamViewArgs({
    this.key,
    this.isUpdateMember = false,
    this.getTeamsListDTO,
  });

  final _i78.Key? key;

  final bool isUpdateMember;

  final _i83.GetTeamsListDTO? getTeamsListDTO;

  @override
  String toString() {
    return 'AddNewTeamViewArgs{key: $key, isUpdateMember: $isUpdateMember, getTeamsListDTO: $getTeamsListDTO}';
  }
}

/// generated route for
/// [_i10.AddReferenceDetail]
class AddReferenceDetailScreen
    extends _i77.PageRouteInfo<AddReferenceDetailScreenArgs> {
  AddReferenceDetailScreen({
    _i78.Key? key,
    bool isFromSplash = false,
    _i84.ReferenceDTO? referenceObj,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          AddReferenceDetailScreen.name,
          args: AddReferenceDetailScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
            referenceObj: referenceObj,
          ),
          initialChildren: children,
        );

  static const String name = 'AddReferenceDetailScreen';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddReferenceDetailScreenArgs>(
          orElse: () => const AddReferenceDetailScreenArgs());
      return _i10.AddReferenceDetail(
        key: args.key,
        isFromSplash: args.isFromSplash,
        referenceObj: args.referenceObj,
      );
    },
  );
}

class AddReferenceDetailScreenArgs {
  const AddReferenceDetailScreenArgs({
    this.key,
    this.isFromSplash = false,
    this.referenceObj,
  });

  final _i78.Key? key;

  final bool isFromSplash;

  final _i84.ReferenceDTO? referenceObj;

  @override
  String toString() {
    return 'AddReferenceDetailScreenArgs{key: $key, isFromSplash: $isFromSplash, referenceObj: $referenceObj}';
  }
}

/// generated route for
/// [_i11.AddSpecialityExperience]
class AddSpecialityExperience
    extends _i77.PageRouteInfo<AddSpecialityExperienceArgs> {
  AddSpecialityExperience({
    _i78.Key? key,
    bool isFromSplash = false,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          AddSpecialityExperience.name,
          args: AddSpecialityExperienceArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddSpecialityExperience';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddSpecialityExperienceArgs>(
          orElse: () => const AddSpecialityExperienceArgs());
      return _i11.AddSpecialityExperience(
        key: args.key,
        isFromSplash: args.isFromSplash,
      );
    },
  );
}

class AddSpecialityExperienceArgs {
  const AddSpecialityExperienceArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i78.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddSpecialityExperienceArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i12.AgreedProposal]
class AgreedProposal extends _i77.PageRouteInfo<AgreedProposalArgs> {
  AgreedProposal({
    _i78.Key? key,
    required _i81.HealthcarePostDTO post,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          AgreedProposal.name,
          args: AgreedProposalArgs(
            key: key,
            post: post,
          ),
          initialChildren: children,
        );

  static const String name = 'AgreedProposal';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AgreedProposalArgs>();
      return _i12.AgreedProposal(
        key: args.key,
        post: args.post,
      );
    },
  );
}

class AgreedProposalArgs {
  const AgreedProposalArgs({
    this.key,
    required this.post,
  });

  final _i78.Key? key;

  final _i81.HealthcarePostDTO post;

  @override
  String toString() {
    return 'AgreedProposalArgs{key: $key, post: $post}';
  }
}

/// generated route for
/// [_i13.ApprovedHiredList]
class ApprovedHiredList extends _i77.PageRouteInfo<ApprovedHiredListArgs> {
  ApprovedHiredList({
    _i78.Key? key,
    required int postId,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          ApprovedHiredList.name,
          args: ApprovedHiredListArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'ApprovedHiredList';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ApprovedHiredListArgs>();
      return _i13.ApprovedHiredList(
        key: args.key,
        postId: args.postId,
      );
    },
  );
}

class ApprovedHiredListArgs {
  const ApprovedHiredListArgs({
    this.key,
    required this.postId,
  });

  final _i78.Key? key;

  final int postId;

  @override
  String toString() {
    return 'ApprovedHiredListArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i14.AwaitingConfirmationView]
class AwaitingConfirmationView extends _i77.PageRouteInfo<void> {
  const AwaitingConfirmationView({List<_i77.PageRouteInfo>? children})
      : super(
          AwaitingConfirmationView.name,
          initialChildren: children,
        );

  static const String name = 'AwaitingConfirmationView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i14.AwaitingConfirmationView();
    },
  );
}

/// generated route for
/// [_i15.CommonDocumentView]
class CommonDocumentView extends _i77.PageRouteInfo<CommonDocumentViewArgs> {
  CommonDocumentView({
    _i78.Key? key,
    required String title,
    required String pdfUrl,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          CommonDocumentView.name,
          args: CommonDocumentViewArgs(
            key: key,
            title: title,
            pdfUrl: pdfUrl,
          ),
          initialChildren: children,
        );

  static const String name = 'CommonDocumentView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CommonDocumentViewArgs>();
      return _i15.CommonDocumentView(
        key: args.key,
        title: args.title,
        pdfUrl: args.pdfUrl,
      );
    },
  );
}

class CommonDocumentViewArgs {
  const CommonDocumentViewArgs({
    this.key,
    required this.title,
    required this.pdfUrl,
  });

  final _i78.Key? key;

  final String title;

  final String pdfUrl;

  @override
  String toString() {
    return 'CommonDocumentViewArgs{key: $key, title: $title, pdfUrl: $pdfUrl}';
  }
}

/// generated route for
/// [_i16.ContractorHomeView]
class ContractorHomeView extends _i77.PageRouteInfo<void> {
  const ContractorHomeView({List<_i77.PageRouteInfo>? children})
      : super(
          ContractorHomeView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorHomeView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i16.ContractorHomeView();
    },
  );
}

/// generated route for
/// [_i17.ContractorMainTabView]
class ContractorMainTabView extends _i77.PageRouteInfo<void> {
  const ContractorMainTabView({List<_i77.PageRouteInfo>? children})
      : super(
          ContractorMainTabView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorMainTabView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i17.ContractorMainTabView();
    },
  );
}

/// generated route for
/// [_i18.ContractorProfileView]
class ContractorProfileView extends _i77.PageRouteInfo<void> {
  const ContractorProfileView({List<_i77.PageRouteInfo>? children})
      : super(
          ContractorProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorProfileView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i18.ContractorProfileView();
    },
  );
}

/// generated route for
/// [_i19.ContractorShiftView]
class ContractorShiftView extends _i77.PageRouteInfo<void> {
  const ContractorShiftView({List<_i77.PageRouteInfo>? children})
      : super(
          ContractorShiftView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorShiftView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i19.ContractorShiftView();
    },
  );
}

/// generated route for
/// [_i20.CounterPurposeView]
class CounterPurposeView extends _i77.PageRouteInfo<void> {
  const CounterPurposeView({List<_i77.PageRouteInfo>? children})
      : super(
          CounterPurposeView.name,
          initialChildren: children,
        );

  static const String name = 'CounterPurposeView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i20.CounterPurposeView();
    },
  );
}

/// generated route for
/// [_i21.DocumentPage]
class DocumentPageScreen extends _i77.PageRouteInfo<DocumentPageScreenArgs> {
  DocumentPageScreen({
    _i78.Key? key,
    bool isFromSplash = false,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          DocumentPageScreen.name,
          args: DocumentPageScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'DocumentPageScreen';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DocumentPageScreenArgs>(
          orElse: () => const DocumentPageScreenArgs());
      return _i21.DocumentPage(
        key: args.key,
        isFromSplash: args.isFromSplash,
      );
    },
  );
}

class DocumentPageScreenArgs {
  const DocumentPageScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i78.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'DocumentPageScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i22.EditProfileView]
class EditProfileView extends _i77.PageRouteInfo<void> {
  const EditProfileView({List<_i77.PageRouteInfo>? children})
      : super(
          EditProfileView.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i22.EditProfileView();
    },
  );
}

/// generated route for
/// [_i23.EducationListScreen]
class EducationListScreen extends _i77.PageRouteInfo<EducationListScreenArgs> {
  EducationListScreen({
    _i78.Key? key,
    bool isFromSplash = false,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          EducationListScreen.name,
          args: EducationListScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'EducationListScreen';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EducationListScreenArgs>(
          orElse: () => const EducationListScreenArgs());
      return _i23.EducationListScreen(
        key: args.key,
        isFromSplash: args.isFromSplash,
      );
    },
  );
}

class EducationListScreenArgs {
  const EducationListScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i78.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'EducationListScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i24.EmployerShiftView]
class EmployerShiftView extends _i77.PageRouteInfo<void> {
  const EmployerShiftView({List<_i77.PageRouteInfo>? children})
      : super(
          EmployerShiftView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerShiftView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i24.EmployerShiftView();
    },
  );
}

/// generated route for
/// [_i25.FilledHiredContractorList]
class FilledHiredContractorList
    extends _i77.PageRouteInfo<FilledHiredContractorListArgs> {
  FilledHiredContractorList({
    required int postId,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          FilledHiredContractorList.name,
          args: FilledHiredContractorListArgs(postId: postId),
          initialChildren: children,
        );

  static const String name = 'FilledHiredContractorList';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FilledHiredContractorListArgs>();
      return _i25.FilledHiredContractorList(postId: args.postId);
    },
  );
}

class FilledHiredContractorListArgs {
  const FilledHiredContractorListArgs({required this.postId});

  final int postId;

  @override
  String toString() {
    return 'FilledHiredContractorListArgs{postId: $postId}';
  }
}

/// generated route for
/// [_i26.FilledShiftsView]
class FilledShiftsView extends _i77.PageRouteInfo<void> {
  const FilledShiftsView({List<_i77.PageRouteInfo>? children})
      : super(
          FilledShiftsView.name,
          initialChildren: children,
        );

  static const String name = 'FilledShiftsView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i26.FilledShiftsView();
    },
  );
}

/// generated route for
/// [_i27.HealthCarePostForm]
class HealthCarePostForm extends _i77.PageRouteInfo<HealthCarePostFormArgs> {
  HealthCarePostForm({
    _i78.Key? key,
    int? postId,
    bool isFromSplash = false,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          HealthCarePostForm.name,
          args: HealthCarePostFormArgs(
            key: key,
            postId: postId,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'HealthCarePostForm';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HealthCarePostFormArgs>(
          orElse: () => const HealthCarePostFormArgs());
      return _i27.HealthCarePostForm(
        key: args.key,
        postId: args.postId,
        isFromSplash: args.isFromSplash,
      );
    },
  );
}

class HealthCarePostFormArgs {
  const HealthCarePostFormArgs({
    this.key,
    this.postId,
    this.isFromSplash = false,
  });

  final _i78.Key? key;

  final int? postId;

  final bool isFromSplash;

  @override
  String toString() {
    return 'HealthCarePostFormArgs{key: $key, postId: $postId, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i28.HealthcarePostShift]
class HealthcarePostShift extends _i77.PageRouteInfo<HealthcarePostShiftArgs> {
  HealthcarePostShift({
    _i78.Key? key,
    required int postId,
    _i81.HealthcarePostDTO? updateShift,
    required _i82.PostShiftDTO post,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          HealthcarePostShift.name,
          args: HealthcarePostShiftArgs(
            key: key,
            postId: postId,
            updateShift: updateShift,
            post: post,
          ),
          initialChildren: children,
        );

  static const String name = 'HealthcarePostShift';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HealthcarePostShiftArgs>();
      return _i28.HealthcarePostShift(
        key: args.key,
        postId: args.postId,
        updateShift: args.updateShift,
        post: args.post,
      );
    },
  );
}

class HealthcarePostShiftArgs {
  const HealthcarePostShiftArgs({
    this.key,
    required this.postId,
    this.updateShift,
    required this.post,
  });

  final _i78.Key? key;

  final int postId;

  final _i81.HealthcarePostDTO? updateShift;

  final _i82.PostShiftDTO post;

  @override
  String toString() {
    return 'HealthcarePostShiftArgs{key: $key, postId: $postId, updateShift: $updateShift, post: $post}';
  }
}

/// generated route for
/// [_i29.HomeView]
class HomeView extends _i77.PageRouteInfo<void> {
  const HomeView({List<_i77.PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i29.HomeView();
    },
  );
}

/// generated route for
/// [_i30.IntroQuizScreen]
class IntroQuizScreen extends _i77.PageRouteInfo<void> {
  const IntroQuizScreen({List<_i77.PageRouteInfo>? children})
      : super(
          IntroQuizScreen.name,
          initialChildren: children,
        );

  static const String name = 'IntroQuizScreen';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return _i30.IntroQuizScreen();
    },
  );
}

/// generated route for
/// [_i31.IntroVideoScreen]
class IntroVideoScreen extends _i77.PageRouteInfo<void> {
  const IntroVideoScreen({List<_i77.PageRouteInfo>? children})
      : super(
          IntroVideoScreen.name,
          initialChildren: children,
        );

  static const String name = 'IntroVideoScreen';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return _i31.IntroVideoScreen();
    },
  );
}

/// generated route for
/// [_i32.LegalScreeningQuestionsPage]
class LegalScreeningQuestionsPage
    extends _i77.PageRouteInfo<LegalScreeningQuestionsPageArgs> {
  LegalScreeningQuestionsPage({
    _i78.Key? key,
    bool isFromSplash = false,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          LegalScreeningQuestionsPage.name,
          args: LegalScreeningQuestionsPageArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'LegalScreeningQuestionsPage';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LegalScreeningQuestionsPageArgs>(
          orElse: () => const LegalScreeningQuestionsPageArgs());
      return _i32.LegalScreeningQuestionsPage(
        key: args.key,
        isFromSplash: args.isFromSplash,
      );
    },
  );
}

class LegalScreeningQuestionsPageArgs {
  const LegalScreeningQuestionsPageArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i78.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'LegalScreeningQuestionsPageArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i33.LocationDetailForm]
class LocationDetailForm extends _i77.PageRouteInfo<LocationDetailFormArgs> {
  LocationDetailForm({
    _i78.Key? key,
    bool isFromSplash = false,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          LocationDetailForm.name,
          args: LocationDetailFormArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'LocationDetailForm';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LocationDetailFormArgs>(
          orElse: () => const LocationDetailFormArgs());
      return _i33.LocationDetailForm(
        key: args.key,
        isFromSplash: args.isFromSplash,
      );
    },
  );
}

class LocationDetailFormArgs {
  const LocationDetailFormArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i78.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'LocationDetailFormArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i34.LocationExample]
class LocationExample extends _i77.PageRouteInfo<void> {
  const LocationExample({List<_i77.PageRouteInfo>? children})
      : super(
          LocationExample.name,
          initialChildren: children,
        );

  static const String name = 'LocationExample';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return _i34.LocationExample();
    },
  );
}

/// generated route for
/// [_i35.LoginScreen]
class LoginPage extends _i77.PageRouteInfo<void> {
  const LoginPage({List<_i77.PageRouteInfo>? children})
      : super(
          LoginPage.name,
          initialChildren: children,
        );

  static const String name = 'LoginPage';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i35.LoginScreen();
    },
  );
}

/// generated route for
/// [_i36.MainTabView]
class MainTabView extends _i77.PageRouteInfo<void> {
  const MainTabView({List<_i77.PageRouteInfo>? children})
      : super(
          MainTabView.name,
          initialChildren: children,
        );

  static const String name = 'MainTabView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i36.MainTabView();
    },
  );
}

/// generated route for
/// [_i37.MultiAgreedShift]
class MultiAgreedShift extends _i77.PageRouteInfo<void> {
  const MultiAgreedShift({List<_i77.PageRouteInfo>? children})
      : super(
          MultiAgreedShift.name,
          initialChildren: children,
        );

  static const String name = 'MultiAgreedShift';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i37.MultiAgreedShift();
    },
  );
}

/// generated route for
/// [_i38.MyCalendarView]
class MyCalendarView extends _i77.PageRouteInfo<void> {
  const MyCalendarView({List<_i77.PageRouteInfo>? children})
      : super(
          MyCalendarView.name,
          initialChildren: children,
        );

  static const String name = 'MyCalendarView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i38.MyCalendarView();
    },
  );
}

/// generated route for
/// [_i39.NotificationView]
class NotificationView extends _i77.PageRouteInfo<void> {
  const NotificationView({List<_i77.PageRouteInfo>? children})
      : super(
          NotificationView.name,
          initialChildren: children,
        );

  static const String name = 'NotificationView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i39.NotificationView();
    },
  );
}

/// generated route for
/// [_i40.OnBoarding1]
class Onboarding1 extends _i77.PageRouteInfo<Onboarding1Args> {
  Onboarding1({
    _i78.Key? key,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          Onboarding1.name,
          args: Onboarding1Args(key: key),
          initialChildren: children,
        );

  static const String name = 'Onboarding1';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<Onboarding1Args>(orElse: () => const Onboarding1Args());
      return _i40.OnBoarding1(key: args.key);
    },
  );
}

class Onboarding1Args {
  const Onboarding1Args({this.key});

  final _i78.Key? key;

  @override
  String toString() {
    return 'Onboarding1Args{key: $key}';
  }
}

/// generated route for
/// [_i41.OnBoarding2]
class Onboarding2 extends _i77.PageRouteInfo<Onboarding2Args> {
  Onboarding2({
    _i78.Key? key,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          Onboarding2.name,
          args: Onboarding2Args(key: key),
          initialChildren: children,
        );

  static const String name = 'Onboarding2';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<Onboarding2Args>(orElse: () => const Onboarding2Args());
      return _i41.OnBoarding2(key: args.key);
    },
  );
}

class Onboarding2Args {
  const Onboarding2Args({this.key});

  final _i78.Key? key;

  @override
  String toString() {
    return 'Onboarding2Args{key: $key}';
  }
}

/// generated route for
/// [_i42.OnBoarding3]
class OnBoarding3 extends _i77.PageRouteInfo<OnBoarding3Args> {
  OnBoarding3({
    _i78.Key? key,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          OnBoarding3.name,
          args: OnBoarding3Args(key: key),
          initialChildren: children,
        );

  static const String name = 'OnBoarding3';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<OnBoarding3Args>(orElse: () => const OnBoarding3Args());
      return _i42.OnBoarding3(key: args.key);
    },
  );
}

class OnBoarding3Args {
  const OnBoarding3Args({this.key});

  final _i78.Key? key;

  @override
  String toString() {
    return 'OnBoarding3Args{key: $key}';
  }
}

/// generated route for
/// [_i43.PayableDetail]
class PayableDetail extends _i77.PageRouteInfo<PayableDetailArgs> {
  PayableDetail({
    _i78.Key? key,
    required _i81.HealthcarePostDTO post,
    bool isUpdate = false,
    _i82.PostShiftDTO? updatedPost,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          PayableDetail.name,
          args: PayableDetailArgs(
            key: key,
            post: post,
            isUpdate: isUpdate,
            updatedPost: updatedPost,
          ),
          initialChildren: children,
        );

  static const String name = 'PayableDetail';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PayableDetailArgs>();
      return _i43.PayableDetail(
        key: args.key,
        post: args.post,
        isUpdate: args.isUpdate,
        updatedPost: args.updatedPost,
      );
    },
  );
}

class PayableDetailArgs {
  const PayableDetailArgs({
    this.key,
    required this.post,
    this.isUpdate = false,
    this.updatedPost,
  });

  final _i78.Key? key;

  final _i81.HealthcarePostDTO post;

  final bool isUpdate;

  final _i82.PostShiftDTO? updatedPost;

  @override
  String toString() {
    return 'PayableDetailArgs{key: $key, post: $post, isUpdate: $isUpdate, updatedPost: $updatedPost}';
  }
}

/// generated route for
/// [_i44.PersonalReferenceDetail]
class PersonalReferenceDetail extends _i77.PageRouteInfo<void> {
  const PersonalReferenceDetail({List<_i77.PageRouteInfo>? children})
      : super(
          PersonalReferenceDetail.name,
          initialChildren: children,
        );

  static const String name = 'PersonalReferenceDetail';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i44.PersonalReferenceDetail();
    },
  );
}

/// generated route for
/// [_i45.PostShiftRecurring]
class PostShiftRecurring extends _i77.PageRouteInfo<PostShiftRecurringArgs> {
  PostShiftRecurring({
    _i78.Key? key,
    required int shiftType,
    required _i81.HealthcarePostDTO? updateShift,
    required _i82.PostShiftDTO post,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          PostShiftRecurring.name,
          args: PostShiftRecurringArgs(
            key: key,
            shiftType: shiftType,
            updateShift: updateShift,
            post: post,
          ),
          initialChildren: children,
        );

  static const String name = 'PostShiftRecurring';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostShiftRecurringArgs>();
      return _i45.PostShiftRecurring(
        key: args.key,
        shiftType: args.shiftType,
        updateShift: args.updateShift,
        post: args.post,
      );
    },
  );
}

class PostShiftRecurringArgs {
  const PostShiftRecurringArgs({
    this.key,
    required this.shiftType,
    required this.updateShift,
    required this.post,
  });

  final _i78.Key? key;

  final int shiftType;

  final _i81.HealthcarePostDTO? updateShift;

  final _i82.PostShiftDTO post;

  @override
  String toString() {
    return 'PostShiftRecurringArgs{key: $key, shiftType: $shiftType, updateShift: $updateShift, post: $post}';
  }
}

/// generated route for
/// [_i46.PreviousShiftView]
class PreviousShiftView extends _i77.PageRouteInfo<void> {
  const PreviousShiftView({List<_i77.PageRouteInfo>? children})
      : super(
          PreviousShiftView.name,
          initialChildren: children,
        );

  static const String name = 'PreviousShiftView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i46.PreviousShiftView();
    },
  );
}

/// generated route for
/// [_i47.PrivacyPolicyScreen]
class PrivacyPolicyScreen extends _i77.PageRouteInfo<PrivacyPolicyScreenArgs> {
  PrivacyPolicyScreen({
    _i78.Key? key,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          PrivacyPolicyScreen.name,
          args: PrivacyPolicyScreenArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'PrivacyPolicyScreen';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PrivacyPolicyScreenArgs>(
          orElse: () => const PrivacyPolicyScreenArgs());
      return _i47.PrivacyPolicyScreen(key: args.key);
    },
  );
}

class PrivacyPolicyScreenArgs {
  const PrivacyPolicyScreenArgs({this.key});

  final _i78.Key? key;

  @override
  String toString() {
    return 'PrivacyPolicyScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i48.ProfessionalReferenceDetail]
class ProfessionalReferenceDetail extends _i77.PageRouteInfo<void> {
  const ProfessionalReferenceDetail({List<_i77.PageRouteInfo>? children})
      : super(
          ProfessionalReferenceDetail.name,
          initialChildren: children,
        );

  static const String name = 'ProfessionalReferenceDetail';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i48.ProfessionalReferenceDetail();
    },
  );
}

/// generated route for
/// [_i49.ProfileView]
class ProfileView extends _i77.PageRouteInfo<void> {
  const ProfileView({List<_i77.PageRouteInfo>? children})
      : super(
          ProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ProfileView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i49.ProfileView();
    },
  );
}

/// generated route for
/// [_i50.ProposalReceived]
class ProposalReceived extends _i77.PageRouteInfo<ProposalReceivedArgs> {
  ProposalReceived({
    _i78.Key? key,
    required _i85.AppliedShiftDTO post,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          ProposalReceived.name,
          args: ProposalReceivedArgs(
            key: key,
            post: post,
          ),
          initialChildren: children,
        );

  static const String name = 'ProposalReceived';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProposalReceivedArgs>();
      return _i50.ProposalReceived(
        key: args.key,
        post: args.post,
      );
    },
  );
}

class ProposalReceivedArgs {
  const ProposalReceivedArgs({
    this.key,
    required this.post,
  });

  final _i78.Key? key;

  final _i85.AppliedShiftDTO post;

  @override
  String toString() {
    return 'ProposalReceivedArgs{key: $key, post: $post}';
  }
}

/// generated route for
/// [_i51.ProposeAvailability]
class ProposeAvailability extends _i77.PageRouteInfo<ProposeAvailabilityArgs> {
  ProposeAvailability({
    required _i81.HealthcarePostDTO post,
    List<_i86.DateTimeDTO>? updatedDates,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          ProposeAvailability.name,
          args: ProposeAvailabilityArgs(
            post: post,
            updatedDates: updatedDates,
          ),
          initialChildren: children,
        );

  static const String name = 'ProposeAvailability';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProposeAvailabilityArgs>();
      return _i51.ProposeAvailability(
        post: args.post,
        updatedDates: args.updatedDates,
      );
    },
  );
}

class ProposeAvailabilityArgs {
  const ProposeAvailabilityArgs({
    required this.post,
    this.updatedDates,
  });

  final _i81.HealthcarePostDTO post;

  final List<_i86.DateTimeDTO>? updatedDates;

  @override
  String toString() {
    return 'ProposeAvailabilityArgs{post: $post, updatedDates: $updatedDates}';
  }
}

/// generated route for
/// [_i52.QuizResultScreen]
class QuizResultScreen extends _i77.PageRouteInfo<void> {
  const QuizResultScreen({List<_i77.PageRouteInfo>? children})
      : super(
          QuizResultScreen.name,
          initialChildren: children,
        );

  static const String name = 'QuizResultScreen';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return _i52.QuizResultScreen();
    },
  );
}

/// generated route for
/// [_i53.ReferenceListScreen]
class ReferenceListScreen extends _i77.PageRouteInfo<ReferenceListScreenArgs> {
  ReferenceListScreen({
    _i78.Key? key,
    bool isFromSplash = false,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          ReferenceListScreen.name,
          args: ReferenceListScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'ReferenceListScreen';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReferenceListScreenArgs>(
          orElse: () => const ReferenceListScreenArgs());
      return _i53.ReferenceListScreen(
        key: args.key,
        isFromSplash: args.isFromSplash,
      );
    },
  );
}

class ReferenceListScreenArgs {
  const ReferenceListScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i78.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'ReferenceListScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i54.RegisterProfileScreen]
class RegisterProfilePage extends _i77.PageRouteInfo<RegisterProfilePageArgs> {
  RegisterProfilePage({
    _i78.Key? key,
    required String firstName,
    required String lastName,
    required int checkTermsPrivacy,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          RegisterProfilePage.name,
          args: RegisterProfilePageArgs(
            key: key,
            firstName: firstName,
            lastName: lastName,
            checkTermsPrivacy: checkTermsPrivacy,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterProfilePage';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterProfilePageArgs>();
      return _i54.RegisterProfileScreen(
        key: args.key,
        firstName: args.firstName,
        lastName: args.lastName,
        checkTermsPrivacy: args.checkTermsPrivacy,
      );
    },
  );
}

class RegisterProfilePageArgs {
  const RegisterProfilePageArgs({
    this.key,
    required this.firstName,
    required this.lastName,
    required this.checkTermsPrivacy,
  });

  final _i78.Key? key;

  final String firstName;

  final String lastName;

  final int checkTermsPrivacy;

  @override
  String toString() {
    return 'RegisterProfilePageArgs{key: $key, firstName: $firstName, lastName: $lastName, checkTermsPrivacy: $checkTermsPrivacy}';
  }
}

/// generated route for
/// [_i55.RegisterScreen]
class RegisterPage extends _i77.PageRouteInfo<void> {
  const RegisterPage({List<_i77.PageRouteInfo>? children})
      : super(
          RegisterPage.name,
          initialChildren: children,
        );

  static const String name = 'RegisterPage';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i55.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i56.ReviewPostShiftDetail]
class ReviewPostShiftDetail
    extends _i77.PageRouteInfo<ReviewPostShiftDetailArgs> {
  ReviewPostShiftDetail({
    _i78.Key? key,
    required _i81.HealthcarePostDTO post,
    bool isUpdate = false,
    _i82.PostShiftDTO? updatedPost,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          ReviewPostShiftDetail.name,
          args: ReviewPostShiftDetailArgs(
            key: key,
            post: post,
            isUpdate: isUpdate,
            updatedPost: updatedPost,
          ),
          initialChildren: children,
        );

  static const String name = 'ReviewPostShiftDetail';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReviewPostShiftDetailArgs>();
      return _i56.ReviewPostShiftDetail(
        key: args.key,
        post: args.post,
        isUpdate: args.isUpdate,
        updatedPost: args.updatedPost,
      );
    },
  );
}

class ReviewPostShiftDetailArgs {
  const ReviewPostShiftDetailArgs({
    this.key,
    required this.post,
    this.isUpdate = false,
    this.updatedPost,
  });

  final _i78.Key? key;

  final _i81.HealthcarePostDTO post;

  final bool isUpdate;

  final _i82.PostShiftDTO? updatedPost;

  @override
  String toString() {
    return 'ReviewPostShiftDetailArgs{key: $key, post: $post, isUpdate: $isUpdate, updatedPost: $updatedPost}';
  }
}

/// generated route for
/// [_i57.SendProposal]
class SendProposal extends _i77.PageRouteInfo<SendProposalArgs> {
  SendProposal({
    _i78.Key? key,
    required int postId,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          SendProposal.name,
          args: SendProposalArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'SendProposal';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SendProposalArgs>();
      return _i57.SendProposal(
        key: args.key,
        postId: args.postId,
      );
    },
  );
}

class SendProposalArgs {
  const SendProposalArgs({
    this.key,
    required this.postId,
  });

  final _i78.Key? key;

  final int postId;

  @override
  String toString() {
    return 'SendProposalArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i58.ShiftActionsView]
class ShiftActionsView extends _i77.PageRouteInfo<void> {
  const ShiftActionsView({List<_i77.PageRouteInfo>? children})
      : super(
          ShiftActionsView.name,
          initialChildren: children,
        );

  static const String name = 'ShiftActionsView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i58.ShiftActionsView();
    },
  );
}

/// generated route for
/// [_i59.ShowGoogleMap]
class ShowGoogleMap extends _i77.PageRouteInfo<ShowGoogleMapArgs> {
  ShowGoogleMap({
    _i78.Key? key,
    required double latitude,
    required double longitude,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          ShowGoogleMap.name,
          args: ShowGoogleMapArgs(
            key: key,
            latitude: latitude,
            longitude: longitude,
          ),
          initialChildren: children,
        );

  static const String name = 'ShowGoogleMap';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ShowGoogleMapArgs>();
      return _i59.ShowGoogleMap(
        key: args.key,
        latitude: args.latitude,
        longitude: args.longitude,
      );
    },
  );
}

class ShowGoogleMapArgs {
  const ShowGoogleMapArgs({
    this.key,
    required this.latitude,
    required this.longitude,
  });

  final _i78.Key? key;

  final double latitude;

  final double longitude;

  @override
  String toString() {
    return 'ShowGoogleMapArgs{key: $key, latitude: $latitude, longitude: $longitude}';
  }
}

/// generated route for
/// [_i60.SingleAgreedShift]
class SingleAgreedShift extends _i77.PageRouteInfo<void> {
  const SingleAgreedShift({List<_i77.PageRouteInfo>? children})
      : super(
          SingleAgreedShift.name,
          initialChildren: children,
        );

  static const String name = 'SingleAgreedShift';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i60.SingleAgreedShift();
    },
  );
}

/// generated route for
/// [_i61.SplashPage]
class SplashPage extends _i77.PageRouteInfo<void> {
  const SplashPage({List<_i77.PageRouteInfo>? children})
      : super(
          SplashPage.name,
          initialChildren: children,
        );

  static const String name = 'SplashPage';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i61.SplashPage();
    },
  );
}

/// generated route for
/// [_i62.TeamDetailView]
class TeamDetailView extends _i77.PageRouteInfo<TeamDetailViewArgs> {
  TeamDetailView({
    _i78.Key? key,
    required _i83.GetTeamsListDTO getTeamsListDTO,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          TeamDetailView.name,
          args: TeamDetailViewArgs(
            key: key,
            getTeamsListDTO: getTeamsListDTO,
          ),
          initialChildren: children,
        );

  static const String name = 'TeamDetailView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TeamDetailViewArgs>();
      return _i62.TeamDetailView(
        key: args.key,
        getTeamsListDTO: args.getTeamsListDTO,
      );
    },
  );
}

class TeamDetailViewArgs {
  const TeamDetailViewArgs({
    this.key,
    required this.getTeamsListDTO,
  });

  final _i78.Key? key;

  final _i83.GetTeamsListDTO getTeamsListDTO;

  @override
  String toString() {
    return 'TeamDetailViewArgs{key: $key, getTeamsListDTO: $getTeamsListDTO}';
  }
}

/// generated route for
/// [_i63.TeamsView]
class TeamsView extends _i77.PageRouteInfo<void> {
  const TeamsView({List<_i77.PageRouteInfo>? children})
      : super(
          TeamsView.name,
          initialChildren: children,
        );

  static const String name = 'TeamsView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i63.TeamsView();
    },
  );
}

/// generated route for
/// [_i64.TermsAndConditionsScreen]
class TermsAndConditionsScreen
    extends _i77.PageRouteInfo<TermsAndConditionsScreenArgs> {
  TermsAndConditionsScreen({
    _i78.Key? key,
    bool isFromSplash = false,
    bool isFromRegister = false,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          TermsAndConditionsScreen.name,
          args: TermsAndConditionsScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
            isFromRegister: isFromRegister,
          ),
          initialChildren: children,
        );

  static const String name = 'TermsAndConditionsScreen';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TermsAndConditionsScreenArgs>(
          orElse: () => const TermsAndConditionsScreenArgs());
      return _i64.TermsAndConditionsScreen(
        key: args.key,
        isFromSplash: args.isFromSplash,
        isFromRegister: args.isFromRegister,
      );
    },
  );
}

class TermsAndConditionsScreenArgs {
  const TermsAndConditionsScreenArgs({
    this.key,
    this.isFromSplash = false,
    this.isFromRegister = false,
  });

  final _i78.Key? key;

  final bool isFromSplash;

  final bool isFromRegister;

  @override
  String toString() {
    return 'TermsAndConditionsScreenArgs{key: $key, isFromSplash: $isFromSplash, isFromRegister: $isFromRegister}';
  }
}

/// generated route for
/// [_i65.TotalPraposalView]
class TotalPraposalView extends _i77.PageRouteInfo<void> {
  const TotalPraposalView({List<_i77.PageRouteInfo>? children})
      : super(
          TotalPraposalView.name,
          initialChildren: children,
        );

  static const String name = 'TotalPraposalView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i65.TotalPraposalView();
    },
  );
}

/// generated route for
/// [_i66.ViewAgreedPraposal]
class ViewAgreedPraposal extends _i77.PageRouteInfo<void> {
  const ViewAgreedPraposal({List<_i77.PageRouteInfo>? children})
      : super(
          ViewAgreedPraposal.name,
          initialChildren: children,
        );

  static const String name = 'ViewAgreedPraposal';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i66.ViewAgreedPraposal();
    },
  );
}

/// generated route for
/// [_i67.ViewApplicantProfile]
class ViewApplicantProfile extends _i77.PageRouteInfo<void> {
  const ViewApplicantProfile({List<_i77.PageRouteInfo>? children})
      : super(
          ViewApplicantProfile.name,
          initialChildren: children,
        );

  static const String name = 'ViewApplicantProfile';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i67.ViewApplicantProfile();
    },
  );
}

/// generated route for
/// [_i68.ViewContractorShift]
class ViewContractorShift extends _i77.PageRouteInfo<ViewContractorShiftArgs> {
  ViewContractorShift({
    _i78.Key? key,
    required int postId,
    bool isTotalApplicants = false,
    bool fromDashboard = false,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          ViewContractorShift.name,
          args: ViewContractorShiftArgs(
            key: key,
            postId: postId,
            isTotalApplicants: isTotalApplicants,
            fromDashboard: fromDashboard,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewContractorShift';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewContractorShiftArgs>();
      return _i68.ViewContractorShift(
        key: args.key,
        postId: args.postId,
        isTotalApplicants: args.isTotalApplicants,
        fromDashboard: args.fromDashboard,
      );
    },
  );
}

class ViewContractorShiftArgs {
  const ViewContractorShiftArgs({
    this.key,
    required this.postId,
    this.isTotalApplicants = false,
    this.fromDashboard = false,
  });

  final _i78.Key? key;

  final int postId;

  final bool isTotalApplicants;

  final bool fromDashboard;

  @override
  String toString() {
    return 'ViewContractorShiftArgs{key: $key, postId: $postId, isTotalApplicants: $isTotalApplicants, fromDashboard: $fromDashboard}';
  }
}

/// generated route for
/// [_i69.ViewContractorShiftDates]
class ViewContractorShiftDates
    extends _i77.PageRouteInfo<ViewContractorShiftDatesArgs> {
  ViewContractorShiftDates({
    _i78.Key? key,
    required _i87.ContactorDashboardDTO shiftDetail,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          ViewContractorShiftDates.name,
          args: ViewContractorShiftDatesArgs(
            key: key,
            shiftDetail: shiftDetail,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewContractorShiftDates';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewContractorShiftDatesArgs>();
      return _i69.ViewContractorShiftDates(
        key: args.key,
        shiftDetail: args.shiftDetail,
      );
    },
  );
}

class ViewContractorShiftDatesArgs {
  const ViewContractorShiftDatesArgs({
    this.key,
    required this.shiftDetail,
  });

  final _i78.Key? key;

  final _i87.ContactorDashboardDTO shiftDetail;

  @override
  String toString() {
    return 'ViewContractorShiftDatesArgs{key: $key, shiftDetail: $shiftDetail}';
  }
}

/// generated route for
/// [_i70.ViewDates]
class ViewDates extends _i77.PageRouteInfo<ViewDatesArgs> {
  ViewDates({
    _i78.Key? key,
    required _i88.ShiftDetailDTO shiftDetail,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          ViewDates.name,
          args: ViewDatesArgs(
            key: key,
            shiftDetail: shiftDetail,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewDates';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewDatesArgs>();
      return _i70.ViewDates(
        key: args.key,
        shiftDetail: args.shiftDetail,
      );
    },
  );
}

class ViewDatesArgs {
  const ViewDatesArgs({
    this.key,
    required this.shiftDetail,
  });

  final _i78.Key? key;

  final _i88.ShiftDetailDTO shiftDetail;

  @override
  String toString() {
    return 'ViewDatesArgs{key: $key, shiftDetail: $shiftDetail}';
  }
}

/// generated route for
/// [_i71.ViewFilledShiftsDates]
class ViewFilledShiftsDates extends _i77.PageRouteInfo<void> {
  const ViewFilledShiftsDates({List<_i77.PageRouteInfo>? children})
      : super(
          ViewFilledShiftsDates.name,
          initialChildren: children,
        );

  static const String name = 'ViewFilledShiftsDates';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i71.ViewFilledShiftsDates();
    },
  );
}

/// generated route for
/// [_i72.ViewFilledShiftsDetails]
class ViewFilledShiftsDetails extends _i77.PageRouteInfo<void> {
  const ViewFilledShiftsDetails({List<_i77.PageRouteInfo>? children})
      : super(
          ViewFilledShiftsDetails.name,
          initialChildren: children,
        );

  static const String name = 'ViewFilledShiftsDetails';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i72.ViewFilledShiftsDetails();
    },
  );
}

/// generated route for
/// [_i73.ViewHomeShiftDetails]
class ViewHomeShiftDetails
    extends _i77.PageRouteInfo<ViewHomeShiftDetailsArgs> {
  ViewHomeShiftDetails({
    _i78.Key? key,
    required int postId,
    _i89.ShiftDetailRoute? route,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          ViewHomeShiftDetails.name,
          args: ViewHomeShiftDetailsArgs(
            key: key,
            postId: postId,
            route: route,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewHomeShiftDetails';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewHomeShiftDetailsArgs>();
      return _i73.ViewHomeShiftDetails(
        key: args.key,
        postId: args.postId,
        route: args.route,
      );
    },
  );
}

class ViewHomeShiftDetailsArgs {
  const ViewHomeShiftDetailsArgs({
    this.key,
    required this.postId,
    this.route,
  });

  final _i78.Key? key;

  final int postId;

  final _i89.ShiftDetailRoute? route;

  @override
  String toString() {
    return 'ViewHomeShiftDetailsArgs{key: $key, postId: $postId, route: $route}';
  }
}

/// generated route for
/// [_i74.ViewPersonPraposalView]
class ViewPersonPraposalView extends _i77.PageRouteInfo<void> {
  const ViewPersonPraposalView({List<_i77.PageRouteInfo>? children})
      : super(
          ViewPersonPraposalView.name,
          initialChildren: children,
        );

  static const String name = 'ViewPersonPraposalView';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      return const _i74.ViewPersonPraposalView();
    },
  );
}

/// generated route for
/// [_i75.ViewSingleApplicants]
class ViewSingleApplicants
    extends _i77.PageRouteInfo<ViewSingleApplicantsArgs> {
  ViewSingleApplicants({
    _i78.Key? key,
    required int postId,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          ViewSingleApplicants.name,
          args: ViewSingleApplicantsArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewSingleApplicants';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewSingleApplicantsArgs>();
      return _i75.ViewSingleApplicants(
        key: args.key,
        postId: args.postId,
      );
    },
  );
}

class ViewSingleApplicantsArgs {
  const ViewSingleApplicantsArgs({
    this.key,
    required this.postId,
  });

  final _i78.Key? key;

  final int postId;

  @override
  String toString() {
    return 'ViewSingleApplicantsArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i76.ViewUpcomingShiftDetails]
class ViewUpcomingShiftDetails
    extends _i77.PageRouteInfo<ViewUpcomingShiftDetailsArgs> {
  ViewUpcomingShiftDetails({
    _i78.Key? key,
    required int postId,
    bool isTotalApplicants = false,
    List<_i77.PageRouteInfo>? children,
  }) : super(
          ViewUpcomingShiftDetails.name,
          args: ViewUpcomingShiftDetailsArgs(
            key: key,
            postId: postId,
            isTotalApplicants: isTotalApplicants,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewUpcomingShiftDetails';

  static _i77.PageInfo page = _i77.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewUpcomingShiftDetailsArgs>();
      return _i76.ViewUpcomingShiftDetails(
        key: args.key,
        postId: args.postId,
        isTotalApplicants: args.isTotalApplicants,
      );
    },
  );
}

class ViewUpcomingShiftDetailsArgs {
  const ViewUpcomingShiftDetailsArgs({
    this.key,
    required this.postId,
    this.isTotalApplicants = false,
  });

  final _i78.Key? key;

  final int postId;

  final bool isTotalApplicants;

  @override
  String toString() {
    return 'ViewUpcomingShiftDetailsArgs{key: $key, postId: $postId, isTotalApplicants: $isTotalApplicants}';
  }
}
