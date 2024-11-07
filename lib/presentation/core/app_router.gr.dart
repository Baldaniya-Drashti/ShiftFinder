// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i110;
import 'package:flutter/material.dart' as _i111;
import 'package:shift/application/auth/contractor_auth/location_example.dart'
    as _i59;
import 'package:shift/infrastructure/contractor_main/shift/applied_shift_dto/applied_shift_dto.dart'
    as _i121;
import 'package:shift/infrastructure/core/applicant_dto/applicant_dto.dart'
    as _i120;
import 'package:shift/infrastructure/core/contractor_home/contractor_dashboard_dto.dart'
    as _i123;
import 'package:shift/infrastructure/core/education_dto/education_dto.dart'
    as _i112;
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart'
    as _i119;
import 'package:shift/infrastructure/core/reference_dto/reference_dto.dart'
    as _i117;
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart'
    as _i122;
import 'package:shift/infrastructure/main/employer_team/get_teams_dto.dart'
    as _i116;
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart'
    as _i114;
import 'package:shift/infrastructure/main/hired_contractor_list_dto/hired_contractor_list_dto.dart'
    as _i118;
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart'
    as _i113;
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart'
    as _i115;
import 'package:shift/infrastructure/main/shift_detail_dto/shift_detail_dto.dart'
    as _i124;
import 'package:shift/presentation/about/about_view.dart' as _i1;
import 'package:shift/presentation/about/cancellation_policy_view.dart' as _i19;
import 'package:shift/presentation/about/faq_view.dart' as _i46;
import 'package:shift/presentation/account_management/account_management_view.dart'
    as _i2;
import 'package:shift/presentation/account_management/change_password_view.dart'
    as _i21;
import 'package:shift/presentation/auth/contractor_auth/add_bank_details.dart'
    as _i3;
import 'package:shift/presentation/auth/contractor_auth/add_contractor_skills.dart'
    as _i6;
import 'package:shift/presentation/auth/contractor_auth/add_experience_detail.dart'
    as _i8;
import 'package:shift/presentation/auth/contractor_auth/add_speciality_experience.dart'
    as _i13;
import 'package:shift/presentation/auth/contractor_auth/documents/document_page.dart'
    as _i38;
import 'package:shift/presentation/auth/contractor_auth/education_details/add_education_detail.dart'
    as _i7;
import 'package:shift/presentation/auth/contractor_auth/education_details/education_detail_list.dart'
    as _i40;
import 'package:shift/presentation/auth/contractor_auth/intro_quiz.dart'
    as _i53;
import 'package:shift/presentation/auth/contractor_auth/intro_video.dart'
    as _i54;
import 'package:shift/presentation/auth/contractor_auth/legal_screening_questions.dart'
    as _i57;
import 'package:shift/presentation/auth/contractor_auth/quiz_result.dart'
    as _i83;
import 'package:shift/presentation/auth/contractor_auth/reference_details/add_reference_detail.dart'
    as _i12;
import 'package:shift/presentation/auth/contractor_auth/reference_details/reference_detail_list.dart'
    as _i85;
import 'package:shift/presentation/auth/contractor_auth/terms_conditions.dart'
    as _i97;
import 'package:shift/presentation/auth/employer_auth/add_card_detail.dart'
    as _i4;
import 'package:shift/presentation/auth/employer_auth/location_detail_form.dart'
    as _i58;
import 'package:shift/presentation/auth/login/login_screen.dart' as _i60;
import 'package:shift/presentation/auth/register/register_profile.dart' as _i86;
import 'package:shift/presentation/auth/register/register_screen.dart' as _i87;
import 'package:shift/presentation/billing/billing_view.dart' as _i18;
import 'package:shift/presentation/billing/invoice_detail_view.dart' as _i55;
import 'package:shift/presentation/billing/invoice_view.dart' as _i56;
import 'package:shift/presentation/billing/monthly_statement_view.dart' as _i62;
import 'package:shift/presentation/billing/payment_history_view.dart' as _i70;
import 'package:shift/presentation/billing/payment_method_view.dart' as _i71;
import 'package:shift/presentation/contractor/bank_detail/bank_detail_view.dart'
    as _i17;
import 'package:shift/presentation/contractor/contractor_main/contractor_main_tab.dart'
    as _i25;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/contracator_home.dart'
    as _i24;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/send_proposal/propose_availability.dart'
    as _i82;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/send_proposal/send_proposal.dart'
    as _i89;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/view_contractor_shift.dart'
    as _i101;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/view_contractor_shift_dates.dart'
    as _i102;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_profile/contractor_profile.dart'
    as _i28;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/applied_shift/proposal_received.dart'
    as _i81;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/contractor_shifts.dart'
    as _i30;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/view_upcoming_shit.dart'
    as _i109;
import 'package:shift/presentation/contractor/contractor_performance_insight/contractor_performance_insight_view.dart'
    as _i26;
import 'package:shift/presentation/contractor/contractor_previous_shift/contractor_previous_shift_view.dart'
    as _i27;
import 'package:shift/presentation/contractor/contractor_rating/contractor_rating_view.dart'
    as _i29;
import 'package:shift/presentation/contractor/contractor_update_profile/contractor_update_profile_view.dart'
    as _i33;
import 'package:shift/presentation/contractor/my_calendar_view/my_calendar_view.dart'
    as _i64;
import 'package:shift/presentation/contractor/refer_colleague/refer_colleague_view.dart'
    as _i84;
import 'package:shift/presentation/contractor_earning/contractor_earning_view.dart'
    as _i23;
import 'package:shift/presentation/contractor_earning/contractor_statement_view.dart'
    as _i31;
import 'package:shift/presentation/contractor_earning/contractor_total_earning_view.dart'
    as _i32;
import 'package:shift/presentation/contractor_earning/contractor_wallet_view.dart'
    as _i34;
import 'package:shift/presentation/contractor_earning/contractor_withdraw_payment_view.dart'
    as _i35;
import 'package:shift/presentation/core/enum.dart' as _i125;
import 'package:shift/presentation/core/widgets/google_map/show_google_map.dart'
    as _i91;
import 'package:shift/presentation/customer_support/customer_support_view.dart'
    as _i37;
import 'package:shift/presentation/customer_support/support_ticket_view.dart'
    as _i94;
import 'package:shift/presentation/employer/employer_availability/employer_availability_view.dart'
    as _i42;
import 'package:shift/presentation/employer/employer_location/employer_location_form_view.dart'
    as _i43;
import 'package:shift/presentation/employer/employer_location/employer_location_view.dart'
    as _i44;
import 'package:shift/presentation/employer/healthcare_post/add_multi_date_time.dart'
    as _i9;
import 'package:shift/presentation/employer/healthcare_post/healthcare_post.dart'
    as _i49;
import 'package:shift/presentation/employer/healthcare_post/healthcare_post_shit_type.dart'
    as _i50;
import 'package:shift/presentation/employer/healthcare_post/payable_detail.dart'
    as _i69;
import 'package:shift/presentation/employer/healthcare_post/post_shift_recurring.dart'
    as _i74;
import 'package:shift/presentation/employer/healthcare_post/review_post_detail.dart'
    as _i88;
import 'package:shift/presentation/employer/hired_contractor/hired_contractor_view.dart'
    as _i51;
import 'package:shift/presentation/employer/home_view/view_dates.dart' as _i103;
import 'package:shift/presentation/employer/home_view/view_shift_details.dart'
    as _i106;
import 'package:shift/presentation/employer/profile/edit_profile/edit_profile_view.dart'
    as _i39;
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart'
    as _i75;
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_view.dart'
    as _i76;
import 'package:shift/presentation/main/main_tab.dart' as _i61;
import 'package:shift/presentation/main/tabs/employer_shift_view.dart' as _i45;
import 'package:shift/presentation/main/tabs/home/home_view.dart' as _i52;
import 'package:shift/presentation/main/tabs/home/praposals/counter_prapose/awaiting_confirmation_view.dart'
    as _i16;
import 'package:shift/presentation/main/tabs/home/praposals/counter_prapose/counter_purpose_view.dart'
    as _i36;
import 'package:shift/presentation/main/tabs/home/praposals/total_praposal_view.dart'
    as _i98;
import 'package:shift/presentation/main/tabs/home/praposals/widgets/view_person_praposal_view.dart'
    as _i107;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/education_profile_view.dart'
    as _i41;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/personal_profile_view.dart'
    as _i72;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/professional_profile_view.dart'
    as _i78;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/view_applicant_profile.dart'
    as _i100;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/common_document_view.dart'
    as _i22;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/personal_reference_detail.dart'
    as _i73;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/professional_reference_detail.dart'
    as _i79;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_single_applicants.dart'
    as _i108;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/add_card_view.dart'
    as _i5;
import 'package:shift/presentation/main/tabs/notification_view.dart' as _i65;
import 'package:shift/presentation/main/tabs/profile/profile_view.dart' as _i80;
import 'package:shift/presentation/main/tabs/profile/teams/add_new_member/add_new_member_view.dart'
    as _i10;
