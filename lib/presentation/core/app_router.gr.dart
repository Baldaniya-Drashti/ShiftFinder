// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i125;
import 'package:flutter/material.dart' as _i126;
import 'package:shift/application/auth/contractor_auth/location_example.dart'
    as _i70;
import 'package:shift/infrastructure/contractor_main/shift/applied_shift_dto/applied_shift_dto.dart'
    as _i137;
import 'package:shift/infrastructure/core/applicant_dto/applicant_dto.dart'
    as _i136;
import 'package:shift/infrastructure/core/contractor_home/contractor_dashboard_dto.dart'
    as _i139;
import 'package:shift/infrastructure/core/document_dto/document_dto.dart'
    as _i134;
import 'package:shift/infrastructure/core/education_dto/education_dto.dart'
    as _i127;
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart'
    as _i135;
import 'package:shift/infrastructure/core/reference_dto/reference_dto.dart'
    as _i132;
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart'
    as _i138;
import 'package:shift/infrastructure/main/employer_team/get_teams_dto.dart'
    as _i131;
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart'
    as _i129;
import 'package:shift/infrastructure/main/hired_contractor_list_dto/hired_contractor_list_dto.dart'
    as _i133;
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart'
    as _i128;
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart'
    as _i130;
import 'package:shift/infrastructure/main/shift_detail_dto/shift_detail_dto.dart'
    as _i140;
import 'package:shift/presentation/about/about_view.dart' as _i1;
import 'package:shift/presentation/about/cancellation_policy_view.dart' as _i22;
import 'package:shift/presentation/about/faq_view.dart' as _i54;
import 'package:shift/presentation/account_management/account_management_view.dart'
    as _i2;
import 'package:shift/presentation/account_management/change_password_view.dart'
    as _i24;
import 'package:shift/presentation/auth/contractor_auth/add_bank_details.dart'
    as _i3;
import 'package:shift/presentation/auth/contractor_auth/add_contractor_skills.dart'
    as _i6;
import 'package:shift/presentation/auth/contractor_auth/add_experience_detail.dart'
    as _i8;
import 'package:shift/presentation/auth/contractor_auth/add_speciality_experience.dart'
    as _i14;
import 'package:shift/presentation/auth/contractor_auth/address_proof.dart'
    as _i15;
import 'package:shift/presentation/auth/contractor_auth/background_check_doc.dart'
    as _i19;
import 'package:shift/presentation/auth/contractor_auth/documents/document_page.dart'
    as _i43;
import 'package:shift/presentation/auth/contractor_auth/education_details/add_education_detail.dart'
    as _i7;
import 'package:shift/presentation/auth/contractor_auth/education_details/education_detail_list.dart'
    as _i45;
import 'package:shift/presentation/auth/contractor_auth/intro_quiz.dart'
    as _i64;
import 'package:shift/presentation/auth/contractor_auth/intro_video.dart'
    as _i65;
import 'package:shift/presentation/auth/contractor_auth/legal_screening_questions.dart'
    as _i68;
import 'package:shift/presentation/auth/contractor_auth/proof_of_legal_status.dart'
    as _i93;
import 'package:shift/presentation/auth/contractor_auth/quiz_result.dart'
    as _i96;
import 'package:shift/presentation/auth/contractor_auth/reference_details/add_reference_detail.dart'
    as _i13;
import 'package:shift/presentation/auth/contractor_auth/reference_details/reference_detail_list.dart'
    as _i98;
import 'package:shift/presentation/auth/contractor_auth/terms_conditions.dart'
    as _i111;
import 'package:shift/presentation/auth/employer_auth/add_card_detail.dart'
    as _i4;
import 'package:shift/presentation/auth/employer_auth/location_detail_form.dart'
    as _i69;
import 'package:shift/presentation/auth/login/login_screen.dart' as _i71;
import 'package:shift/presentation/auth/register/register_profile.dart'
    as _i100;
import 'package:shift/presentation/auth/register/register_screen.dart' as _i101;
import 'package:shift/presentation/billing/billing_view.dart' as _i21;
import 'package:shift/presentation/billing/invoice_detail_view.dart' as _i66;
import 'package:shift/presentation/billing/invoice_view.dart' as _i67;
import 'package:shift/presentation/billing/monthly_statement_view.dart' as _i74;
import 'package:shift/presentation/billing/payment_history_view.dart' as _i82;
import 'package:shift/presentation/billing/payment_method_view.dart' as _i83;
import 'package:shift/presentation/chat_section/chat.dart' as _i25;
import 'package:shift/presentation/chat_section/message.dart' as _i73;
import 'package:shift/presentation/contractor/bank_detail/bank_detail_view.dart'
    as _i20;
import 'package:shift/presentation/contractor/contractor_main/contractor_main_tab.dart'
    as _i29;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/contracator_home.dart'
    as _i28;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/send_proposal/propose_availability.dart'
    as _i95;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/send_proposal/send_proposal.dart'
    as _i103;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/view_contractor_shift.dart'
    as _i116;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/view_contractor_shift_dates.dart'
    as _i117;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_profile/contractor_profile.dart'
    as _i32;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/applied_shift/contractor_proposed_date_availability.dart'
    as _i33;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/applied_shift/proposal_received.dart'
    as _i94;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/contractor_shifts.dart'
    as _i35;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/view_upcoming_shit.dart'
    as _i124;
import 'package:shift/presentation/contractor/contractor_performance_insight/contractor_performance_insight_view.dart'
    as _i30;
import 'package:shift/presentation/contractor/contractor_previous_shift/contractor_previous_shift_view.dart'
    as _i31;
import 'package:shift/presentation/contractor/contractor_rating/contractor_rating_view.dart'
    as _i34;
import 'package:shift/presentation/contractor/contractor_update_profile/contractor_update_profile_view.dart'
    as _i38;
import 'package:shift/presentation/contractor/full_position_detail/full_position_detail_view.dart'
    as _i57;
import 'package:shift/presentation/contractor/full_time_position/full_time_position_view.dart'
    as _i59;
import 'package:shift/presentation/contractor/my_calendar_view/my_calendar_view.dart'
    as _i76;
import 'package:shift/presentation/contractor/refer_colleague/refer_colleague_view.dart'
    as _i97;
import 'package:shift/presentation/contractor/refer_colleague/view_collegue_profile.dart'
    as _i115;
import 'package:shift/presentation/contractor/reference_list/reference_list_view.dart'
    as _i99;
import 'package:shift/presentation/contractor_earning/contractor_earning_view.dart'
    as _i27;
import 'package:shift/presentation/contractor_earning/contractor_statement_view.dart'
    as _i36;
import 'package:shift/presentation/contractor_earning/contractor_total_earning_view.dart'
    as _i37;
import 'package:shift/presentation/contractor_earning/contractor_wallet_view.dart'
    as _i39;
import 'package:shift/presentation/contractor_earning/contractor_withdraw_payment_view.dart'
    as _i40;
import 'package:shift/presentation/core/enum.dart' as _i141;
import 'package:shift/presentation/core/widgets/google_map/show_google_map.dart'
    as _i105;
import 'package:shift/presentation/customer_support/customer_support_view.dart'
    as _i42;
import 'package:shift/presentation/customer_support/support_ticket_view.dart'
    as _i108;
import 'package:shift/presentation/employer/add_full_position/add_full_position_view.dart'
    as _i9;
import 'package:shift/presentation/employer/employer_availability/employer_availability_view.dart'
    as _i47;
import 'package:shift/presentation/employer/employer_full_position/employer_full_position_view.dart'
    as _i50;
import 'package:shift/presentation/employer/employer_full_position_confirm/employer_full_position_confirm_view.dart'
    as _i49;
import 'package:shift/presentation/employer/employer_location/employer_location_form_view.dart'
    as _i51;
import 'package:shift/presentation/employer/employer_location/employer_location_view.dart'
    as _i52;
import 'package:shift/presentation/employer/full_position_review/full_position_review_view.dart'
    as _i58;
import 'package:shift/presentation/employer/healthcare_post/add_multi_date_time.dart'
    as _i10;
import 'package:shift/presentation/employer/healthcare_post/healthcare_post.dart'
    as _i60;
import 'package:shift/presentation/employer/healthcare_post/healthcare_post_shit_type.dart'
    as _i61;
import 'package:shift/presentation/employer/healthcare_post/payable_detail.dart'
    as _i81;
import 'package:shift/presentation/employer/healthcare_post/post_shift_recurring.dart'
    as _i86;
import 'package:shift/presentation/employer/healthcare_post/review_post_detail.dart'
    as _i102;
import 'package:shift/presentation/employer/hired_contractor/hired_contractor_view.dart'
    as _i62;
import 'package:shift/presentation/employer/home_view/view_dates.dart' as _i118;
import 'package:shift/presentation/employer/home_view/view_shift_details.dart'
    as _i121;
import 'package:shift/presentation/employer/profile/completed_shift/employer_completed_shift.dart'
    as _i48;
import 'package:shift/presentation/employer/profile/edit_profile/edit_profile_view.dart'
    as _i44;
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart'
    as _i87;
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_view.dart'
    as _i88;
import 'package:shift/presentation/main/main_tab.dart' as _i72;
import 'package:shift/presentation/main/tabs/employer_shift_view.dart' as _i53;
import 'package:shift/presentation/main/tabs/home/home_view.dart' as _i63;
import 'package:shift/presentation/main/tabs/home/praposals/counter_prapose/awaiting_confirmation_view.dart'
    as _i18;
import 'package:shift/presentation/main/tabs/home/praposals/counter_prapose/counter_purpose_view.dart'
    as _i41;