import 'package:shift/presentation/main/tabs/profile/teams/add_new_team/add_new_team_view.dart'
    as _i11;
import 'package:shift/presentation/main/tabs/profile/teams/team_detail/team_detail_view.dart'
    as _i95;
import 'package:shift/presentation/main/tabs/profile/teams/teams_view.dart'
    as _i96;
import 'package:shift/presentation/main/tabs/shifts/agreed_proposal.dart'
    as _i14;
import 'package:shift/presentation/main/tabs/shifts/approved_shifts/widgets/approved_contractor_list.dart'
    as _i15;
import 'package:shift/presentation/main/tabs/shifts/cancelled_shifts/widgets/cancel_contractor_list.dart'
    as _i20;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/filled_shifts_view.dart'
    as _i48;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/filled_hired_contractor_list.dart'
    as _i47;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/view_agreed_praposal.dart'
    as _i99;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/view_filled_shifts_dates.dart'
    as _i104;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/view_filled_shifts_details.dart'
    as _i105;
import 'package:shift/presentation/main/tabs/shifts/multi_agreed_shift.dart'
    as _i63;
import 'package:shift/presentation/main/tabs/shifts/shift_actions_view.dart'
    as _i90;
import 'package:shift/presentation/main/tabs/shifts/single_agreed_shift.dart'
    as _i92;
import 'package:shift/presentation/onboarding/onboarding1.dart' as _i66;
import 'package:shift/presentation/onboarding/onboarding2.dart' as _i67;
import 'package:shift/presentation/onboarding/onboarding3.dart' as _i68;
import 'package:shift/presentation/privacy_policy/privacy_policy.dart' as _i77;
import 'package:shift/presentation/splash/splash_page.dart' as _i93;

/// generated route for
/// [_i1.AboutView]
class AboutView extends _i110.PageRouteInfo<void> {
  const AboutView({List<_i110.PageRouteInfo>? children})
      : super(
          AboutView.name,
          initialChildren: children,
        );

  static const String name = 'AboutView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutView();
    },
  );
}

/// generated route for
/// [_i2.AccountManagementView]
class AccountManagementView extends _i110.PageRouteInfo<void> {
  const AccountManagementView({List<_i110.PageRouteInfo>? children})
      : super(
          AccountManagementView.name,
          initialChildren: children,
        );

  static const String name = 'AccountManagementView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i2.AccountManagementView();
    },
  );
}

/// generated route for
/// [_i3.AddBankDetailsScreen]
class AddBankDetailsScreen
    extends _i110.PageRouteInfo<AddBankDetailsScreenArgs> {
  AddBankDetailsScreen({
    _i111.Key? key,
    bool isFromSplash = false,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          AddBankDetailsScreen.name,
          args: AddBankDetailsScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddBankDetailsScreen';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddBankDetailsScreenArgs>(
          orElse: () => const AddBankDetailsScreenArgs());
      return _i3.AddBankDetailsScreen(
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

  final _i111.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddBankDetailsScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i4.AddCardDetailPage]
class AddCardDetailPage extends _i110.PageRouteInfo<AddCardDetailPageArgs> {
  AddCardDetailPage({
    _i111.Key? key,
    bool isFromSplash = false,
    bool fromRegister = true,
    List<_i110.PageRouteInfo>? children,
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

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddCardDetailPageArgs>(
          orElse: () => const AddCardDetailPageArgs());
      return _i4.AddCardDetailPage(
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

  final _i111.Key? key;

  final bool isFromSplash;

  final bool fromRegister;

  @override
  String toString() {
    return 'AddCardDetailPageArgs{key: $key, isFromSplash: $isFromSplash, fromRegister: $fromRegister}';
  }
}

/// generated route for
/// [_i5.AddCardView]
class AddCardView extends _i110.PageRouteInfo<void> {
  const AddCardView({List<_i110.PageRouteInfo>? children})
      : super(
          AddCardView.name,
          initialChildren: children,
        );

  static const String name = 'AddCardView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i5.AddCardView();
    },
  );
}

/// generated route for
/// [_i6.AddContractorSkillsForm]
class AddContractorSkillsForm
    extends _i110.PageRouteInfo<AddContractorSkillsFormArgs> {
  AddContractorSkillsForm({
    _i111.Key? key,
    bool isFromSplash = false,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          AddContractorSkillsForm.name,
          args: AddContractorSkillsFormArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddContractorSkillsForm';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddContractorSkillsFormArgs>(
          orElse: () => const AddContractorSkillsFormArgs());
      return _i6.AddContractorSkillsForm(
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

  final _i111.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddContractorSkillsFormArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i7.AddEducationDetail]
class AddEducationDetailScreen
    extends _i110.PageRouteInfo<AddEducationDetailScreenArgs> {
  AddEducationDetailScreen({
    _i111.Key? key,
    bool isFromSplash = false,
    _i112.EducationDTO? educationObj,
    bool readOnly = false,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          AddEducationDetailScreen.name,
          args: AddEducationDetailScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
            educationObj: educationObj,
            readOnly: readOnly,
          ),
          initialChildren: children,
        );

  static const String name = 'AddEducationDetailScreen';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddEducationDetailScreenArgs>(
          orElse: () => const AddEducationDetailScreenArgs());
      return _i7.AddEducationDetail(
        key: args.key,
        isFromSplash: args.isFromSplash,
        educationObj: args.educationObj,
        readOnly: args.readOnly,
      );
    },
  );
}

class AddEducationDetailScreenArgs {
  const AddEducationDetailScreenArgs({
    this.key,
    this.isFromSplash = false,
    this.educationObj,
    this.readOnly = false,
  });

  final _i111.Key? key;

  final bool isFromSplash;

  final _i112.EducationDTO? educationObj;

  final bool readOnly;

  @override
  String toString() {
    return 'AddEducationDetailScreenArgs{key: $key, isFromSplash: $isFromSplash, educationObj: $educationObj, readOnly: $readOnly}';
  }
}

/// generated route for
/// [_i8.AddExperienceDetail]
class AddExperienceDetailScreen
    extends _i110.PageRouteInfo<AddExperienceDetailScreenArgs> {
  AddExperienceDetailScreen({
    _i111.Key? key,
    bool isFromSplash = false,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          AddExperienceDetailScreen.name,
          args: AddExperienceDetailScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddExperienceDetailScreen';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddExperienceDetailScreenArgs>(
          orElse: () => const AddExperienceDetailScreenArgs());
      return _i8.AddExperienceDetail(
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

  final _i111.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddExperienceDetailScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i9.AddMultiDateTime]
class AddMultiDateTime extends _i110.PageRouteInfo<AddMultiDateTimeArgs> {
  AddMultiDateTime({
    _i111.Key? key,
    required _i113.MultiShiftDTO selectedObj,
    _i114.HealthcarePostDTO? updateShift,
    required _i115.PostShiftDTO post,
    List<_i110.PageRouteInfo>? children,
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

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddMultiDateTimeArgs>();
      return _i9.AddMultiDateTime(
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

  final _i111.Key? key;

  final _i113.MultiShiftDTO selectedObj;

  final _i114.HealthcarePostDTO? updateShift;

  final _i115.PostShiftDTO post;

  @override
  String toString() {
    return 'AddMultiDateTimeArgs{key: $key, selectedObj: $selectedObj, updateShift: $updateShift, post: $post}';
  }
}

/// generated route for
/// [_i10.AddNewMemberView]
class AddNewMemberView extends _i110.PageRouteInfo<AddNewMemberViewArgs> {
  AddNewMemberView({
    _i111.Key? key,
    bool isUpdateMember = false,
    required _i116.Members? getTeamsListDTO,
    required String teamID,
    List<_i110.PageRouteInfo>? children,
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

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddNewMemberViewArgs>();
      return _i10.AddNewMemberView(
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

  final _i111.Key? key;

  final bool isUpdateMember;

  final _i116.Members? getTeamsListDTO;

  final String teamID;

  @override
  String toString() {
    return 'AddNewMemberViewArgs{key: $key, isUpdateMember: $isUpdateMember, getTeamsListDTO: $getTeamsListDTO, teamID: $teamID}';
  }
}

/// generated route for
/// [_i11.AddNewTeamView]
class AddNewTeamView extends _i110.PageRouteInfo<AddNewTeamViewArgs> {
  AddNewTeamView({
    _i111.Key? key,
    bool isUpdateMember = false,
    _i116.GetTeamsListDTO? getTeamsListDTO,
    List<_i110.PageRouteInfo>? children,
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

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddNewTeamViewArgs>(
          orElse: () => const AddNewTeamViewArgs());
      return _i11.AddNewTeamView(
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

  final _i111.Key? key;

  final bool isUpdateMember;

  final _i116.GetTeamsListDTO? getTeamsListDTO;

  @override
  String toString() {
    return 'AddNewTeamViewArgs{key: $key, isUpdateMember: $isUpdateMember, getTeamsListDTO: $getTeamsListDTO}';
  }
}

/// generated route for
/// [_i12.AddReferenceDetail]
class AddReferenceDetailScreen
    extends _i110.PageRouteInfo<AddReferenceDetailScreenArgs> {
  AddReferenceDetailScreen({
    _i111.Key? key,
    bool isFromSplash = false,
    _i117.ReferenceDTO? referenceObj,
    bool readOnly = false,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          AddReferenceDetailScreen.name,
          args: AddReferenceDetailScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
            referenceObj: referenceObj,
            readOnly: readOnly,
          ),
          initialChildren: children,
        );

  static const String name = 'AddReferenceDetailScreen';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddReferenceDetailScreenArgs>(
          orElse: () => const AddReferenceDetailScreenArgs());
      return _i12.AddReferenceDetail(
        key: args.key,
        isFromSplash: args.isFromSplash,
        referenceObj: args.referenceObj,
        readOnly: args.readOnly,
      );
    },
  );
}

class AddReferenceDetailScreenArgs {
  const AddReferenceDetailScreenArgs({
    this.key,
    this.isFromSplash = false,
    this.referenceObj,
    this.readOnly = false,
  });

  final _i111.Key? key;

  final bool isFromSplash;

  final _i117.ReferenceDTO? referenceObj;

  final bool readOnly;

  @override
  String toString() {
    return 'AddReferenceDetailScreenArgs{key: $key, isFromSplash: $isFromSplash, referenceObj: $referenceObj, readOnly: $readOnly}';
  }
}

/// generated route for
/// [_i13.AddSpecialityExperience]
class AddSpecialityExperience
    extends _i110.PageRouteInfo<AddSpecialityExperienceArgs> {
  AddSpecialityExperience({
    _i111.Key? key,
    bool isFromSplash = false,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          AddSpecialityExperience.name,
          args: AddSpecialityExperienceArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddSpecialityExperience';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddSpecialityExperienceArgs>(
          orElse: () => const AddSpecialityExperienceArgs());
      return _i13.AddSpecialityExperience(
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

  final _i111.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddSpecialityExperienceArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i14.AgreedProposal]
class AgreedProposal extends _i110.PageRouteInfo<AgreedProposalArgs> {
  AgreedProposal({
    _i111.Key? key,
    required _i118.HiredContractorListDTO post,
    required int userId,
    required int postId,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          AgreedProposal.name,
          args: AgreedProposalArgs(
            key: key,
            post: post,
            userId: userId,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'AgreedProposal';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AgreedProposalArgs>();
      return _i14.AgreedProposal(
        key: args.key,
        post: args.post,
        userId: args.userId,
        postId: args.postId,
      );
    },
  );
}

class AgreedProposalArgs {
  const AgreedProposalArgs({
    this.key,
    required this.post,
    required this.userId,
    required this.postId,
  });

  final _i111.Key? key;

  final _i118.HiredContractorListDTO post;

  final int userId;

  final int postId;

  @override
  String toString() {
    return 'AgreedProposalArgs{key: $key, post: $post, userId: $userId, postId: $postId}';
  }
}

/// generated route for
/// [_i15.ApprovedHiredList]
class ApprovedHiredList extends _i110.PageRouteInfo<ApprovedHiredListArgs> {
  ApprovedHiredList({
    _i111.Key? key,
    required int postId,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          ApprovedHiredList.name,
          args: ApprovedHiredListArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'ApprovedHiredList';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ApprovedHiredListArgs>();
      return _i15.ApprovedHiredList(
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

  final _i111.Key? key;

  final int postId;

  @override
  String toString() {
    return 'ApprovedHiredListArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i16.AwaitingConfirmationView]
class AwaitingConfirmationView extends _i110.PageRouteInfo<void> {
  const AwaitingConfirmationView({List<_i110.PageRouteInfo>? children})
      : super(
          AwaitingConfirmationView.name,
          initialChildren: children,
        );

  static const String name = 'AwaitingConfirmationView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i16.AwaitingConfirmationView();
    },
  );
}

/// generated route for
/// [_i17.BankDetailView]
class BankDetailView extends _i110.PageRouteInfo<void> {
  const BankDetailView({List<_i110.PageRouteInfo>? children})
      : super(
          BankDetailView.name,
          initialChildren: children,
        );

  static const String name = 'BankDetailView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i17.BankDetailView();
    },
  );
}

/// generated route for
/// [_i18.BillingView]
class BillingView extends _i110.PageRouteInfo<void> {
  const BillingView({List<_i110.PageRouteInfo>? children})
      : super(
          BillingView.name,
          initialChildren: children,
        );

  static const String name = 'BillingView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i18.BillingView();
    },
  );
}

/// generated route for
/// [_i19.CancellationPolicyView]
class CancellationPolicyView extends _i110.PageRouteInfo<void> {
  const CancellationPolicyView({List<_i110.PageRouteInfo>? children})
      : super(
          CancellationPolicyView.name,
          initialChildren: children,
        );

  static const String name = 'CancellationPolicyView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i19.CancellationPolicyView();
    },
  );
}

/// generated route for
/// [_i20.CancelledContractorList]
class CancelledContractorList
    extends _i110.PageRouteInfo<CancelledContractorListArgs> {
  CancelledContractorList({
    required String title,
    required int postId,
    required int cancelFilter,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          CancelledContractorList.name,
          args: CancelledContractorListArgs(
            title: title,
            postId: postId,
            cancelFilter: cancelFilter,
          ),
          initialChildren: children,
        );

  static const String name = 'CancelledContractorList';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CancelledContractorListArgs>();
      return _i20.CancelledContractorList(
        title: args.title,
        postId: args.postId,
        cancelFilter: args.cancelFilter,
      );
    },
  );
}

class CancelledContractorListArgs {
  const CancelledContractorListArgs({
    required this.title,
    required this.postId,
    required this.cancelFilter,
  });

  final String title;

  final int postId;

  final int cancelFilter;

  @override
  String toString() {
    return 'CancelledContractorListArgs{title: $title, postId: $postId, cancelFilter: $cancelFilter}';
  }
}

/// generated route for
/// [_i21.ChangePasswordView]
class ChangePasswordView extends _i110.PageRouteInfo<void> {
  const ChangePasswordView({List<_i110.PageRouteInfo>? children})
      : super(
          ChangePasswordView.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i21.ChangePasswordView();
    },
  );
}

/// generated route for
/// [_i22.CommonDocumentView]
class CommonDocumentView extends _i110.PageRouteInfo<CommonDocumentViewArgs> {
  CommonDocumentView({
    _i111.Key? key,
    required String title,
    required String pdfUrl,
    List<_i110.PageRouteInfo>? children,
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

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CommonDocumentViewArgs>();
      return _i22.CommonDocumentView(
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

  final _i111.Key? key;

  final String title;

  final String pdfUrl;

  @override
  String toString() {
    return 'CommonDocumentViewArgs{key: $key, title: $title, pdfUrl: $pdfUrl}';
  }
}

/// generated route for
/// [_i23.ContractorEarningView]
class ContractorEarningView extends _i110.PageRouteInfo<void> {
  const ContractorEarningView({List<_i110.PageRouteInfo>? children})
      : super(
          ContractorEarningView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorEarningView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i23.ContractorEarningView();
    },
  );
}

/// generated route for
/// [_i24.ContractorHomeView]
class ContractorHomeView extends _i110.PageRouteInfo<void> {
  const ContractorHomeView({List<_i110.PageRouteInfo>? children})
      : super(
          ContractorHomeView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorHomeView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i24.ContractorHomeView();
    },
  );
}

/// generated route for
/// [_i25.ContractorMainTabView]
class ContractorMainTabView extends _i110.PageRouteInfo<void> {
  const ContractorMainTabView({List<_i110.PageRouteInfo>? children})
      : super(
          ContractorMainTabView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorMainTabView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i25.ContractorMainTabView();
    },
  );
}

/// generated route for
/// [_i26.ContractorPerformanceInsightView]
class ContractorPerformanceInsightView extends _i110.PageRouteInfo<void> {
  const ContractorPerformanceInsightView({List<_i110.PageRouteInfo>? children})
      : super(
          ContractorPerformanceInsightView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorPerformanceInsightView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i26.ContractorPerformanceInsightView();
    },
  );
}

/// generated route for
/// [_i27.ContractorPreviousShiftView]
class ContractorPreviousShiftView extends _i110.PageRouteInfo<void> {
  const ContractorPreviousShiftView({List<_i110.PageRouteInfo>? children})
      : super(
          ContractorPreviousShiftView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorPreviousShiftView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i27.ContractorPreviousShiftView();
    },
  );
}

/// generated route for
/// [_i28.ContractorProfileView]
class ContractorProfileView extends _i110.PageRouteInfo<void> {
  const ContractorProfileView({List<_i110.PageRouteInfo>? children})
      : super(
          ContractorProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorProfileView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i28.ContractorProfileView();
    },
  );
}

/// generated route for
/// [_i29.ContractorRatingView]
class ContractorRatingView extends _i110.PageRouteInfo<void> {
  const ContractorRatingView({List<_i110.PageRouteInfo>? children})
      : super(
          ContractorRatingView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorRatingView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i29.ContractorRatingView();
    },
  );
}

/// generated route for
/// [_i30.ContractorShiftView]
class ContractorShiftView extends _i110.PageRouteInfo<void> {
  const ContractorShiftView({List<_i110.PageRouteInfo>? children})
      : super(
          ContractorShiftView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorShiftView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i30.ContractorShiftView();
    },
  );
}

/// generated route for
/// [_i31.ContractorStatementView]
class ContractorStatementView extends _i110.PageRouteInfo<void> {
  const ContractorStatementView({List<_i110.PageRouteInfo>? children})
      : super(
          ContractorStatementView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorStatementView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i31.ContractorStatementView();
    },
  );
}

/// generated route for
/// [_i32.ContractorTotalEarningView]
class ContractorTotalEarningView extends _i110.PageRouteInfo<void> {
  const ContractorTotalEarningView({List<_i110.PageRouteInfo>? children})
      : super(
          ContractorTotalEarningView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorTotalEarningView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i32.ContractorTotalEarningView();
    },
  );
}

/// generated route for
/// [_i33.ContractorUpdateProfileView]
class ContractorUpdateProfileView extends _i110.PageRouteInfo<void> {
  const ContractorUpdateProfileView({List<_i110.PageRouteInfo>? children})
      : super(
          ContractorUpdateProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorUpdateProfileView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i33.ContractorUpdateProfileView();
    },
  );
}

/// generated route for
/// [_i34.ContractorWalletView]
class ContractorWalletView extends _i110.PageRouteInfo<void> {
  const ContractorWalletView({List<_i110.PageRouteInfo>? children})
      : super(
          ContractorWalletView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorWalletView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i34.ContractorWalletView();
    },
  );
}

/// generated route for
/// [_i35.ContractorWithdrawPaymentView]
class ContractorWithdrawPaymentView extends _i110.PageRouteInfo<void> {
  const ContractorWithdrawPaymentView({List<_i110.PageRouteInfo>? children})
      : super(
          ContractorWithdrawPaymentView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorWithdrawPaymentView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i35.ContractorWithdrawPaymentView();
    },
  );
}