import 'package:shift/presentation/main/tabs/home/praposals/total_praposal_view.dart'
    as _i112;
import 'package:shift/presentation/main/tabs/home/praposals/widgets/view_person_praposal_view.dart'
    as _i122;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/education_profile_view.dart'
    as _i46;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/personal_profile_view.dart'
    as _i84;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/professional_profile_view.dart'
    as _i90;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/view_applicant_profile.dart'
    as _i114;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/common_document_view.dart'
    as _i26;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/personal_reference_detail.dart'
    as _i85;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/professional_reference_detail.dart'
    as _i91;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_single_applicants.dart'
    as _i123;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/add_card_view.dart'
    as _i5;
import 'package:shift/presentation/main/tabs/notification_view.dart' as _i77;
import 'package:shift/presentation/main/tabs/profile/profile_view.dart' as _i92;
import 'package:shift/presentation/main/tabs/profile/teams/add_new_member/add_new_member_view.dart'
    as _i11;
import 'package:shift/presentation/main/tabs/profile/teams/add_new_team/add_new_team_view.dart'
    as _i12;
import 'package:shift/presentation/main/tabs/profile/teams/team_detail/team_detail_view.dart'
    as _i109;
import 'package:shift/presentation/main/tabs/profile/teams/teams_view.dart'
    as _i110;
import 'package:shift/presentation/main/tabs/shifts/agreed_proposal.dart'
    as _i16;
import 'package:shift/presentation/main/tabs/shifts/approved_shifts/widgets/approved_contractor_list.dart'
    as _i17;
import 'package:shift/presentation/main/tabs/shifts/cancelled_shifts/widgets/cancel_contractor_list.dart'
    as _i23;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/filled_shifts_view.dart'
    as _i56;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/filled_hired_contractor_list.dart'
    as _i55;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/view_agreed_praposal.dart'
    as _i113;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/view_filled_shifts_dates.dart'
    as _i119;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/view_filled_shifts_details.dart'
    as _i120;
import 'package:shift/presentation/main/tabs/shifts/multi_agreed_shift.dart'
    as _i75;
import 'package:shift/presentation/main/tabs/shifts/shift_actions_view.dart'
    as _i104;
import 'package:shift/presentation/main/tabs/shifts/single_agreed_shift.dart'
    as _i106;
import 'package:shift/presentation/onboarding/onboarding1.dart' as _i78;
import 'package:shift/presentation/onboarding/onboarding2.dart' as _i79;
import 'package:shift/presentation/onboarding/onboarding3.dart' as _i80;
import 'package:shift/presentation/privacy_policy/privacy_policy.dart' as _i89;
import 'package:shift/presentation/splash/splash_page.dart' as _i107;

/// generated route for
/// [_i1.AboutView]
class AboutView extends _i125.PageRouteInfo<void> {
  const AboutView({List<_i125.PageRouteInfo>? children})
      : super(
          AboutView.name,
          initialChildren: children,
        );

  static const String name = 'AboutView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutView();
    },
  );
}

/// generated route for
/// [_i2.AccountManagementView]
class AccountManagementView extends _i125.PageRouteInfo<void> {
  const AccountManagementView({List<_i125.PageRouteInfo>? children})
      : super(
          AccountManagementView.name,
          initialChildren: children,
        );

  static const String name = 'AccountManagementView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i2.AccountManagementView();
    },
  );
}