/// generated route for
/// [_i36.CounterPurposeView]
class CounterPurposeView extends _i110.PageRouteInfo<CounterPurposeViewArgs> {
  CounterPurposeView({
    _i111.Key? key,
    required _i119.EmployerProposalDto data,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          CounterPurposeView.name,
          args: CounterPurposeViewArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'CounterPurposeView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CounterPurposeViewArgs>();
      return _i36.CounterPurposeView(
        key: args.key,
        data: args.data,
      );
    },
  );
}

class CounterPurposeViewArgs {
  const CounterPurposeViewArgs({
    this.key,
    required this.data,
  });

  final _i111.Key? key;

  final _i119.EmployerProposalDto data;

  @override
  String toString() {
    return 'CounterPurposeViewArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [_i37.CustomerSupportView]
class CustomerSupportView extends _i110.PageRouteInfo<void> {
  const CustomerSupportView({List<_i110.PageRouteInfo>? children})
      : super(
          CustomerSupportView.name,
          initialChildren: children,
        );

  static const String name = 'CustomerSupportView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i37.CustomerSupportView();
    },
  );
}

/// generated route for
/// [_i38.DocumentPage]
class DocumentPageScreen extends _i110.PageRouteInfo<DocumentPageScreenArgs> {
  DocumentPageScreen({
    _i111.Key? key,
    bool isFromSplash = false,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          DocumentPageScreen.name,
          args: DocumentPageScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'DocumentPageScreen';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DocumentPageScreenArgs>(
          orElse: () => const DocumentPageScreenArgs());
      return _i38.DocumentPage(
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

  final _i111.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'DocumentPageScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i39.EditProfileView]
class EditProfileView extends _i110.PageRouteInfo<void> {
  const EditProfileView({List<_i110.PageRouteInfo>? children})
      : super(
          EditProfileView.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i39.EditProfileView();
    },
  );
}

/// generated route for
/// [_i40.EducationListScreen]
class EducationListScreen extends _i110.PageRouteInfo<EducationListScreenArgs> {
  EducationListScreen({
    _i111.Key? key,
    bool isFromSplash = false,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          EducationListScreen.name,
          args: EducationListScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'EducationListScreen';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EducationListScreenArgs>(
          orElse: () => const EducationListScreenArgs());
      return _i40.EducationListScreen(
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

  final _i111.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'EducationListScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i41.EducationProfileListView]
class EducationProfileListView
    extends _i110.PageRouteInfo<EducationProfileListViewArgs> {
  EducationProfileListView({
    _i111.Key? key,
    required _i120.ApplicantDto applicantDto,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          EducationProfileListView.name,
          args: EducationProfileListViewArgs(
            key: key,
            applicantDto: applicantDto,
          ),
          initialChildren: children,
        );

  static const String name = 'EducationProfileListView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EducationProfileListViewArgs>();
      return _i41.EducationProfileListView(
        key: args.key,
        applicantDto: args.applicantDto,
      );
    },
  );
}

class EducationProfileListViewArgs {
  const EducationProfileListViewArgs({
    this.key,
    required this.applicantDto,
  });

  final _i111.Key? key;

  final _i120.ApplicantDto applicantDto;

  @override
  String toString() {
    return 'EducationProfileListViewArgs{key: $key, applicantDto: $applicantDto}';
  }
}

/// generated route for
/// [_i42.EmployerAvailabilityView]
class EmployerAvailabilityView
    extends _i110.PageRouteInfo<EmployerAvailabilityViewArgs> {
  EmployerAvailabilityView({
    _i111.Key? key,
    required List<_i119.EmployerProposalShiftDetailDto> list,
    bool confirmDialog = false,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          EmployerAvailabilityView.name,
          args: EmployerAvailabilityViewArgs(
            key: key,
            list: list,
            confirmDialog: confirmDialog,
          ),
          initialChildren: children,
        );

  static const String name = 'EmployerAvailabilityView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployerAvailabilityViewArgs>();
      return _i42.EmployerAvailabilityView(
        key: args.key,
        list: args.list,
        confirmDialog: args.confirmDialog,
      );
    },
  );
}

class EmployerAvailabilityViewArgs {
  const EmployerAvailabilityViewArgs({
    this.key,
    required this.list,
    this.confirmDialog = false,
  });

  final _i111.Key? key;

  final List<_i119.EmployerProposalShiftDetailDto> list;

  final bool confirmDialog;

  @override
  String toString() {
    return 'EmployerAvailabilityViewArgs{key: $key, list: $list, confirmDialog: $confirmDialog}';
  }
}

/// generated route for
/// [_i43.EmployerLocationFormView]
class EmployerLocationFormView
    extends _i110.PageRouteInfo<EmployerLocationFormViewArgs> {
  EmployerLocationFormView({
    _i111.Key? key,
    int? id,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          EmployerLocationFormView.name,
          args: EmployerLocationFormViewArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'EmployerLocationFormView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployerLocationFormViewArgs>(
          orElse: () => const EmployerLocationFormViewArgs());
      return _i43.EmployerLocationFormView(
        key: args.key,
        id: args.id,
      );
    },
  );
}

class EmployerLocationFormViewArgs {
  const EmployerLocationFormViewArgs({
    this.key,
    this.id,
  });

  final _i111.Key? key;

  final int? id;

  @override
  String toString() {
    return 'EmployerLocationFormViewArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i44.EmployerLocationView]
class EmployerLocationView extends _i110.PageRouteInfo<void> {
  const EmployerLocationView({List<_i110.PageRouteInfo>? children})
      : super(
          EmployerLocationView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerLocationView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i44.EmployerLocationView();
    },
  );
}

/// generated route for
/// [_i45.EmployerShiftView]
class EmployerShiftView extends _i110.PageRouteInfo<void> {
  const EmployerShiftView({List<_i110.PageRouteInfo>? children})
      : super(
          EmployerShiftView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerShiftView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i45.EmployerShiftView();
    },
  );
}

/// generated route for
/// [_i46.FaqView]
class FaqView extends _i110.PageRouteInfo<void> {
  const FaqView({List<_i110.PageRouteInfo>? children})
      : super(
          FaqView.name,
          initialChildren: children,
        );

  static const String name = 'FaqView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i46.FaqView();
    },
  );
}

/// generated route for
/// [_i47.FilledHiredContractorList]
class FilledHiredContractorList
    extends _i110.PageRouteInfo<FilledHiredContractorListArgs> {
  FilledHiredContractorList({
    required int postId,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          FilledHiredContractorList.name,
          args: FilledHiredContractorListArgs(postId: postId),
          initialChildren: children,
        );

  static const String name = 'FilledHiredContractorList';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FilledHiredContractorListArgs>();
      return _i47.FilledHiredContractorList(postId: args.postId);
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
/// [_i48.FilledShiftsView]
class FilledShiftsView extends _i110.PageRouteInfo<void> {
  const FilledShiftsView({List<_i110.PageRouteInfo>? children})
      : super(
          FilledShiftsView.name,
          initialChildren: children,
        );

  static const String name = 'FilledShiftsView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i48.FilledShiftsView();
    },
  );
}

/// generated route for
/// [_i49.HealthCarePostForm]
class HealthCarePostForm extends _i110.PageRouteInfo<HealthCarePostFormArgs> {
  HealthCarePostForm({
    _i111.Key? key,
    int? postId,
    bool isFromSplash = false,
    List<_i110.PageRouteInfo>? children,
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

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HealthCarePostFormArgs>(
          orElse: () => const HealthCarePostFormArgs());
      return _i49.HealthCarePostForm(
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

  final _i111.Key? key;

  final int? postId;

  final bool isFromSplash;

  @override
  String toString() {
    return 'HealthCarePostFormArgs{key: $key, postId: $postId, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i50.HealthcarePostShift]
class HealthcarePostShift extends _i110.PageRouteInfo<HealthcarePostShiftArgs> {
  HealthcarePostShift({
    _i111.Key? key,
    required int postId,
    _i114.HealthcarePostDTO? updateShift,
    required _i115.PostShiftDTO post,
    List<_i110.PageRouteInfo>? children,
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

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HealthcarePostShiftArgs>();
      return _i50.HealthcarePostShift(
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

  final _i111.Key? key;

  final int postId;

  final _i114.HealthcarePostDTO? updateShift;

  final _i115.PostShiftDTO post;

  @override
  String toString() {
    return 'HealthcarePostShiftArgs{key: $key, postId: $postId, updateShift: $updateShift, post: $post}';
  }
}

/// generated route for
/// [_i51.HiredContractorView]
class HiredContractorView extends _i110.PageRouteInfo<HiredContractorViewArgs> {
  HiredContractorView({
    _i111.Key? key,
    required int postId,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          HiredContractorView.name,
          args: HiredContractorViewArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'HiredContractorView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HiredContractorViewArgs>();
      return _i51.HiredContractorView(
        key: args.key,
        postId: args.postId,
      );
    },
  );
}

class HiredContractorViewArgs {
  const HiredContractorViewArgs({
    this.key,
    required this.postId,
  });

  final _i111.Key? key;

  final int postId;

  @override
  String toString() {
    return 'HiredContractorViewArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i52.HomeView]
class HomeView extends _i110.PageRouteInfo<void> {
  const HomeView({List<_i110.PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i52.HomeView();
    },
  );
}

/// generated route for
/// [_i53.IntroQuizScreen]
class IntroQuizScreen extends _i110.PageRouteInfo<void> {
  const IntroQuizScreen({List<_i110.PageRouteInfo>? children})
      : super(
          IntroQuizScreen.name,
          initialChildren: children,
        );

  static const String name = 'IntroQuizScreen';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return _i53.IntroQuizScreen();
    },
  );
}

/// generated route for
/// [_i54.IntroVideoScreen]
class IntroVideoScreen extends _i110.PageRouteInfo<void> {
  const IntroVideoScreen({List<_i110.PageRouteInfo>? children})
      : super(
          IntroVideoScreen.name,
          initialChildren: children,
        );

  static const String name = 'IntroVideoScreen';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return _i54.IntroVideoScreen();
    },
  );
}

/// generated route for
/// [_i55.InvoiceDetailView]
class InvoiceDetailView extends _i110.PageRouteInfo<void> {
  const InvoiceDetailView({List<_i110.PageRouteInfo>? children})
      : super(
          InvoiceDetailView.name,
          initialChildren: children,
        );

  static const String name = 'InvoiceDetailView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i55.InvoiceDetailView();
    },
  );
}

/// generated route for
/// [_i56.InvoiceView]
class InvoiceView extends _i110.PageRouteInfo<void> {
  const InvoiceView({List<_i110.PageRouteInfo>? children})
      : super(
          InvoiceView.name,
          initialChildren: children,
        );

  static const String name = 'InvoiceView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i56.InvoiceView();
    },
  );
}

/// generated route for
/// [_i57.LegalScreeningQuestionsPage]
class LegalScreeningQuestionsPage
    extends _i110.PageRouteInfo<LegalScreeningQuestionsPageArgs> {
  LegalScreeningQuestionsPage({
    _i111.Key? key,
    bool isFromSplash = false,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          LegalScreeningQuestionsPage.name,
          args: LegalScreeningQuestionsPageArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'LegalScreeningQuestionsPage';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LegalScreeningQuestionsPageArgs>(
          orElse: () => const LegalScreeningQuestionsPageArgs());
      return _i57.LegalScreeningQuestionsPage(
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

  final _i111.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'LegalScreeningQuestionsPageArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i58.LocationDetailForm]
class LocationDetailForm extends _i110.PageRouteInfo<LocationDetailFormArgs> {
  LocationDetailForm({
    _i111.Key? key,
    bool isFromSplash = false,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          LocationDetailForm.name,
          args: LocationDetailFormArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'LocationDetailForm';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LocationDetailFormArgs>(
          orElse: () => const LocationDetailFormArgs());
      return _i58.LocationDetailForm(
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

  final _i111.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'LocationDetailFormArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i59.LocationExample]
class LocationExample extends _i110.PageRouteInfo<void> {
  const LocationExample({List<_i110.PageRouteInfo>? children})
      : super(
          LocationExample.name,
          initialChildren: children,
        );

  static const String name = 'LocationExample';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return _i59.LocationExample();
    },
  );
}

/// generated route for
/// [_i60.LoginScreen]
class LoginPage extends _i110.PageRouteInfo<void> {
  const LoginPage({List<_i110.PageRouteInfo>? children})
      : super(
          LoginPage.name,
          initialChildren: children,
        );

  static const String name = 'LoginPage';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i60.LoginScreen();
    },
  );
}

/// generated route for
/// [_i61.MainTabView]
class MainTabView extends _i110.PageRouteInfo<void> {
  const MainTabView({List<_i110.PageRouteInfo>? children})
      : super(
          MainTabView.name,
          initialChildren: children,
        );

  static const String name = 'MainTabView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i61.MainTabView();
    },
  );
}

/// generated route for
/// [_i62.MonthlyStatementView]
class MonthlyStatementView extends _i110.PageRouteInfo<void> {
  const MonthlyStatementView({List<_i110.PageRouteInfo>? children})
      : super(
          MonthlyStatementView.name,
          initialChildren: children,
        );

  static const String name = 'MonthlyStatementView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i62.MonthlyStatementView();
    },
  );
}

/// generated route for
/// [_i63.MultiAgreedShift]
class MultiAgreedShift extends _i110.PageRouteInfo<MultiAgreedShiftArgs> {
  MultiAgreedShift({
    required _i119.EmployerProposalDto contractor,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          MultiAgreedShift.name,
          args: MultiAgreedShiftArgs(contractor: contractor),
          initialChildren: children,
        );

  static const String name = 'MultiAgreedShift';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MultiAgreedShiftArgs>();
      return _i63.MultiAgreedShift(contractor: args.contractor);
    },
  );
}

class MultiAgreedShiftArgs {
  const MultiAgreedShiftArgs({required this.contractor});

  final _i119.EmployerProposalDto contractor;

  @override
  String toString() {
    return 'MultiAgreedShiftArgs{contractor: $contractor}';
  }
}

/// generated route for
/// [_i64.MyCalendarView]
class MyCalendarView extends _i110.PageRouteInfo<void> {
  const MyCalendarView({List<_i110.PageRouteInfo>? children})
      : super(
          MyCalendarView.name,
          initialChildren: children,
        );

  static const String name = 'MyCalendarView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i64.MyCalendarView();
    },
  );
}

/// generated route for
/// [_i65.NotificationView]
class NotificationView extends _i110.PageRouteInfo<void> {
  const NotificationView({List<_i110.PageRouteInfo>? children})
      : super(
          NotificationView.name,
          initialChildren: children,
        );

  static const String name = 'NotificationView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i65.NotificationView();
    },
  );
}

/// generated route for
/// [_i66.OnBoarding1]
class Onboarding1 extends _i110.PageRouteInfo<Onboarding1Args> {
  Onboarding1({
    _i111.Key? key,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          Onboarding1.name,
          args: Onboarding1Args(key: key),
          initialChildren: children,
        );

  static const String name = 'Onboarding1';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<Onboarding1Args>(orElse: () => const Onboarding1Args());
      return _i66.OnBoarding1(key: args.key);
    },
  );
}

class Onboarding1Args {
  const Onboarding1Args({this.key});

  final _i111.Key? key;

  @override
  String toString() {
    return 'Onboarding1Args{key: $key}';
  }
}

/// generated route for
/// [_i67.OnBoarding2]
class Onboarding2 extends _i110.PageRouteInfo<Onboarding2Args> {
  Onboarding2({
    _i111.Key? key,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          Onboarding2.name,
          args: Onboarding2Args(key: key),
          initialChildren: children,
        );

  static const String name = 'Onboarding2';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<Onboarding2Args>(orElse: () => const Onboarding2Args());
      return _i67.OnBoarding2(key: args.key);
    },
  );
}

class Onboarding2Args {
  const Onboarding2Args({this.key});