/// generated route for
/// [_i3.AddBankDetailsScreen]
class AddBankDetailsScreen
    extends _i125.PageRouteInfo<AddBankDetailsScreenArgs> {
  AddBankDetailsScreen({
    _i126.Key? key,
    bool isFromSplash = false,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          AddBankDetailsScreen.name,
          args: AddBankDetailsScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddBankDetailsScreen';

  static _i125.PageInfo page = _i125.PageInfo(
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

  final _i126.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddBankDetailsScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i4.AddCardDetailPage]
class AddCardDetailPage extends _i125.PageRouteInfo<AddCardDetailPageArgs> {
  AddCardDetailPage({
    _i126.Key? key,
    bool isFromSplash = false,
    bool fromRegister = true,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
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

  final _i126.Key? key;

  final bool isFromSplash;

  final bool fromRegister;

  @override
  String toString() {
    return 'AddCardDetailPageArgs{key: $key, isFromSplash: $isFromSplash, fromRegister: $fromRegister}';
  }
}

/// generated route for
/// [_i5.AddCardView]
class AddCardView extends _i125.PageRouteInfo<void> {
  const AddCardView({List<_i125.PageRouteInfo>? children})
      : super(
          AddCardView.name,
          initialChildren: children,
        );

  static const String name = 'AddCardView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i5.AddCardView();
    },
  );
}

/// generated route for
/// [_i6.AddContractorSkillsForm]
class AddContractorSkillsForm
    extends _i125.PageRouteInfo<AddContractorSkillsFormArgs> {
  AddContractorSkillsForm({
    _i126.Key? key,
    bool isFromSplash = false,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          AddContractorSkillsForm.name,
          args: AddContractorSkillsFormArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddContractorSkillsForm';

  static _i125.PageInfo page = _i125.PageInfo(
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

  final _i126.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddContractorSkillsFormArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i7.AddEducationDetail]
class AddEducationDetailScreen
    extends _i125.PageRouteInfo<AddEducationDetailScreenArgs> {
  AddEducationDetailScreen({
    _i126.Key? key,
    bool isFromSplash = false,
    _i127.EducationDTO? educationObj,
    bool readOnly = false,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
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

  final _i126.Key? key;

  final bool isFromSplash;

  final _i127.EducationDTO? educationObj;

  final bool readOnly;

  @override
  String toString() {
    return 'AddEducationDetailScreenArgs{key: $key, isFromSplash: $isFromSplash, educationObj: $educationObj, readOnly: $readOnly}';
  }
}

/// generated route for
/// [_i8.AddExperienceDetail]
class AddExperienceDetailScreen
    extends _i125.PageRouteInfo<AddExperienceDetailScreenArgs> {
  AddExperienceDetailScreen({
    _i126.Key? key,
    bool isFromSplash = false,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          AddExperienceDetailScreen.name,
          args: AddExperienceDetailScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddExperienceDetailScreen';

  static _i125.PageInfo page = _i125.PageInfo(
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

  final _i126.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddExperienceDetailScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i9.AddFullPositionView]
class AddFullPositionView extends _i125.PageRouteInfo<void> {
  const AddFullPositionView({List<_i125.PageRouteInfo>? children})
      : super(
          AddFullPositionView.name,
          initialChildren: children,
        );

  static const String name = 'AddFullPositionView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i9.AddFullPositionView();
    },
  );
}

/// generated route for
/// [_i10.AddMultiDateTime]
class AddMultiDateTime extends _i125.PageRouteInfo<AddMultiDateTimeArgs> {
  AddMultiDateTime({
    _i126.Key? key,
    required _i128.MultiShiftDTO selectedObj,
    _i129.HealthcarePostDTO? updateShift,
    required _i130.PostShiftDTO post,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddMultiDateTimeArgs>();
      return _i10.AddMultiDateTime(
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

  final _i126.Key? key;

  final _i128.MultiShiftDTO selectedObj;

  final _i129.HealthcarePostDTO? updateShift;

  final _i130.PostShiftDTO post;

  @override
  String toString() {
    return 'AddMultiDateTimeArgs{key: $key, selectedObj: $selectedObj, updateShift: $updateShift, post: $post}';
  }
}

/// generated route for
/// [_i11.AddNewMemberView]
class AddNewMemberView extends _i125.PageRouteInfo<AddNewMemberViewArgs> {
  AddNewMemberView({
    _i126.Key? key,
    bool isUpdateMember = false,
    required _i131.Members? getTeamsListDTO,
    required String teamID,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddNewMemberViewArgs>();
      return _i11.AddNewMemberView(
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

  final _i126.Key? key;

  final bool isUpdateMember;

  final _i131.Members? getTeamsListDTO;

  final String teamID;

  @override
  String toString() {
    return 'AddNewMemberViewArgs{key: $key, isUpdateMember: $isUpdateMember, getTeamsListDTO: $getTeamsListDTO, teamID: $teamID}';
  }
}

/// generated route for
/// [_i12.AddNewTeamView]
class AddNewTeamView extends _i125.PageRouteInfo<AddNewTeamViewArgs> {
  AddNewTeamView({
    _i126.Key? key,
    bool isUpdateMember = false,
    _i131.GetTeamsListDTO? getTeamsListDTO,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddNewTeamViewArgs>(
          orElse: () => const AddNewTeamViewArgs());
      return _i12.AddNewTeamView(
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

  final _i126.Key? key;

  final bool isUpdateMember;

  final _i131.GetTeamsListDTO? getTeamsListDTO;

  @override
  String toString() {
    return 'AddNewTeamViewArgs{key: $key, isUpdateMember: $isUpdateMember, getTeamsListDTO: $getTeamsListDTO}';
  }
}

/// generated route for
/// [_i13.AddReferenceDetail]
class AddReferenceDetailScreen
    extends _i125.PageRouteInfo<AddReferenceDetailScreenArgs> {
  AddReferenceDetailScreen({
    _i126.Key? key,
    bool isFromSplash = false,
    _i132.ReferenceDTO? referenceObj,
    bool readOnly = false,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddReferenceDetailScreenArgs>(
          orElse: () => const AddReferenceDetailScreenArgs());
      return _i13.AddReferenceDetail(
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

  final _i126.Key? key;

  final bool isFromSplash;

  final _i132.ReferenceDTO? referenceObj;

  final bool readOnly;

  @override
  String toString() {
    return 'AddReferenceDetailScreenArgs{key: $key, isFromSplash: $isFromSplash, referenceObj: $referenceObj, readOnly: $readOnly}';
  }
}

/// generated route for
/// [_i14.AddSpecialityExperience]
class AddSpecialityExperience
    extends _i125.PageRouteInfo<AddSpecialityExperienceArgs> {
  AddSpecialityExperience({
    _i126.Key? key,
    bool isFromSplash = false,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          AddSpecialityExperience.name,
          args: AddSpecialityExperienceArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddSpecialityExperience';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddSpecialityExperienceArgs>(
          orElse: () => const AddSpecialityExperienceArgs());
      return _i14.AddSpecialityExperience(
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

  final _i126.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddSpecialityExperienceArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i15.AddressProofScreen]
class AddressProofScreen extends _i125.PageRouteInfo<AddressProofScreenArgs> {
  AddressProofScreen({
    _i126.Key? key,
    bool isFromSplash = false,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          AddressProofScreen.name,
          args: AddressProofScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddressProofScreen';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddressProofScreenArgs>(
          orElse: () => const AddressProofScreenArgs());
      return _i15.AddressProofScreen(
        key: args.key,
        isFromSplash: args.isFromSplash,
      );
    },
  );
}

class AddressProofScreenArgs {
  const AddressProofScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i126.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddressProofScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i16.AgreedProposal]
class AgreedProposal extends _i125.PageRouteInfo<AgreedProposalArgs> {
  AgreedProposal({
    _i126.Key? key,
    required _i133.HiredContractorListDTO post,
    required int userId,
    required int postId,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AgreedProposalArgs>();
      return _i16.AgreedProposal(
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

  final _i126.Key? key;

  final _i133.HiredContractorListDTO post;

  final int userId;

  final int postId;

  @override
  String toString() {
    return 'AgreedProposalArgs{key: $key, post: $post, userId: $userId, postId: $postId}';
  }
}

/// generated route for
/// [_i17.ApprovedHiredList]
class ApprovedHiredList extends _i125.PageRouteInfo<ApprovedHiredListArgs> {
  ApprovedHiredList({
    _i126.Key? key,
    required int postId,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          ApprovedHiredList.name,
          args: ApprovedHiredListArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'ApprovedHiredList';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ApprovedHiredListArgs>();
      return _i17.ApprovedHiredList(
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

  final _i126.Key? key;

  final int postId;

  @override
  String toString() {
    return 'ApprovedHiredListArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i18.AwaitingConfirmationView]
class AwaitingConfirmationView extends _i125.PageRouteInfo<void> {
  const AwaitingConfirmationView({List<_i125.PageRouteInfo>? children})
      : super(
          AwaitingConfirmationView.name,
          initialChildren: children,
        );

  static const String name = 'AwaitingConfirmationView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i18.AwaitingConfirmationView();
    },
  );
}

/// generated route for
/// [_i19.BackgroundDocument]
class BackgroundDocument extends _i125.PageRouteInfo<BackgroundDocumentArgs> {
  BackgroundDocument({
    _i126.Key? key,
    bool isFromSplash = false,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          BackgroundDocument.name,
          args: BackgroundDocumentArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'BackgroundDocument';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BackgroundDocumentArgs>(
          orElse: () => const BackgroundDocumentArgs());
      return _i19.BackgroundDocument(
        key: args.key,
        isFromSplash: args.isFromSplash,
      );
    },
  );
}

class BackgroundDocumentArgs {
  const BackgroundDocumentArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i126.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'BackgroundDocumentArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i20.BankListView]
class BankListView extends _i125.PageRouteInfo<void> {
  const BankListView({List<_i125.PageRouteInfo>? children})
      : super(
          BankListView.name,
          initialChildren: children,
        );

  static const String name = 'BankListView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i20.BankListView();
    },
  );
}

/// generated route for
/// [_i21.BillingView]
class BillingView extends _i125.PageRouteInfo<void> {
  const BillingView({List<_i125.PageRouteInfo>? children})
      : super(
          BillingView.name,
          initialChildren: children,
        );

  static const String name = 'BillingView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i21.BillingView();
    },
  );
}

/// generated route for
/// [_i22.CancellationPolicyView]
class CancellationPolicyView extends _i125.PageRouteInfo<void> {
  const CancellationPolicyView({List<_i125.PageRouteInfo>? children})
      : super(
          CancellationPolicyView.name,
          initialChildren: children,
        );

  static const String name = 'CancellationPolicyView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i22.CancellationPolicyView();
    },
  );
}

/// generated route for
/// [_i23.CancelledContractorList]
class CancelledContractorList
    extends _i125.PageRouteInfo<CancelledContractorListArgs> {
  CancelledContractorList({
    required String title,
    required int postId,
    required int cancelFilter,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CancelledContractorListArgs>();
      return _i23.CancelledContractorList(
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
/// [_i24.ChangePasswordView]
class ChangePasswordView extends _i125.PageRouteInfo<void> {
  const ChangePasswordView({List<_i125.PageRouteInfo>? children})
      : super(
          ChangePasswordView.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i24.ChangePasswordView();
    },
  );
}

/// generated route for
/// [_i25.Chat]
class Chat extends _i125.PageRouteInfo<void> {
  const Chat({List<_i125.PageRouteInfo>? children})
      : super(
          Chat.name,
          initialChildren: children,
        );

  static const String name = 'Chat';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i25.Chat();
    },
  );
}

/// generated route for
/// [_i26.CommonDocumentView]
class CommonDocumentView extends _i125.PageRouteInfo<CommonDocumentViewArgs> {
  CommonDocumentView({
    _i126.Key? key,
    required String title,
    required String frontPage,
    required String backPage,
    required List<_i134.DocumentDTO> documentList,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          CommonDocumentView.name,
          args: CommonDocumentViewArgs(
            key: key,
            title: title,
            frontPage: frontPage,
            backPage: backPage,
            documentList: documentList,
          ),
          initialChildren: children,
        );

  static const String name = 'CommonDocumentView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CommonDocumentViewArgs>();
      return _i26.CommonDocumentView(
        key: args.key,
        title: args.title,
        frontPage: args.frontPage,
        backPage: args.backPage,
        documentList: args.documentList,
      );
    },
  );
}

class CommonDocumentViewArgs {
  const CommonDocumentViewArgs({
    this.key,
    required this.title,
    required this.frontPage,
    required this.backPage,
    required this.documentList,
  });

  final _i126.Key? key;

  final String title;

  final String frontPage;

  final String backPage;

  final List<_i134.DocumentDTO> documentList;

  @override
  String toString() {
    return 'CommonDocumentViewArgs{key: $key, title: $title, frontPage: $frontPage, backPage: $backPage, documentList: $documentList}';
  }
}

/// generated route for
/// [_i27.ContractorEarningView]
class ContractorEarningView extends _i125.PageRouteInfo<void> {
  const ContractorEarningView({List<_i125.PageRouteInfo>? children})
      : super(
          ContractorEarningView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorEarningView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i27.ContractorEarningView();
    },
  );
}

/// generated route for
/// [_i28.ContractorHomeView]
class ContractorHomeView extends _i125.PageRouteInfo<void> {
  const ContractorHomeView({List<_i125.PageRouteInfo>? children})
      : super(
          ContractorHomeView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorHomeView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i28.ContractorHomeView();
    },
  );
}

/// generated route for
/// [_i29.ContractorMainTabView]
class ContractorMainTabView extends _i125.PageRouteInfo<void> {
  const ContractorMainTabView({List<_i125.PageRouteInfo>? children})
      : super(
          ContractorMainTabView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorMainTabView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i29.ContractorMainTabView();
    },
  );
}

/// generated route for
/// [_i30.ContractorPerformanceInsightView]
class ContractorPerformanceInsightView extends _i125.PageRouteInfo<void> {
  const ContractorPerformanceInsightView({List<_i125.PageRouteInfo>? children})
      : super(
          ContractorPerformanceInsightView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorPerformanceInsightView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i30.ContractorPerformanceInsightView();
    },
  );
}

/// generated route for
/// [_i31.ContractorPreviousShiftView]
class ContractorPreviousShiftView extends _i125.PageRouteInfo<void> {
  const ContractorPreviousShiftView({List<_i125.PageRouteInfo>? children})
      : super(
          ContractorPreviousShiftView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorPreviousShiftView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i31.ContractorPreviousShiftView();
    },
  );
}

/// generated route for
/// [_i32.ContractorProfileView]
class ContractorProfileView extends _i125.PageRouteInfo<void> {
  const ContractorProfileView({List<_i125.PageRouteInfo>? children})
      : super(
          ContractorProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorProfileView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i32.ContractorProfileView();
    },
  );
}

/// generated route for
/// [_i33.ContractorProposedAvailability]
class ContractorProposedAvailability
    extends _i125.PageRouteInfo<ContractorProposedAvailabilityArgs> {
  ContractorProposedAvailability({
    _i126.Key? key,
    required List<_i135.EmployerProposalShiftDetailDto> list,
    bool confirmDialog = false,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          ContractorProposedAvailability.name,
          args: ContractorProposedAvailabilityArgs(
            key: key,
            list: list,
            confirmDialog: confirmDialog,
          ),
          initialChildren: children,
        );

  static const String name = 'ContractorProposedAvailability';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ContractorProposedAvailabilityArgs>();
      return _i33.ContractorProposedAvailability(
        key: args.key,
        list: args.list,
        confirmDialog: args.confirmDialog,
      );
    },
  );
}

class ContractorProposedAvailabilityArgs {
  const ContractorProposedAvailabilityArgs({
    this.key,
    required this.list,
    this.confirmDialog = false,
  });

  final _i126.Key? key;

  final List<_i135.EmployerProposalShiftDetailDto> list;

  final bool confirmDialog;

  @override
  String toString() {
    return 'ContractorProposedAvailabilityArgs{key: $key, list: $list, confirmDialog: $confirmDialog}';
  }
}

/// generated route for
/// [_i34.ContractorRatingView]
class ContractorRatingView extends _i125.PageRouteInfo<void> {
  const ContractorRatingView({List<_i125.PageRouteInfo>? children})
      : super(
          ContractorRatingView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorRatingView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i34.ContractorRatingView();
    },
  );
}

/// generated route for
/// [_i35.ContractorShiftView]
class ContractorShiftView extends _i125.PageRouteInfo<void> {
  const ContractorShiftView({List<_i125.PageRouteInfo>? children})
      : super(
          ContractorShiftView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorShiftView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i35.ContractorShiftView();
    },
  );
}

/// generated route for
/// [_i36.ContractorStatementView]
class ContractorStatementView extends _i125.PageRouteInfo<void> {
  const ContractorStatementView({List<_i125.PageRouteInfo>? children})
      : super(
          ContractorStatementView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorStatementView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i36.ContractorStatementView();
    },
  );
}

/// generated route for
/// [_i37.ContractorTotalEarningView]
class ContractorTotalEarningView extends _i125.PageRouteInfo<void> {
  const ContractorTotalEarningView({List<_i125.PageRouteInfo>? children})
      : super(
          ContractorTotalEarningView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorTotalEarningView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i37.ContractorTotalEarningView();
    },
  );
}

/// generated route for
/// [_i38.ContractorUpdateProfileView]
class ContractorUpdateProfileView extends _i125.PageRouteInfo<void> {
  const ContractorUpdateProfileView({List<_i125.PageRouteInfo>? children})
      : super(
          ContractorUpdateProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorUpdateProfileView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i38.ContractorUpdateProfileView();
    },
  );
}

/// generated route for
/// [_i39.ContractorWalletView]
class ContractorWalletView extends _i125.PageRouteInfo<void> {
  const ContractorWalletView({List<_i125.PageRouteInfo>? children})
      : super(
          ContractorWalletView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorWalletView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i39.ContractorWalletView();
    },
  );
}

/// generated route for
/// [_i40.ContractorWithdrawPaymentView]
class ContractorWithdrawPaymentView extends _i125.PageRouteInfo<void> {
  const ContractorWithdrawPaymentView({List<_i125.PageRouteInfo>? children})
      : super(
          ContractorWithdrawPaymentView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorWithdrawPaymentView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i40.ContractorWithdrawPaymentView();
    },
  );
}

/// generated route for
/// [_i41.CounterPurposeView]
class CounterPurposeView extends _i125.PageRouteInfo<CounterPurposeViewArgs> {
  CounterPurposeView({
    _i126.Key? key,
    required _i135.EmployerProposalDto data,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          CounterPurposeView.name,
          args: CounterPurposeViewArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'CounterPurposeView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CounterPurposeViewArgs>();
      return _i41.CounterPurposeView(
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

  final _i126.Key? key;

  final _i135.EmployerProposalDto data;

  @override
  String toString() {
    return 'CounterPurposeViewArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [_i42.CustomerSupportView]
class CustomerSupportView extends _i125.PageRouteInfo<void> {
  const CustomerSupportView({List<_i125.PageRouteInfo>? children})
      : super(
          CustomerSupportView.name,
          initialChildren: children,
        );

  static const String name = 'CustomerSupportView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i42.CustomerSupportView();
    },
  );
}

/// generated route for
/// [_i43.DocumentPage]
class DocumentPageScreen extends _i125.PageRouteInfo<DocumentPageScreenArgs> {
  DocumentPageScreen({
    _i126.Key? key,
    bool isFromSplash = false,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          DocumentPageScreen.name,
          args: DocumentPageScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'DocumentPageScreen';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DocumentPageScreenArgs>(
          orElse: () => const DocumentPageScreenArgs());
      return _i43.DocumentPage(
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

  final _i126.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'DocumentPageScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i44.EditProfileView]
class EditProfileView extends _i125.PageRouteInfo<void> {
  const EditProfileView({List<_i125.PageRouteInfo>? children})
      : super(
          EditProfileView.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i44.EditProfileView();
    },
  );
}

/// generated route for
/// [_i45.EducationListScreen]
class EducationListScreen extends _i125.PageRouteInfo<EducationListScreenArgs> {
  EducationListScreen({
    _i126.Key? key,
    bool isFromSplash = false,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          EducationListScreen.name,
          args: EducationListScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'EducationListScreen';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EducationListScreenArgs>(
          orElse: () => const EducationListScreenArgs());
      return _i45.EducationListScreen(
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

  final _i126.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'EducationListScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i46.EducationProfileListView]
class EducationProfileListView
    extends _i125.PageRouteInfo<EducationProfileListViewArgs> {
  EducationProfileListView({
    _i126.Key? key,
    required _i136.ApplicantDto applicantDto,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          EducationProfileListView.name,
          args: EducationProfileListViewArgs(
            key: key,
            applicantDto: applicantDto,
          ),
          initialChildren: children,
        );

  static const String name = 'EducationProfileListView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EducationProfileListViewArgs>();
      return _i46.EducationProfileListView(
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

  final _i126.Key? key;

  final _i136.ApplicantDto applicantDto;

  @override
  String toString() {
    return 'EducationProfileListViewArgs{key: $key, applicantDto: $applicantDto}';
  }
}

/// generated route for
/// [_i47.EmployerAvailabilityView]
class EmployerAvailabilityView
    extends _i125.PageRouteInfo<EmployerAvailabilityViewArgs> {
  EmployerAvailabilityView({
    _i126.Key? key,
    required List<_i135.EmployerProposalShiftDetailDto> list,
    bool confirmDialog = false,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployerAvailabilityViewArgs>();
      return _i47.EmployerAvailabilityView(
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

  final _i126.Key? key;

  final List<_i135.EmployerProposalShiftDetailDto> list;

  final bool confirmDialog;

  @override
  String toString() {
    return 'EmployerAvailabilityViewArgs{key: $key, list: $list, confirmDialog: $confirmDialog}';
  }
}

/// generated route for
/// [_i48.EmployerCompletedShiftView]
class EmployerCompletedShiftView extends _i125.PageRouteInfo<void> {
  const EmployerCompletedShiftView({List<_i125.PageRouteInfo>? children})
      : super(
          EmployerCompletedShiftView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerCompletedShiftView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i48.EmployerCompletedShiftView();
    },
  );
}

/// generated route for
/// [_i49.EmployerFullPositionConfirmView]
class EmployerFullPositionConfirmView extends _i125.PageRouteInfo<void> {
  const EmployerFullPositionConfirmView({List<_i125.PageRouteInfo>? children})
      : super(
          EmployerFullPositionConfirmView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerFullPositionConfirmView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i49.EmployerFullPositionConfirmView();
    },
  );
}

/// generated route for
/// [_i50.EmployerFullPositionView]
class EmployerFullPositionView extends _i125.PageRouteInfo<void> {
  const EmployerFullPositionView({List<_i125.PageRouteInfo>? children})
      : super(
          EmployerFullPositionView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerFullPositionView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i50.EmployerFullPositionView();
    },
  );
}

/// generated route for
/// [_i51.EmployerLocationFormView]
class EmployerLocationFormView
    extends _i125.PageRouteInfo<EmployerLocationFormViewArgs> {
  EmployerLocationFormView({
    _i126.Key? key,
    int? id,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          EmployerLocationFormView.name,
          args: EmployerLocationFormViewArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'EmployerLocationFormView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployerLocationFormViewArgs>(
          orElse: () => const EmployerLocationFormViewArgs());
      return _i51.EmployerLocationFormView(
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

  final _i126.Key? key;

  final int? id;

  @override
  String toString() {
    return 'EmployerLocationFormViewArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i52.EmployerLocationView]
class EmployerLocationView extends _i125.PageRouteInfo<void> {
  const EmployerLocationView({List<_i125.PageRouteInfo>? children})
      : super(
          EmployerLocationView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerLocationView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i52.EmployerLocationView();
    },
  );
}

/// generated route for
/// [_i53.EmployerShiftView]
class EmployerShiftView extends _i125.PageRouteInfo<void> {
  const EmployerShiftView({List<_i125.PageRouteInfo>? children})
      : super(
          EmployerShiftView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerShiftView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i53.EmployerShiftView();
    },
  );
}

/// generated route for
/// [_i54.FaqView]
class FaqView extends _i125.PageRouteInfo<void> {
  const FaqView({List<_i125.PageRouteInfo>? children})
      : super(
          FaqView.name,
          initialChildren: children,
        );

  static const String name = 'FaqView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i54.FaqView();
    },
  );
}

/// generated route for
/// [_i55.FilledHiredContractorList]
class FilledHiredContractorList
    extends _i125.PageRouteInfo<FilledHiredContractorListArgs> {
  FilledHiredContractorList({
    required int postId,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          FilledHiredContractorList.name,
          args: FilledHiredContractorListArgs(postId: postId),
          initialChildren: children,
        );

  static const String name = 'FilledHiredContractorList';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FilledHiredContractorListArgs>();
      return _i55.FilledHiredContractorList(postId: args.postId);
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
/// [_i56.FilledShiftsView]
class FilledShiftsView extends _i125.PageRouteInfo<void> {
  const FilledShiftsView({List<_i125.PageRouteInfo>? children})
      : super(
          FilledShiftsView.name,
          initialChildren: children,
        );

  static const String name = 'FilledShiftsView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i56.FilledShiftsView();
    },
  );
}

/// generated route for
/// [_i57.FullPositionDetailView]
class FullPositionDetailView extends _i125.PageRouteInfo<void> {
  const FullPositionDetailView({List<_i125.PageRouteInfo>? children})
      : super(
          FullPositionDetailView.name,
          initialChildren: children,
        );

  static const String name = 'FullPositionDetailView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i57.FullPositionDetailView();
    },
  );
}

/// generated route for
/// [_i58.FullPositionReviewView]
class FullPositionReviewView extends _i125.PageRouteInfo<void> {
  const FullPositionReviewView({List<_i125.PageRouteInfo>? children})
      : super(
          FullPositionReviewView.name,
          initialChildren: children,
        );

  static const String name = 'FullPositionReviewView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i58.FullPositionReviewView();
    },
  );
}

/// generated route for
/// [_i59.FullTimePositionView]
class FullTimePositionView extends _i125.PageRouteInfo<void> {
  const FullTimePositionView({List<_i125.PageRouteInfo>? children})
      : super(
          FullTimePositionView.name,
          initialChildren: children,
        );

  static const String name = 'FullTimePositionView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i59.FullTimePositionView();
    },
  );
}

/// generated route for
/// [_i60.HealthCarePostForm]
class HealthCarePostForm extends _i125.PageRouteInfo<HealthCarePostFormArgs> {
  HealthCarePostForm({
    _i126.Key? key,
    int? postId,
    bool isFromSplash = false,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HealthCarePostFormArgs>(
          orElse: () => const HealthCarePostFormArgs());
      return _i60.HealthCarePostForm(
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

  final _i126.Key? key;

  final int? postId;

  final bool isFromSplash;

  @override
  String toString() {
    return 'HealthCarePostFormArgs{key: $key, postId: $postId, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i61.HealthcarePostShift]
class HealthcarePostShift extends _i125.PageRouteInfo<HealthcarePostShiftArgs> {
  HealthcarePostShift({
    _i126.Key? key,
    required int postId,
    _i129.HealthcarePostDTO? updateShift,
    required _i130.PostShiftDTO post,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HealthcarePostShiftArgs>();
      return _i61.HealthcarePostShift(
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

  final _i126.Key? key;

  final int postId;

  final _i129.HealthcarePostDTO? updateShift;

  final _i130.PostShiftDTO post;

  @override
  String toString() {
    return 'HealthcarePostShiftArgs{key: $key, postId: $postId, updateShift: $updateShift, post: $post}';
  }
}

/// generated route for
/// [_i62.HiredContractorView]
class HiredContractorView extends _i125.PageRouteInfo<HiredContractorViewArgs> {
  HiredContractorView({
    _i126.Key? key,
    required int postId,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          HiredContractorView.name,
          args: HiredContractorViewArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'HiredContractorView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HiredContractorViewArgs>();
      return _i62.HiredContractorView(
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

  final _i126.Key? key;

  final int postId;

  @override
  String toString() {
    return 'HiredContractorViewArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i63.HomeView]
class HomeView extends _i125.PageRouteInfo<void> {
  const HomeView({List<_i125.PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i63.HomeView();
    },
  );
}

/// generated route for
/// [_i64.IntroQuizScreen]
class IntroQuizScreen extends _i125.PageRouteInfo<void> {
  const IntroQuizScreen({List<_i125.PageRouteInfo>? children})
      : super(
          IntroQuizScreen.name,
          initialChildren: children,
        );

  static const String name = 'IntroQuizScreen';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return _i64.IntroQuizScreen();
    },
  );
}

/// generated route for
/// [_i65.IntroVideoScreen]
class IntroVideoScreen extends _i125.PageRouteInfo<void> {
  const IntroVideoScreen({List<_i125.PageRouteInfo>? children})
      : super(
          IntroVideoScreen.name,
          initialChildren: children,
        );

  static const String name = 'IntroVideoScreen';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return _i65.IntroVideoScreen();
    },
  );
}

/// generated route for
/// [_i66.InvoiceDetailView]
class InvoiceDetailView extends _i125.PageRouteInfo<InvoiceDetailViewArgs> {
  InvoiceDetailView({
    _i126.Key? key,
    required int id,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          InvoiceDetailView.name,
          args: InvoiceDetailViewArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'InvoiceDetailView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InvoiceDetailViewArgs>();
      return _i66.InvoiceDetailView(
        key: args.key,
        id: args.id,
      );
    },
  );
}

class InvoiceDetailViewArgs {
  const InvoiceDetailViewArgs({
    this.key,
    required this.id,
  });

  final _i126.Key? key;

  final int id;

  @override
  String toString() {
    return 'InvoiceDetailViewArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i67.InvoiceView]
class InvoiceView extends _i125.PageRouteInfo<void> {
  const InvoiceView({List<_i125.PageRouteInfo>? children})
      : super(
          InvoiceView.name,
          initialChildren: children,
        );

  static const String name = 'InvoiceView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i67.InvoiceView();
    },
  );
}

/// generated route for
/// [_i68.LegalScreeningQuestionsPage]
class LegalScreeningQuestionsPage
    extends _i125.PageRouteInfo<LegalScreeningQuestionsPageArgs> {
  LegalScreeningQuestionsPage({
    _i126.Key? key,
    bool isFromSplash = false,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          LegalScreeningQuestionsPage.name,
          args: LegalScreeningQuestionsPageArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'LegalScreeningQuestionsPage';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LegalScreeningQuestionsPageArgs>(
          orElse: () => const LegalScreeningQuestionsPageArgs());
      return _i68.LegalScreeningQuestionsPage(
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

  final _i126.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'LegalScreeningQuestionsPageArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i69.LocationDetailForm]
class LocationDetailForm extends _i125.PageRouteInfo<LocationDetailFormArgs> {
  LocationDetailForm({
    _i126.Key? key,
    bool isFromSplash = false,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          LocationDetailForm.name,
          args: LocationDetailFormArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'LocationDetailForm';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LocationDetailFormArgs>(
          orElse: () => const LocationDetailFormArgs());
      return _i69.LocationDetailForm(
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

  final _i126.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'LocationDetailFormArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i70.LocationExample]
class LocationExample extends _i125.PageRouteInfo<void> {
  const LocationExample({List<_i125.PageRouteInfo>? children})
      : super(
          LocationExample.name,
          initialChildren: children,
        );

  static const String name = 'LocationExample';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return _i70.LocationExample();
    },
  );
}

/// generated route for
/// [_i71.LoginScreen]
class LoginPage extends _i125.PageRouteInfo<void> {
  const LoginPage({List<_i125.PageRouteInfo>? children})
      : super(
          LoginPage.name,
          initialChildren: children,
        );

  static const String name = 'LoginPage';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i71.LoginScreen();
    },
  );
}

/// generated route for
/// [_i72.MainTabView]
class MainTabView extends _i125.PageRouteInfo<void> {
  const MainTabView({List<_i125.PageRouteInfo>? children})
      : super(
          MainTabView.name,
          initialChildren: children,
        );

  static const String name = 'MainTabView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i72.MainTabView();
    },
  );
}

/// generated route for
/// [_i73.Message]
class Message extends _i125.PageRouteInfo<MessageArgs> {
  Message({
    _i126.Key? key,
    required int receiverId,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          Message.name,
          args: MessageArgs(
            key: key,
            receiverId: receiverId,
          ),
          initialChildren: children,
        );

  static const String name = 'Message';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MessageArgs>();
      return _i73.Message(
        key: args.key,
        receiverId: args.receiverId,
      );
    },
  );
}

class MessageArgs {
  const MessageArgs({
    this.key,
    required this.receiverId,
  });

  final _i126.Key? key;

  final int receiverId;

  @override
  String toString() {
    return 'MessageArgs{key: $key, receiverId: $receiverId}';
  }
}

/// generated route for
/// [_i74.MonthlyStatementView]
class MonthlyStatementView extends _i125.PageRouteInfo<void> {
  const MonthlyStatementView({List<_i125.PageRouteInfo>? children})
      : super(
          MonthlyStatementView.name,
          initialChildren: children,
        );

  static const String name = 'MonthlyStatementView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i74.MonthlyStatementView();
    },
  );
}

/// generated route for
/// [_i75.MultiAgreedShift]
class MultiAgreedShift extends _i125.PageRouteInfo<MultiAgreedShiftArgs> {
  MultiAgreedShift({
    required _i135.EmployerProposalDto contractor,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          MultiAgreedShift.name,
          args: MultiAgreedShiftArgs(contractor: contractor),
          initialChildren: children,
        );

  static const String name = 'MultiAgreedShift';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MultiAgreedShiftArgs>();
      return _i75.MultiAgreedShift(contractor: args.contractor);
    },
  );
}

class MultiAgreedShiftArgs {
  const MultiAgreedShiftArgs({required this.contractor});

  final _i135.EmployerProposalDto contractor;

  @override
  String toString() {
    return 'MultiAgreedShiftArgs{contractor: $contractor}';
  }
}

/// generated route for
/// [_i76.MyCalendarView]
class MyCalendarView extends _i125.PageRouteInfo<void> {
  const MyCalendarView({List<_i125.PageRouteInfo>? children})
      : super(
          MyCalendarView.name,
          initialChildren: children,
        );

  static const String name = 'MyCalendarView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i76.MyCalendarView();
    },
  );
}

/// generated route for
/// [_i77.NotificationView]
class NotificationView extends _i125.PageRouteInfo<void> {
  const NotificationView({List<_i125.PageRouteInfo>? children})
      : super(
          NotificationView.name,
          initialChildren: children,
        );

  static const String name = 'NotificationView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i77.NotificationView();
    },
  );
}

/// generated route for
/// [_i78.OnBoarding1]
class Onboarding1 extends _i125.PageRouteInfo<Onboarding1Args> {
  Onboarding1({
    _i126.Key? key,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          Onboarding1.name,
          args: Onboarding1Args(key: key),
          initialChildren: children,
        );

  static const String name = 'Onboarding1';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<Onboarding1Args>(orElse: () => const Onboarding1Args());
      return _i78.OnBoarding1(key: args.key);
    },
  );
}

class Onboarding1Args {
  const Onboarding1Args({this.key});

  final _i126.Key? key;

  @override
  String toString() {
    return 'Onboarding1Args{key: $key}';
  }
}

/// generated route for
/// [_i79.OnBoarding2]
class Onboarding2 extends _i125.PageRouteInfo<Onboarding2Args> {
  Onboarding2({
    _i126.Key? key,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          Onboarding2.name,
          args: Onboarding2Args(key: key),
          initialChildren: children,
        );

  static const String name = 'Onboarding2';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<Onboarding2Args>(orElse: () => const Onboarding2Args());
      return _i79.OnBoarding2(key: args.key);
    },
  );
}

class Onboarding2Args {
  const Onboarding2Args({this.key});

  final _i126.Key? key;

  @override
  String toString() {
    return 'Onboarding2Args{key: $key}';
  }
}

/// generated route for
/// [_i80.OnBoarding3]
class OnBoarding3 extends _i125.PageRouteInfo<OnBoarding3Args> {
  OnBoarding3({
    _i126.Key? key,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          OnBoarding3.name,
          args: OnBoarding3Args(key: key),
          initialChildren: children,
        );

  static const String name = 'OnBoarding3';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<OnBoarding3Args>(orElse: () => const OnBoarding3Args());
      return _i80.OnBoarding3(key: args.key);
    },
  );
}

class OnBoarding3Args {
  const OnBoarding3Args({this.key});

  final _i126.Key? key;

  @override
  String toString() {
    return 'OnBoarding3Args{key: $key}';
  }
}

/// generated route for
/// [_i81.PayableDetail]
class PayableDetail extends _i125.PageRouteInfo<PayableDetailArgs> {
  PayableDetail({
    _i126.Key? key,
    required _i129.HealthcarePostDTO post,
    bool isUpdate = false,
    _i130.PostShiftDTO? updatedPost,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PayableDetailArgs>();
      return _i81.PayableDetail(
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

  final _i126.Key? key;

  final _i129.HealthcarePostDTO post;

  final bool isUpdate;

  final _i130.PostShiftDTO? updatedPost;

  @override
  String toString() {
    return 'PayableDetailArgs{key: $key, post: $post, isUpdate: $isUpdate, updatedPost: $updatedPost}';
  }
}

/// generated route for
/// [_i82.PaymentHistoryView]
class PaymentHistoryView extends _i125.PageRouteInfo<void> {
  const PaymentHistoryView({List<_i125.PageRouteInfo>? children})
      : super(
          PaymentHistoryView.name,
          initialChildren: children,
        );

  static const String name = 'PaymentHistoryView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i82.PaymentHistoryView();
    },
  );
}

/// generated route for
/// [_i83.PaymentMethodView]
class PaymentMethodView extends _i125.PageRouteInfo<void> {
  const PaymentMethodView({List<_i125.PageRouteInfo>? children})
      : super(
          PaymentMethodView.name,
          initialChildren: children,
        );

  static const String name = 'PaymentMethodView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i83.PaymentMethodView();
    },
  );
}

/// generated route for
/// [_i84.PersonalProfileView]
class PersonalProfileView extends _i125.PageRouteInfo<PersonalProfileViewArgs> {
  PersonalProfileView({
    _i126.Key? key,
    required _i136.ApplicantDto applicantDto,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          PersonalProfileView.name,
          args: PersonalProfileViewArgs(
            key: key,
            applicantDto: applicantDto,
          ),
          initialChildren: children,
        );

  static const String name = 'PersonalProfileView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PersonalProfileViewArgs>();
      return _i84.PersonalProfileView(
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

  final _i126.Key? key;

  final _i136.ApplicantDto applicantDto;

  @override
  String toString() {
    return 'PersonalProfileViewArgs{key: $key, applicantDto: $applicantDto}';
  }
}

/// generated route for
/// [_i85.PersonalReferenceDetail]
class PersonalReferenceDetail
    extends _i125.PageRouteInfo<PersonalReferenceDetailArgs> {
  PersonalReferenceDetail({
    _i126.Key? key,
    required _i132.ReferenceDTO data,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          PersonalReferenceDetail.name,
          args: PersonalReferenceDetailArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'PersonalReferenceDetail';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PersonalReferenceDetailArgs>();
      return _i85.PersonalReferenceDetail(
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

  final _i126.Key? key;

  final _i132.ReferenceDTO data;

  @override
  String toString() {
    return 'PersonalReferenceDetailArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [_i86.PostShiftRecurring]
class PostShiftRecurring extends _i125.PageRouteInfo<PostShiftRecurringArgs> {
  PostShiftRecurring({
    _i126.Key? key,
    required int shiftType,
    required _i129.HealthcarePostDTO? updateShift,
    required _i130.PostShiftDTO post,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostShiftRecurringArgs>();
      return _i86.PostShiftRecurring(
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

  final _i126.Key? key;

  final int shiftType;

  final _i129.HealthcarePostDTO? updateShift;

  final _i130.PostShiftDTO post;

  @override
  String toString() {
    return 'PostShiftRecurringArgs{key: $key, shiftType: $shiftType, updateShift: $updateShift, post: $post}';
  }
}

/// generated route for
/// [_i87.PreviousShiftAllView]
class PreviousShiftAllView
    extends _i125.PageRouteInfo<PreviousShiftAllViewArgs> {
  PreviousShiftAllView({
    _i126.Key? key,
    bool completedShift = false,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          PreviousShiftAllView.name,
          args: PreviousShiftAllViewArgs(
            key: key,
            completedShift: completedShift,
          ),
          initialChildren: children,
        );

  static const String name = 'PreviousShiftAllView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PreviousShiftAllViewArgs>(
          orElse: () => const PreviousShiftAllViewArgs());
      return _i87.PreviousShiftAllView(
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

  final _i126.Key? key;

  final bool completedShift;

  @override
  String toString() {
    return 'PreviousShiftAllViewArgs{key: $key, completedShift: $completedShift}';
  }
}

/// generated route for
/// [_i88.PreviousShiftView]
class PreviousShiftView extends _i125.PageRouteInfo<void> {
  const PreviousShiftView({List<_i125.PageRouteInfo>? children})
      : super(
          PreviousShiftView.name,
          initialChildren: children,
        );

  static const String name = 'PreviousShiftView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i88.PreviousShiftView();
    },
  );
}

/// generated route for
/// [_i89.PrivacyPolicyScreen]
class PrivacyPolicyScreen extends _i125.PageRouteInfo<PrivacyPolicyScreenArgs> {
  PrivacyPolicyScreen({
    _i126.Key? key,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          PrivacyPolicyScreen.name,
          args: PrivacyPolicyScreenArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'PrivacyPolicyScreen';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PrivacyPolicyScreenArgs>(
          orElse: () => const PrivacyPolicyScreenArgs());
      return _i89.PrivacyPolicyScreen(key: args.key);
    },
  );
}

class PrivacyPolicyScreenArgs {
  const PrivacyPolicyScreenArgs({this.key});

  final _i126.Key? key;

  @override
  String toString() {
    return 'PrivacyPolicyScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i90.ProfessionalProfileView]
class ProfessionalProfileView
    extends _i125.PageRouteInfo<ProfessionalProfileViewArgs> {
  ProfessionalProfileView({
    _i126.Key? key,
    required _i136.ApplicantDto applicantDto,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          ProfessionalProfileView.name,
          args: ProfessionalProfileViewArgs(
            key: key,
            applicantDto: applicantDto,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfessionalProfileView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfessionalProfileViewArgs>();
      return _i90.ProfessionalProfileView(
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

  final _i126.Key? key;

  final _i136.ApplicantDto applicantDto;

  @override
  String toString() {
    return 'ProfessionalProfileViewArgs{key: $key, applicantDto: $applicantDto}';
  }
}

/// generated route for
/// [_i91.ProfessionalReferenceDetail]
class ProfessionalReferenceDetail
    extends _i125.PageRouteInfo<ProfessionalReferenceDetailArgs> {
  ProfessionalReferenceDetail({
    _i126.Key? key,
    required _i132.ReferenceDTO data,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          ProfessionalReferenceDetail.name,
          args: ProfessionalReferenceDetailArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfessionalReferenceDetail';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfessionalReferenceDetailArgs>();
      return _i91.ProfessionalReferenceDetail(
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

  final _i126.Key? key;

  final _i132.ReferenceDTO data;

  @override
  String toString() {
    return 'ProfessionalReferenceDetailArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [_i92.ProfileView]
class ProfileView extends _i125.PageRouteInfo<void> {
  const ProfileView({List<_i125.PageRouteInfo>? children})
      : super(
          ProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ProfileView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i92.ProfileView();
    },
  );
}

/// generated route for
/// [_i93.ProofOfLegalStatus]
class ProofOfLegalStatus extends _i125.PageRouteInfo<ProofOfLegalStatusArgs> {
  ProofOfLegalStatus({
    _i126.Key? key,
    bool isFromSplash = false,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          ProofOfLegalStatus.name,
          args: ProofOfLegalStatusArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'ProofOfLegalStatus';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProofOfLegalStatusArgs>(
          orElse: () => const ProofOfLegalStatusArgs());
      return _i93.ProofOfLegalStatus(
        key: args.key,
        isFromSplash: args.isFromSplash,
      );
    },
  );
}

class ProofOfLegalStatusArgs {
  const ProofOfLegalStatusArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i126.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'ProofOfLegalStatusArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i94.ProposalReceived]
class ProposalReceived extends _i125.PageRouteInfo<ProposalReceivedArgs> {
  ProposalReceived({
    _i126.Key? key,
    required _i137.AppliedShiftDTO post,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          ProposalReceived.name,
          args: ProposalReceivedArgs(
            key: key,
            post: post,
          ),
          initialChildren: children,
        );

  static const String name = 'ProposalReceived';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProposalReceivedArgs>();
      return _i94.ProposalReceived(
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

  final _i126.Key? key;

  final _i137.AppliedShiftDTO post;

  @override
  String toString() {
    return 'ProposalReceivedArgs{key: $key, post: $post}';
  }
}

/// generated route for
/// [_i95.ProposeAvailability]
class ProposeAvailability extends _i125.PageRouteInfo<ProposeAvailabilityArgs> {
  ProposeAvailability({
    required _i129.HealthcarePostDTO post,
    List<_i138.DateTimeDTO>? updatedDates,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          ProposeAvailability.name,
          args: ProposeAvailabilityArgs(
            post: post,
            updatedDates: updatedDates,
          ),
          initialChildren: children,
        );

  static const String name = 'ProposeAvailability';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProposeAvailabilityArgs>();
      return _i95.ProposeAvailability(
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

  final _i129.HealthcarePostDTO post;

  final List<_i138.DateTimeDTO>? updatedDates;

  @override
  String toString() {
    return 'ProposeAvailabilityArgs{post: $post, updatedDates: $updatedDates}';
  }
}

/// generated route for
/// [_i96.QuizResultScreen]
class QuizResultScreen extends _i125.PageRouteInfo<void> {
  const QuizResultScreen({List<_i125.PageRouteInfo>? children})
      : super(
          QuizResultScreen.name,
          initialChildren: children,
        );

  static const String name = 'QuizResultScreen';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return _i96.QuizResultScreen();
    },
  );
}

/// generated route for
/// [_i97.ReferColleagueView]
class ReferColleagueView extends _i125.PageRouteInfo<void> {
  const ReferColleagueView({List<_i125.PageRouteInfo>? children})
      : super(
          ReferColleagueView.name,
          initialChildren: children,
        );

  static const String name = 'ReferColleagueView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i97.ReferColleagueView();
    },
  );
}

/// generated route for
/// [_i98.ReferenceListScreen]
class ReferenceListScreen extends _i125.PageRouteInfo<ReferenceListScreenArgs> {
  ReferenceListScreen({
    _i126.Key? key,
    bool isFromSplash = false,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          ReferenceListScreen.name,
          args: ReferenceListScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'ReferenceListScreen';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReferenceListScreenArgs>(
          orElse: () => const ReferenceListScreenArgs());
      return _i98.ReferenceListScreen(
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

  final _i126.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'ReferenceListScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i99.ReferenceListView]
class ReferenceListView extends _i125.PageRouteInfo<void> {
  const ReferenceListView({List<_i125.PageRouteInfo>? children})
      : super(
          ReferenceListView.name,
          initialChildren: children,
        );

  static const String name = 'ReferenceListView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i99.ReferenceListView();
    },
  );
}

/// generated route for
/// [_i100.RegisterProfileScreen]
class RegisterProfilePage extends _i125.PageRouteInfo<RegisterProfilePageArgs> {
  RegisterProfilePage({
    _i126.Key? key,
    required String firstName,
    required String lastName,
    required int checkTermsPrivacy,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterProfilePageArgs>();
      return _i100.RegisterProfileScreen(
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

  final _i126.Key? key;

  final String firstName;

  final String lastName;

  final int checkTermsPrivacy;

  @override
  String toString() {
    return 'RegisterProfilePageArgs{key: $key, firstName: $firstName, lastName: $lastName, checkTermsPrivacy: $checkTermsPrivacy}';
  }
}

/// generated route for
/// [_i101.RegisterScreen]
class RegisterPage extends _i125.PageRouteInfo<void> {
  const RegisterPage({List<_i125.PageRouteInfo>? children})
      : super(
          RegisterPage.name,
          initialChildren: children,
        );

  static const String name = 'RegisterPage';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i101.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i102.ReviewPostShiftDetail]
class ReviewPostShiftDetail
    extends _i125.PageRouteInfo<ReviewPostShiftDetailArgs> {
  ReviewPostShiftDetail({
    _i126.Key? key,
    required _i129.HealthcarePostDTO post,
    bool isUpdate = false,
    _i130.PostShiftDTO? updatedPost,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReviewPostShiftDetailArgs>();
      return _i102.ReviewPostShiftDetail(
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

  final _i126.Key? key;

  final _i129.HealthcarePostDTO post;

  final bool isUpdate;

  final _i130.PostShiftDTO? updatedPost;

  @override
  String toString() {
    return 'ReviewPostShiftDetailArgs{key: $key, post: $post, isUpdate: $isUpdate, updatedPost: $updatedPost}';
  }
}

/// generated route for
/// [_i103.SendProposal]
class SendProposal extends _i125.PageRouteInfo<SendProposalArgs> {
  SendProposal({
    _i126.Key? key,
    required int postId,
    required int? id,
    bool isFromCounterPropose = false,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          SendProposal.name,
          args: SendProposalArgs(
            key: key,
            postId: postId,
            id: id,
            isFromCounterPropose: isFromCounterPropose,
          ),
          initialChildren: children,
        );

  static const String name = 'SendProposal';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SendProposalArgs>();
      return _i103.SendProposal(
        key: args.key,
        postId: args.postId,
        id: args.id,
        isFromCounterPropose: args.isFromCounterPropose,
      );
    },
  );
}

class SendProposalArgs {
  const SendProposalArgs({
    this.key,
    required this.postId,
    required this.id,
    this.isFromCounterPropose = false,
  });

  final _i126.Key? key;

  final int postId;

  final int? id;

  final bool isFromCounterPropose;

  @override
  String toString() {
    return 'SendProposalArgs{key: $key, postId: $postId, id: $id, isFromCounterPropose: $isFromCounterPropose}';
  }
}

/// generated route for
/// [_i104.ShiftActionsView]
class ShiftActionsView extends _i125.PageRouteInfo<ShiftActionsViewArgs> {
  ShiftActionsView({
    _i126.Key? key,
    required int postId,
    required int userId,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          ShiftActionsView.name,
          args: ShiftActionsViewArgs(
            key: key,
            postId: postId,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'ShiftActionsView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ShiftActionsViewArgs>();
      return _i104.ShiftActionsView(
        key: args.key,
        postId: args.postId,
        userId: args.userId,
      );
    },
  );
}

class ShiftActionsViewArgs {
  const ShiftActionsViewArgs({
    this.key,
    required this.postId,
    required this.userId,
  });

  final _i126.Key? key;

  final int postId;

  final int userId;

  @override
  String toString() {
    return 'ShiftActionsViewArgs{key: $key, postId: $postId, userId: $userId}';
  }
}

/// generated route for
/// [_i105.ShowGoogleMap]
class ShowGoogleMap extends _i125.PageRouteInfo<ShowGoogleMapArgs> {
  ShowGoogleMap({
    _i126.Key? key,
    required double latitude,
    required double longitude,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ShowGoogleMapArgs>();
      return _i105.ShowGoogleMap(
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

  final _i126.Key? key;

  final double latitude;

  final double longitude;

  @override
  String toString() {
    return 'ShowGoogleMapArgs{key: $key, latitude: $latitude, longitude: $longitude}';
  }
}

/// generated route for
/// [_i106.SingleAgreedShift]
class SingleAgreedShift extends _i125.PageRouteInfo<SingleAgreedShiftArgs> {
  SingleAgreedShift({
    required _i135.EmployerProposalDto contractor,
    int? index,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          SingleAgreedShift.name,
          args: SingleAgreedShiftArgs(
            contractor: contractor,
            index: index,
          ),
          initialChildren: children,
        );

  static const String name = 'SingleAgreedShift';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SingleAgreedShiftArgs>();
      return _i106.SingleAgreedShift(
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

  final _i135.EmployerProposalDto contractor;

  final int? index;

  @override
  String toString() {
    return 'SingleAgreedShiftArgs{contractor: $contractor, index: $index}';
  }
}

/// generated route for
/// [_i107.SplashPage]
class SplashPage extends _i125.PageRouteInfo<void> {
  const SplashPage({List<_i125.PageRouteInfo>? children})
      : super(
          SplashPage.name,
          initialChildren: children,
        );

  static const String name = 'SplashPage';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i107.SplashPage();
    },
  );
}

/// generated route for
/// [_i108.SupportTicketView]
class SupportTicketView extends _i125.PageRouteInfo<void> {
  const SupportTicketView({List<_i125.PageRouteInfo>? children})
      : super(
          SupportTicketView.name,
          initialChildren: children,
        );

  static const String name = 'SupportTicketView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i108.SupportTicketView();
    },
  );
}

/// generated route for
/// [_i109.TeamDetailView]
class TeamDetailView extends _i125.PageRouteInfo<TeamDetailViewArgs> {
  TeamDetailView({
    _i126.Key? key,
    required _i131.GetTeamsListDTO getTeamsListDTO,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          TeamDetailView.name,
          args: TeamDetailViewArgs(
            key: key,
            getTeamsListDTO: getTeamsListDTO,
          ),
          initialChildren: children,
        );

  static const String name = 'TeamDetailView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TeamDetailViewArgs>();
      return _i109.TeamDetailView(
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

  final _i126.Key? key;

  final _i131.GetTeamsListDTO getTeamsListDTO;

  @override
  String toString() {
    return 'TeamDetailViewArgs{key: $key, getTeamsListDTO: $getTeamsListDTO}';
  }
}

/// generated route for
/// [_i110.TeamsView]
class TeamsView extends _i125.PageRouteInfo<void> {
  const TeamsView({List<_i125.PageRouteInfo>? children})
      : super(
          TeamsView.name,
          initialChildren: children,
        );

  static const String name = 'TeamsView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i110.TeamsView();
    },
  );
}

/// generated route for
/// [_i111.TermsAndConditionsScreen]
class TermsAndConditionsScreen
    extends _i125.PageRouteInfo<TermsAndConditionsScreenArgs> {
  TermsAndConditionsScreen({
    _i126.Key? key,
    bool isFromSplash = false,
    bool isFromRegister = false,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TermsAndConditionsScreenArgs>(
          orElse: () => const TermsAndConditionsScreenArgs());
      return _i111.TermsAndConditionsScreen(
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

  final _i126.Key? key;

  final bool isFromSplash;

  final bool isFromRegister;

  @override
  String toString() {
    return 'TermsAndConditionsScreenArgs{key: $key, isFromSplash: $isFromSplash, isFromRegister: $isFromRegister}';
  }
}

/// generated route for
/// [_i112.TotalPraposalView]
class TotalPraposalView extends _i125.PageRouteInfo<TotalPraposalViewArgs> {
  TotalPraposalView({
    _i126.Key? key,
    required int postId,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          TotalPraposalView.name,
          args: TotalPraposalViewArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'TotalPraposalView';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TotalPraposalViewArgs>();
      return _i112.TotalPraposalView(
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

  final _i126.Key? key;

  final int postId;

  @override
  String toString() {
    return 'TotalPraposalViewArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i113.ViewAgreedPraposal]
class ViewAgreedPraposal extends _i125.PageRouteInfo<void> {
  const ViewAgreedPraposal({List<_i125.PageRouteInfo>? children})
      : super(
          ViewAgreedPraposal.name,
          initialChildren: children,
        );

  static const String name = 'ViewAgreedPraposal';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i113.ViewAgreedPraposal();
    },
  );
}

/// generated route for
/// [_i114.ViewApplicantProfile]
class ViewApplicantProfile
    extends _i125.PageRouteInfo<ViewApplicantProfileArgs> {
  ViewApplicantProfile({
    _i126.Key? key,
    required int id,
    required int postId,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewApplicantProfileArgs>();
      return _i114.ViewApplicantProfile(
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

  final _i126.Key? key;

  final int id;

  final int postId;

  @override
  String toString() {
    return 'ViewApplicantProfileArgs{key: $key, id: $id, postId: $postId}';
  }
}

/// generated route for
/// [_i115.ViewCollegueProfile]
class ViewCollegueProfile extends _i125.PageRouteInfo<ViewCollegueProfileArgs> {
  ViewCollegueProfile({
    _i126.Key? key,
    required int id,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          ViewCollegueProfile.name,
          args: ViewCollegueProfileArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewCollegueProfile';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewCollegueProfileArgs>();
      return _i115.ViewCollegueProfile(
        key: args.key,
        id: args.id,
      );
    },
  );
}

class ViewCollegueProfileArgs {
  const ViewCollegueProfileArgs({
    this.key,
    required this.id,
  });

  final _i126.Key? key;

  final int id;

  @override
  String toString() {
    return 'ViewCollegueProfileArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i116.ViewContractorShift]
class ViewContractorShift extends _i125.PageRouteInfo<ViewContractorShiftArgs> {
  ViewContractorShift({
    _i126.Key? key,
    required int postId,
    bool isTotalApplicants = false,
    bool fromDashboard = false,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewContractorShiftArgs>();
      return _i116.ViewContractorShift(
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

  final _i126.Key? key;

  final int postId;

  final bool isTotalApplicants;

  final bool fromDashboard;

  @override
  String toString() {
    return 'ViewContractorShiftArgs{key: $key, postId: $postId, isTotalApplicants: $isTotalApplicants, fromDashboard: $fromDashboard}';
  }
}

/// generated route for
/// [_i117.ViewContractorShiftDates]
class ViewContractorShiftDates
    extends _i125.PageRouteInfo<ViewContractorShiftDatesArgs> {
  ViewContractorShiftDates({
    _i126.Key? key,
    required _i139.ContactorDashboardDTO shiftDetail,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          ViewContractorShiftDates.name,
          args: ViewContractorShiftDatesArgs(
            key: key,
            shiftDetail: shiftDetail,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewContractorShiftDates';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewContractorShiftDatesArgs>();
      return _i117.ViewContractorShiftDates(
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

  final _i126.Key? key;

  final _i139.ContactorDashboardDTO shiftDetail;

  @override
  String toString() {
    return 'ViewContractorShiftDatesArgs{key: $key, shiftDetail: $shiftDetail}';
  }
}

/// generated route for
/// [_i118.ViewDates]
class ViewDates extends _i125.PageRouteInfo<ViewDatesArgs> {
  ViewDates({
    _i126.Key? key,
    required _i140.ShiftDetailDTO shiftDetail,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          ViewDates.name,
          args: ViewDatesArgs(
            key: key,
            shiftDetail: shiftDetail,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewDates';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewDatesArgs>();
      return _i118.ViewDates(
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

  final _i126.Key? key;

  final _i140.ShiftDetailDTO shiftDetail;

  @override
  String toString() {
    return 'ViewDatesArgs{key: $key, shiftDetail: $shiftDetail}';
  }
}

/// generated route for
/// [_i119.ViewFilledShiftsDates]
class ViewFilledShiftsDates extends _i125.PageRouteInfo<void> {
  const ViewFilledShiftsDates({List<_i125.PageRouteInfo>? children})
      : super(
          ViewFilledShiftsDates.name,
          initialChildren: children,
        );

  static const String name = 'ViewFilledShiftsDates';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i119.ViewFilledShiftsDates();
    },
  );
}

/// generated route for
/// [_i120.ViewFilledShiftsDetails]
class ViewFilledShiftsDetails extends _i125.PageRouteInfo<void> {
  const ViewFilledShiftsDetails({List<_i125.PageRouteInfo>? children})
      : super(
          ViewFilledShiftsDetails.name,
          initialChildren: children,
        );

  static const String name = 'ViewFilledShiftsDetails';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      return const _i120.ViewFilledShiftsDetails();
    },
  );
}

/// generated route for
/// [_i121.ViewHomeShiftDetails]
class ViewHomeShiftDetails
    extends _i125.PageRouteInfo<ViewHomeShiftDetailsArgs> {
  ViewHomeShiftDetails({
    _i126.Key? key,
    required int postId,
    _i141.ShiftDetailRoute? route,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewHomeShiftDetailsArgs>();
      return _i121.ViewHomeShiftDetails(
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

  final _i126.Key? key;

  final int postId;

  final _i141.ShiftDetailRoute? route;

  @override
  String toString() {
    return 'ViewHomeShiftDetailsArgs{key: $key, postId: $postId, route: $route}';
  }
}

/// generated route for
/// [_i122.ViewPersonPraposalView]
class ViewPersonPraposalView
    extends _i125.PageRouteInfo<ViewPersonPraposalViewArgs> {
  ViewPersonPraposalView({
    _i126.Key? key,
    required int postId,
    required int userId,
    required _i135.EmployerProposalPendingUserDto user,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewPersonPraposalViewArgs>();
      return _i122.ViewPersonPraposalView(
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

  final _i126.Key? key;

  final int postId;

  final int userId;

  final _i135.EmployerProposalPendingUserDto user;

  @override
  String toString() {
    return 'ViewPersonPraposalViewArgs{key: $key, postId: $postId, userId: $userId, user: $user}';
  }
}

/// generated route for
/// [_i123.ViewSingleApplicants]
class ViewSingleApplicants
    extends _i125.PageRouteInfo<ViewSingleApplicantsArgs> {
  ViewSingleApplicants({
    _i126.Key? key,
    required int postId,
    List<_i125.PageRouteInfo>? children,
  }) : super(
          ViewSingleApplicants.name,
          args: ViewSingleApplicantsArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewSingleApplicants';

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewSingleApplicantsArgs>();
      return _i123.ViewSingleApplicants(
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

  final _i126.Key? key;

  final int postId;

  @override
  String toString() {
    return 'ViewSingleApplicantsArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i124.ViewUpcomingShiftDetails]
class ViewUpcomingShiftDetails
    extends _i125.PageRouteInfo<ViewUpcomingShiftDetailsArgs> {
  ViewUpcomingShiftDetails({
    _i126.Key? key,
    required int postId,
    bool isTotalApplicants = false,
    List<_i125.PageRouteInfo>? children,
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

  static _i125.PageInfo page = _i125.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewUpcomingShiftDetailsArgs>();
      return _i124.ViewUpcomingShiftDetails(
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

  final _i126.Key? key;

  final int postId;

  final bool isTotalApplicants;

  @override
  String toString() {
    return 'ViewUpcomingShiftDetailsArgs{key: $key, postId: $postId, isTotalApplicants: $isTotalApplicants}';
  }
}