  final _i111.Key? key;

  @override
  String toString() {
    return 'Onboarding2Args{key: $key}';
  }
}

/// generated route for
/// [_i68.OnBoarding3]
class OnBoarding3 extends _i110.PageRouteInfo<OnBoarding3Args> {
  OnBoarding3({
    _i111.Key? key,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          OnBoarding3.name,
          args: OnBoarding3Args(key: key),
          initialChildren: children,
        );

  static const String name = 'OnBoarding3';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<OnBoarding3Args>(orElse: () => const OnBoarding3Args());
      return _i68.OnBoarding3(key: args.key);
    },
  );
}

class OnBoarding3Args {
  const OnBoarding3Args({this.key});

  final _i111.Key? key;

  @override
  String toString() {
    return 'OnBoarding3Args{key: $key}';
  }
}

/// generated route for
/// [_i69.PayableDetail]
class PayableDetail extends _i110.PageRouteInfo<PayableDetailArgs> {
  PayableDetail({
    _i111.Key? key,
    required _i114.HealthcarePostDTO post,
    bool isUpdate = false,
    _i115.PostShiftDTO? updatedPost,
    List<_i110.PageRouteInfo>? children,
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

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PayableDetailArgs>();
      return _i69.PayableDetail(
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

  final _i111.Key? key;

  final _i114.HealthcarePostDTO post;

  final bool isUpdate;

  final _i115.PostShiftDTO? updatedPost;

  @override
  String toString() {
    return 'PayableDetailArgs{key: $key, post: $post, isUpdate: $isUpdate, updatedPost: $updatedPost}';
  }
}

/// generated route for
/// [_i70.PaymentHistoryView]
class PaymentHistoryView extends _i110.PageRouteInfo<void> {
  const PaymentHistoryView({List<_i110.PageRouteInfo>? children})
      : super(
          PaymentHistoryView.name,
          initialChildren: children,
        );

  static const String name = 'PaymentHistoryView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i70.PaymentHistoryView();
    },
  );
}

/// generated route for
/// [_i71.PaymentMethodView]
class PaymentMethodView extends _i110.PageRouteInfo<void> {
  const PaymentMethodView({List<_i110.PageRouteInfo>? children})
      : super(
          PaymentMethodView.name,
          initialChildren: children,
        );

  static const String name = 'PaymentMethodView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i71.PaymentMethodView();
    },
  );
}

/// generated route for
/// [_i72.PersonalProfileView]
class PersonalProfileView extends _i110.PageRouteInfo<PersonalProfileViewArgs> {
  PersonalProfileView({
    _i111.Key? key,
    required _i120.ApplicantDto applicantDto,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          PersonalProfileView.name,
          args: PersonalProfileViewArgs(
            key: key,
            applicantDto: applicantDto,
          ),
          initialChildren: children,
        );

  static const String name = 'PersonalProfileView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PersonalProfileViewArgs>();
      return _i72.PersonalProfileView(
        key: args.key,
        applicantDto: args.applicantDto,
      );
    },
  );
}

class PersonalProfileViewArgs {
  const PersonalProfileViewArgs({
    this.key,
    required this.applicantDto,
  });

  final _i111.Key? key;

  final _i120.ApplicantDto applicantDto;

  @override
  String toString() {
    return 'PersonalProfileViewArgs{key: $key, applicantDto: $applicantDto}';
  }
}

/// generated route for
/// [_i73.PersonalReferenceDetail]
class PersonalReferenceDetail
    extends _i110.PageRouteInfo<PersonalReferenceDetailArgs> {
  PersonalReferenceDetail({
    _i111.Key? key,
    required _i117.ReferenceDTO data,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          PersonalReferenceDetail.name,
          args: PersonalReferenceDetailArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'PersonalReferenceDetail';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PersonalReferenceDetailArgs>();
      return _i73.PersonalReferenceDetail(
        key: args.key,
        data: args.data,
      );
    },
  );
}

class PersonalReferenceDetailArgs {
  const PersonalReferenceDetailArgs({
    this.key,
    required this.data,
  });

  final _i111.Key? key;

  final _i117.ReferenceDTO data;

  @override
  String toString() {
    return 'PersonalReferenceDetailArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [_i74.PostShiftRecurring]
class PostShiftRecurring extends _i110.PageRouteInfo<PostShiftRecurringArgs> {
  PostShiftRecurring({
    _i111.Key? key,
    required int shiftType,
    required _i114.HealthcarePostDTO? updateShift,
    required _i115.PostShiftDTO post,
    List<_i110.PageRouteInfo>? children,
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

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostShiftRecurringArgs>();
      return _i74.PostShiftRecurring(
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

  final _i111.Key? key;

  final int shiftType;

  final _i114.HealthcarePostDTO? updateShift;

  final _i115.PostShiftDTO post;

  @override
  String toString() {
    return 'PostShiftRecurringArgs{key: $key, shiftType: $shiftType, updateShift: $updateShift, post: $post}';
  }
}

/// generated route for
/// [_i75.PreviousShiftAllView]
class PreviousShiftAllView
    extends _i110.PageRouteInfo<PreviousShiftAllViewArgs> {
  PreviousShiftAllView({
    _i111.Key? key,
    bool completedShift = false,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          PreviousShiftAllView.name,
          args: PreviousShiftAllViewArgs(
            key: key,
            completedShift: completedShift,
          ),
          initialChildren: children,
        );

  static const String name = 'PreviousShiftAllView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PreviousShiftAllViewArgs>(
          orElse: () => const PreviousShiftAllViewArgs());
      return _i75.PreviousShiftAllView(
        key: args.key,
        completedShift: args.completedShift,
      );
    },
  );
}

class PreviousShiftAllViewArgs {
  const PreviousShiftAllViewArgs({
    this.key,
    this.completedShift = false,
  });

  final _i111.Key? key;

  final bool completedShift;

  @override
  String toString() {
    return 'PreviousShiftAllViewArgs{key: $key, completedShift: $completedShift}';
  }
}

/// generated route for
/// [_i76.PreviousShiftView]
class PreviousShiftView extends _i110.PageRouteInfo<void> {
  const PreviousShiftView({List<_i110.PageRouteInfo>? children})
      : super(
          PreviousShiftView.name,
          initialChildren: children,
        );

  static const String name = 'PreviousShiftView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i76.PreviousShiftView();
    },
  );
}

/// generated route for
/// [_i77.PrivacyPolicyScreen]
class PrivacyPolicyScreen extends _i110.PageRouteInfo<PrivacyPolicyScreenArgs> {
  PrivacyPolicyScreen({
    _i111.Key? key,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          PrivacyPolicyScreen.name,
          args: PrivacyPolicyScreenArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'PrivacyPolicyScreen';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PrivacyPolicyScreenArgs>(
          orElse: () => const PrivacyPolicyScreenArgs());
      return _i77.PrivacyPolicyScreen(key: args.key);
    },
  );
}

class PrivacyPolicyScreenArgs {
  const PrivacyPolicyScreenArgs({this.key});

  final _i111.Key? key;

  @override
  String toString() {
    return 'PrivacyPolicyScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i78.ProfessionalProfileView]
class ProfessionalProfileView
    extends _i110.PageRouteInfo<ProfessionalProfileViewArgs> {
  ProfessionalProfileView({
    _i111.Key? key,
    required _i120.ApplicantDto applicantDto,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          ProfessionalProfileView.name,
          args: ProfessionalProfileViewArgs(
            key: key,
            applicantDto: applicantDto,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfessionalProfileView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfessionalProfileViewArgs>();
      return _i78.ProfessionalProfileView(
        key: args.key,
        applicantDto: args.applicantDto,
      );
    },
  );
}

class ProfessionalProfileViewArgs {
  const ProfessionalProfileViewArgs({
    this.key,
    required this.applicantDto,
  });

  final _i111.Key? key;

  final _i120.ApplicantDto applicantDto;

  @override
  String toString() {
    return 'ProfessionalProfileViewArgs{key: $key, applicantDto: $applicantDto}';
  }
}

/// generated route for
/// [_i79.ProfessionalReferenceDetail]
class ProfessionalReferenceDetail
    extends _i110.PageRouteInfo<ProfessionalReferenceDetailArgs> {
  ProfessionalReferenceDetail({
    _i111.Key? key,
    required _i117.ReferenceDTO data,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          ProfessionalReferenceDetail.name,
          args: ProfessionalReferenceDetailArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfessionalReferenceDetail';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfessionalReferenceDetailArgs>();
      return _i79.ProfessionalReferenceDetail(
        key: args.key,
        data: args.data,
      );
    },
  );
}

class ProfessionalReferenceDetailArgs {
  const ProfessionalReferenceDetailArgs({
    this.key,
    required this.data,
  });

  final _i111.Key? key;

  final _i117.ReferenceDTO data;

  @override
  String toString() {
    return 'ProfessionalReferenceDetailArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [_i80.ProfileView]
class ProfileView extends _i110.PageRouteInfo<void> {
  const ProfileView({List<_i110.PageRouteInfo>? children})
      : super(
          ProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ProfileView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i80.ProfileView();
    },
  );
}

/// generated route for
/// [_i81.ProposalReceived]
class ProposalReceived extends _i110.PageRouteInfo<ProposalReceivedArgs> {
  ProposalReceived({
    _i111.Key? key,
    required _i121.AppliedShiftDTO post,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          ProposalReceived.name,
          args: ProposalReceivedArgs(
            key: key,
            post: post,
          ),
          initialChildren: children,
        );

  static const String name = 'ProposalReceived';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProposalReceivedArgs>();
      return _i81.ProposalReceived(
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

  final _i111.Key? key;

  final _i121.AppliedShiftDTO post;

  @override
  String toString() {
    return 'ProposalReceivedArgs{key: $key, post: $post}';
  }
}

/// generated route for
/// [_i82.ProposeAvailability]
class ProposeAvailability extends _i110.PageRouteInfo<ProposeAvailabilityArgs> {
  ProposeAvailability({
    required _i114.HealthcarePostDTO post,
    List<_i122.DateTimeDTO>? updatedDates,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          ProposeAvailability.name,
          args: ProposeAvailabilityArgs(
            post: post,
            updatedDates: updatedDates,
          ),
          initialChildren: children,
        );

  static const String name = 'ProposeAvailability';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProposeAvailabilityArgs>();
      return _i82.ProposeAvailability(
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

  final _i114.HealthcarePostDTO post;

  final List<_i122.DateTimeDTO>? updatedDates;

  @override
  String toString() {
    return 'ProposeAvailabilityArgs{post: $post, updatedDates: $updatedDates}';
  }
}

/// generated route for
/// [_i83.QuizResultScreen]
class QuizResultScreen extends _i110.PageRouteInfo<void> {
  const QuizResultScreen({List<_i110.PageRouteInfo>? children})
      : super(
          QuizResultScreen.name,
          initialChildren: children,
        );

  static const String name = 'QuizResultScreen';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return _i83.QuizResultScreen();
    },
  );
}

/// generated route for
/// [_i84.ReferColleagueView]
class ReferColleagueView extends _i110.PageRouteInfo<void> {
  const ReferColleagueView({List<_i110.PageRouteInfo>? children})
      : super(
          ReferColleagueView.name,
          initialChildren: children,
        );

  static const String name = 'ReferColleagueView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i84.ReferColleagueView();
    },
  );
}

/// generated route for
/// [_i85.ReferenceListScreen]
class ReferenceListScreen extends _i110.PageRouteInfo<ReferenceListScreenArgs> {
  ReferenceListScreen({
    _i111.Key? key,
    bool isFromSplash = false,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          ReferenceListScreen.name,
          args: ReferenceListScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'ReferenceListScreen';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReferenceListScreenArgs>(
          orElse: () => const ReferenceListScreenArgs());
      return _i85.ReferenceListScreen(
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

  final _i111.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'ReferenceListScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i86.RegisterProfileScreen]
class RegisterProfilePage extends _i110.PageRouteInfo<RegisterProfilePageArgs> {
  RegisterProfilePage({
    _i111.Key? key,
    required String firstName,
    required String lastName,
    required int checkTermsPrivacy,
    List<_i110.PageRouteInfo>? children,
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

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterProfilePageArgs>();
      return _i86.RegisterProfileScreen(
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

  final _i111.Key? key;

  final String firstName;

  final String lastName;

  final int checkTermsPrivacy;

  @override
  String toString() {
    return 'RegisterProfilePageArgs{key: $key, firstName: $firstName, lastName: $lastName, checkTermsPrivacy: $checkTermsPrivacy}';
  }
}

/// generated route for
/// [_i87.RegisterScreen]
class RegisterPage extends _i110.PageRouteInfo<void> {
  const RegisterPage({List<_i110.PageRouteInfo>? children})
      : super(
          RegisterPage.name,
          initialChildren: children,
        );

  static const String name = 'RegisterPage';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i87.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i88.ReviewPostShiftDetail]
class ReviewPostShiftDetail
    extends _i110.PageRouteInfo<ReviewPostShiftDetailArgs> {
  ReviewPostShiftDetail({
    _i111.Key? key,
    required _i114.HealthcarePostDTO post,
    bool isUpdate = false,
    _i115.PostShiftDTO? updatedPost,
    List<_i110.PageRouteInfo>? children,
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

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReviewPostShiftDetailArgs>();
      return _i88.ReviewPostShiftDetail(
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

  final _i111.Key? key;

  final _i114.HealthcarePostDTO post;

  final bool isUpdate;

  final _i115.PostShiftDTO? updatedPost;

  @override
  String toString() {
    return 'ReviewPostShiftDetailArgs{key: $key, post: $post, isUpdate: $isUpdate, updatedPost: $updatedPost}';
  }
}

/// generated route for
/// [_i89.SendProposal]
class SendProposal extends _i110.PageRouteInfo<SendProposalArgs> {
  SendProposal({
    _i111.Key? key,
    required int postId,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          SendProposal.name,
          args: SendProposalArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'SendProposal';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SendProposalArgs>();
      return _i89.SendProposal(
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

  final _i111.Key? key;

  final int postId;

  @override
  String toString() {
    return 'SendProposalArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i90.ShiftActionsView]
class ShiftActionsView extends _i110.PageRouteInfo<void> {
  const ShiftActionsView({List<_i110.PageRouteInfo>? children})
      : super(
          ShiftActionsView.name,
          initialChildren: children,
        );

  static const String name = 'ShiftActionsView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i90.ShiftActionsView();
    },
  );
}

/// generated route for
/// [_i91.ShowGoogleMap]
class ShowGoogleMap extends _i110.PageRouteInfo<ShowGoogleMapArgs> {
  ShowGoogleMap({
    _i111.Key? key,
    required double latitude,
    required double longitude,
    List<_i110.PageRouteInfo>? children,
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

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ShowGoogleMapArgs>();
      return _i91.ShowGoogleMap(
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

  final _i111.Key? key;

  final double latitude;

  final double longitude;

  @override
  String toString() {
    return 'ShowGoogleMapArgs{key: $key, latitude: $latitude, longitude: $longitude}';
  }
}

/// generated route for
/// [_i92.SingleAgreedShift]
class SingleAgreedShift extends _i110.PageRouteInfo<SingleAgreedShiftArgs> {
  SingleAgreedShift({
    required _i119.EmployerProposalDto contractor,
    int? index,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          SingleAgreedShift.name,
          args: SingleAgreedShiftArgs(
            contractor: contractor,
            index: index,
          ),
          initialChildren: children,
        );

  static const String name = 'SingleAgreedShift';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SingleAgreedShiftArgs>();
      return _i92.SingleAgreedShift(
        contractor: args.contractor,
        index: args.index,
      );
    },
  );
}

class SingleAgreedShiftArgs {
  const SingleAgreedShiftArgs({
    required this.contractor,
    this.index,
  });

  final _i119.EmployerProposalDto contractor;

  final int? index;

  @override
  String toString() {
    return 'SingleAgreedShiftArgs{contractor: $contractor, index: $index}';
  }
}

/// generated route for
/// [_i93.SplashPage]
class SplashPage extends _i110.PageRouteInfo<void> {
  const SplashPage({List<_i110.PageRouteInfo>? children})
      : super(
          SplashPage.name,
          initialChildren: children,
        );

  static const String name = 'SplashPage';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i93.SplashPage();
    },
  );
}

/// generated route for
/// [_i94.SupportTicketView]
class SupportTicketView extends _i110.PageRouteInfo<void> {
  const SupportTicketView({List<_i110.PageRouteInfo>? children})
      : super(
          SupportTicketView.name,
          initialChildren: children,
        );

  static const String name = 'SupportTicketView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i94.SupportTicketView();
    },
  );
}

/// generated route for
/// [_i95.TeamDetailView]
class TeamDetailView extends _i110.PageRouteInfo<TeamDetailViewArgs> {
  TeamDetailView({
    _i111.Key? key,
    required _i116.GetTeamsListDTO getTeamsListDTO,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          TeamDetailView.name,
          args: TeamDetailViewArgs(
            key: key,
            getTeamsListDTO: getTeamsListDTO,
          ),
          initialChildren: children,
        );

  static const String name = 'TeamDetailView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TeamDetailViewArgs>();
      return _i95.TeamDetailView(
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

  final _i111.Key? key;

  final _i116.GetTeamsListDTO getTeamsListDTO;

  @override
  String toString() {
    return 'TeamDetailViewArgs{key: $key, getTeamsListDTO: $getTeamsListDTO}';
  }
}

/// generated route for
/// [_i96.TeamsView]
class TeamsView extends _i110.PageRouteInfo<void> {
  const TeamsView({List<_i110.PageRouteInfo>? children})
      : super(
          TeamsView.name,
          initialChildren: children,
        );

  static const String name = 'TeamsView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i96.TeamsView();
    },
  );
}

/// generated route for
/// [_i97.TermsAndConditionsScreen]
class TermsAndConditionsScreen
    extends _i110.PageRouteInfo<TermsAndConditionsScreenArgs> {
  TermsAndConditionsScreen({
    _i111.Key? key,
    bool isFromSplash = false,
    bool isFromRegister = false,
    List<_i110.PageRouteInfo>? children,
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

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TermsAndConditionsScreenArgs>(
          orElse: () => const TermsAndConditionsScreenArgs());
      return _i97.TermsAndConditionsScreen(
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

  final _i111.Key? key;

  final bool isFromSplash;

  final bool isFromRegister;

  @override
  String toString() {
    return 'TermsAndConditionsScreenArgs{key: $key, isFromSplash: $isFromSplash, isFromRegister: $isFromRegister}';
  }
}

/// generated route for
/// [_i98.TotalPraposalView]
class TotalPraposalView extends _i110.PageRouteInfo<TotalPraposalViewArgs> {
  TotalPraposalView({
    _i111.Key? key,
    required int postId,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          TotalPraposalView.name,
          args: TotalPraposalViewArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'TotalPraposalView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TotalPraposalViewArgs>();
      return _i98.TotalPraposalView(
        key: args.key,
        postId: args.postId,
      );
    },
  );
}

class TotalPraposalViewArgs {
  const TotalPraposalViewArgs({
    this.key,
    required this.postId,
  });

  final _i111.Key? key;

  final int postId;

  @override
  String toString() {
    return 'TotalPraposalViewArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i99.ViewAgreedPraposal]
class ViewAgreedPraposal extends _i110.PageRouteInfo<void> {
  const ViewAgreedPraposal({List<_i110.PageRouteInfo>? children})
      : super(
          ViewAgreedPraposal.name,
          initialChildren: children,
        );

  static const String name = 'ViewAgreedPraposal';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i99.ViewAgreedPraposal();
    },
  );
}

/// generated route for
/// [_i100.ViewApplicantProfile]
class ViewApplicantProfile
    extends _i110.PageRouteInfo<ViewApplicantProfileArgs> {
  ViewApplicantProfile({
    _i111.Key? key,
    required int id,
    required int postId,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          ViewApplicantProfile.name,
          args: ViewApplicantProfileArgs(
            key: key,
            id: id,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewApplicantProfile';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewApplicantProfileArgs>();
      return _i100.ViewApplicantProfile(
        key: args.key,
        id: args.id,
        postId: args.postId,
      );
    },
  );
}

class ViewApplicantProfileArgs {
  const ViewApplicantProfileArgs({
    this.key,
    required this.id,
    required this.postId,
  });

  final _i111.Key? key;

  final int id;

  final int postId;

  @override
  String toString() {
    return 'ViewApplicantProfileArgs{key: $key, id: $id, postId: $postId}';
  }
}

/// generated route for
/// [_i101.ViewContractorShift]
class ViewContractorShift extends _i110.PageRouteInfo<ViewContractorShiftArgs> {
  ViewContractorShift({
    _i111.Key? key,
    required int postId,
    bool isTotalApplicants = false,
    bool fromDashboard = false,
    List<_i110.PageRouteInfo>? children,
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

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewContractorShiftArgs>();
      return _i101.ViewContractorShift(
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

  final _i111.Key? key;

  final int postId;

  final bool isTotalApplicants;

  final bool fromDashboard;

  @override
  String toString() {
    return 'ViewContractorShiftArgs{key: $key, postId: $postId, isTotalApplicants: $isTotalApplicants, fromDashboard: $fromDashboard}';
  }
}

/// generated route for
/// [_i102.ViewContractorShiftDates]
class ViewContractorShiftDates
    extends _i110.PageRouteInfo<ViewContractorShiftDatesArgs> {
  ViewContractorShiftDates({
    _i111.Key? key,
    required _i123.ContactorDashboardDTO shiftDetail,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          ViewContractorShiftDates.name,
          args: ViewContractorShiftDatesArgs(
            key: key,
            shiftDetail: shiftDetail,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewContractorShiftDates';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewContractorShiftDatesArgs>();
      return _i102.ViewContractorShiftDates(
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

  final _i111.Key? key;

  final _i123.ContactorDashboardDTO shiftDetail;

  @override
  String toString() {
    return 'ViewContractorShiftDatesArgs{key: $key, shiftDetail: $shiftDetail}';
  }
}

/// generated route for
/// [_i103.ViewDates]
class ViewDates extends _i110.PageRouteInfo<ViewDatesArgs> {
  ViewDates({
    _i111.Key? key,
    required _i124.ShiftDetailDTO shiftDetail,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          ViewDates.name,
          args: ViewDatesArgs(
            key: key,
            shiftDetail: shiftDetail,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewDates';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewDatesArgs>();
      return _i103.ViewDates(
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

  final _i111.Key? key;

  final _i124.ShiftDetailDTO shiftDetail;

  @override
  String toString() {
    return 'ViewDatesArgs{key: $key, shiftDetail: $shiftDetail}';
  }
}

/// generated route for
/// [_i104.ViewFilledShiftsDates]
class ViewFilledShiftsDates extends _i110.PageRouteInfo<void> {
  const ViewFilledShiftsDates({List<_i110.PageRouteInfo>? children})
      : super(
          ViewFilledShiftsDates.name,
          initialChildren: children,
        );

  static const String name = 'ViewFilledShiftsDates';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i104.ViewFilledShiftsDates();
    },
  );
}

/// generated route for
/// [_i105.ViewFilledShiftsDetails]
class ViewFilledShiftsDetails extends _i110.PageRouteInfo<void> {
  const ViewFilledShiftsDetails({List<_i110.PageRouteInfo>? children})
      : super(
          ViewFilledShiftsDetails.name,
          initialChildren: children,
        );

  static const String name = 'ViewFilledShiftsDetails';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      return const _i105.ViewFilledShiftsDetails();
    },
  );
}

/// generated route for
/// [_i106.ViewHomeShiftDetails]
class ViewHomeShiftDetails
    extends _i110.PageRouteInfo<ViewHomeShiftDetailsArgs> {
  ViewHomeShiftDetails({
    _i111.Key? key,
    required int postId,
    _i125.ShiftDetailRoute? route,
    List<_i110.PageRouteInfo>? children,
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

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewHomeShiftDetailsArgs>();
      return _i106.ViewHomeShiftDetails(
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

  final _i111.Key? key;

  final int postId;

  final _i125.ShiftDetailRoute? route;

  @override
  String toString() {
    return 'ViewHomeShiftDetailsArgs{key: $key, postId: $postId, route: $route}';
  }
}

/// generated route for
/// [_i107.ViewPersonPraposalView]
class ViewPersonPraposalView
    extends _i110.PageRouteInfo<ViewPersonPraposalViewArgs> {
  ViewPersonPraposalView({
    _i111.Key? key,
    required int postId,
    required int userId,
    required _i119.EmployerProposalPendingUserDto user,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          ViewPersonPraposalView.name,
          args: ViewPersonPraposalViewArgs(
            key: key,
            postId: postId,
            userId: userId,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewPersonPraposalView';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewPersonPraposalViewArgs>();
      return _i107.ViewPersonPraposalView(
        key: args.key,
        postId: args.postId,
        userId: args.userId,
        user: args.user,
      );
    },
  );
}

class ViewPersonPraposalViewArgs {
  const ViewPersonPraposalViewArgs({
    this.key,
    required this.postId,
    required this.userId,
    required this.user,
  });

  final _i111.Key? key;

  final int postId;

  final int userId;

  final _i119.EmployerProposalPendingUserDto user;

  @override
  String toString() {
    return 'ViewPersonPraposalViewArgs{key: $key, postId: $postId, userId: $userId, user: $user}';
  }
}

/// generated route for
/// [_i108.ViewSingleApplicants]
class ViewSingleApplicants
    extends _i110.PageRouteInfo<ViewSingleApplicantsArgs> {
  ViewSingleApplicants({
    _i111.Key? key,
    required int postId,
    List<_i110.PageRouteInfo>? children,
  }) : super(
          ViewSingleApplicants.name,
          args: ViewSingleApplicantsArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewSingleApplicants';

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewSingleApplicantsArgs>();
      return _i108.ViewSingleApplicants(
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

  final _i111.Key? key;

  final int postId;

  @override
  String toString() {
    return 'ViewSingleApplicantsArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i109.ViewUpcomingShiftDetails]
class ViewUpcomingShiftDetails
    extends _i110.PageRouteInfo<ViewUpcomingShiftDetailsArgs> {
  ViewUpcomingShiftDetails({
    _i111.Key? key,
    required int postId,
    bool isTotalApplicants = false,
    List<_i110.PageRouteInfo>? children,
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

  static _i110.PageInfo page = _i110.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewUpcomingShiftDetailsArgs>();
      return _i109.ViewUpcomingShiftDetails(
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

  final _i111.Key? key;

  final int postId;

  final bool isTotalApplicants;

  @override
  String toString() {
    return 'ViewUpcomingShiftDetailsArgs{key: $key, postId: $postId, isTotalApplicants: $isTotalApplicants}';
  }
}
