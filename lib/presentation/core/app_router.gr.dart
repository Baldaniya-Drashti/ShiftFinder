// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i136;
import 'package:flutter/material.dart' as _i137;
import 'package:shift/application/auth/contractor_auth/location_example.dart'
    as _i80;
import 'package:shift/infrastructure/auth/contractor/bank/bank_dto.dart'
    as _i138;
import 'package:shift/infrastructure/contractor_main/shift/applied_shift_dto/applied_shift_dto.dart'
    as _i151;
import 'package:shift/infrastructure/core/applicant_dto/applicant_dto.dart'
    as _i148;
import 'package:shift/infrastructure/core/contractor_home/contractor_dashboard_dto.dart'
    as _i153;
import 'package:shift/infrastructure/core/document_dto/document_dto.dart'
    as _i146;
import 'package:shift/infrastructure/core/education_dto/education_dto.dart'
    as _i139;
import 'package:shift/infrastructure/core/employer_long_term_add_detail_dto/employer_long_term_add_detail_dto.dart'
    as _i150;
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart'
    as _i147;
import 'package:shift/infrastructure/core/reference_dto/reference_dto.dart'
    as _i144;
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart'
    as _i149;
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart'
    as _i152;
import 'package:shift/infrastructure/main/employer_team/get_teams_dto.dart'
    as _i143;
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart'
    as _i141;
import 'package:shift/infrastructure/main/hired_contractor_list_dto/hired_contractor_list_dto.dart'
    as _i145;
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart'
    as _i140;
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart'
    as _i142;
import 'package:shift/infrastructure/main/shift_detail_dto/shift_detail_dto.dart'
    as _i154;
import 'package:shift/presentation/about/about_view.dart' as _i1;
import 'package:shift/presentation/about/cancellation_policy_view.dart' as _i21;
import 'package:shift/presentation/about/faq_view.dart' as _i67;
import 'package:shift/presentation/account_management/account_management_view.dart'
    as _i2;
import 'package:shift/presentation/account_management/change_password_view.dart'
    as _i23;
import 'package:shift/presentation/auth/contractor_auth/add_bank_details.dart'
    as _i3;
import 'package:shift/presentation/auth/contractor_auth/add_contractor_skills.dart'
    as _i6;
import 'package:shift/presentation/auth/contractor_auth/add_experience_detail.dart'
    as _i8;
import 'package:shift/presentation/auth/contractor_auth/add_speciality_experience.dart'
    as _i13;
import 'package:shift/presentation/auth/contractor_auth/address_proof.dart'
    as _i14;
import 'package:shift/presentation/auth/contractor_auth/background_check_doc.dart'
    as _i18;
import 'package:shift/presentation/auth/contractor_auth/documents/document_page.dart'
    as _i46;
import 'package:shift/presentation/auth/contractor_auth/education_details/add_education_detail.dart'
    as _i7;
import 'package:shift/presentation/auth/contractor_auth/education_details/education_detail_list.dart'
    as _i48;
import 'package:shift/presentation/auth/contractor_auth/intro_quiz.dart'
    as _i74;
import 'package:shift/presentation/auth/contractor_auth/intro_video.dart'
    as _i75;
import 'package:shift/presentation/auth/contractor_auth/legal_screening_questions.dart'
    as _i78;
import 'package:shift/presentation/auth/contractor_auth/proof_of_legal_status.dart'
    as _i103;
import 'package:shift/presentation/auth/contractor_auth/quiz_result.dart'
    as _i106;
import 'package:shift/presentation/auth/contractor_auth/reference_details/add_reference_detail.dart'
    as _i12;
import 'package:shift/presentation/auth/contractor_auth/reference_details/reference_detail_list.dart'
    as _i108;
import 'package:shift/presentation/auth/contractor_auth/terms_conditions.dart'
    as _i122;
import 'package:shift/presentation/auth/employer_auth/add_card_detail.dart'
    as _i4;
import 'package:shift/presentation/auth/employer_auth/location_detail_form.dart'
    as _i79;
import 'package:shift/presentation/auth/login/login_screen.dart' as _i81;
import 'package:shift/presentation/auth/register/register_profile.dart'
    as _i110;
import 'package:shift/presentation/auth/register/register_screen.dart' as _i111;
import 'package:shift/presentation/billing/billing_view.dart' as _i20;
import 'package:shift/presentation/billing/invoice_detail_view.dart' as _i76;
import 'package:shift/presentation/billing/invoice_view.dart' as _i77;
import 'package:shift/presentation/billing/monthly_statement_view.dart' as _i84;
import 'package:shift/presentation/billing/payment_history_view.dart' as _i92;
import 'package:shift/presentation/billing/payment_method_view.dart' as _i93;
import 'package:shift/presentation/chat_section/chat.dart' as _i24;
import 'package:shift/presentation/chat_section/message.dart' as _i83;
import 'package:shift/presentation/contractor/bank_detail/bank_detail_view.dart'
    as _i19;
import 'package:shift/presentation/contractor/contractor_full_time_position/contractor_full_time_position_detail_view.dart'
    as _i27;
import 'package:shift/presentation/contractor/contractor_full_time_position/contractor_full_time_position_view.dart'
    as _i28;
import 'package:shift/presentation/contractor/contractor_long_term/contractor_long_term_view.dart'
    as _i30;
import 'package:shift/presentation/contractor/contractor_main/contractor_main_tab.dart'
    as _i31;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/contracator_home.dart'
    as _i29;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/send_proposal/propose_availability.dart'
    as _i105;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/send_proposal/send_proposal.dart'
    as _i114;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/view_contractor_shift.dart'
    as _i127;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/view_contractor_shift_dates.dart'
    as _i128;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_profile/contractor_profile.dart'
    as _i35;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/applied_shift/contractor_proposed_date_availability.dart'
    as _i36;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/applied_shift/proposal_received.dart'
    as _i104;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/contractor_shifts.dart'
    as _i38;
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/view_upcoming_shit.dart'
    as _i135;
import 'package:shift/presentation/contractor/contractor_performance_insight/contractor_performance_insight_view.dart'
    as _i33;
import 'package:shift/presentation/contractor/contractor_previous_shift/contractor_previous_shift_view.dart'
    as _i34;
import 'package:shift/presentation/contractor/contractor_rating/contractor_rating_view.dart'
    as _i37;
import 'package:shift/presentation/contractor/contractor_update_profile/contractor_update_profile_view.dart'
    as _i41;
import 'package:shift/presentation/contractor/my_calendar_view/my_calendar_view.dart'
    as _i86;
import 'package:shift/presentation/contractor/refer_colleague/refer_colleague_view.dart'
    as _i107;
import 'package:shift/presentation/contractor/refer_colleague/view_collegue_profile.dart'
    as _i126;
import 'package:shift/presentation/contractor/reference_list/reference_list_view.dart'
    as _i109;
import 'package:shift/presentation/contractor_earning/contractor_earning_view.dart'
    as _i26;
import 'package:shift/presentation/contractor_earning/contractor_statement_view.dart'
    as _i39;
import 'package:shift/presentation/contractor_earning/contractor_total_earning_view.dart'
    as _i40;
import 'package:shift/presentation/contractor_earning/contractor_wallet_view.dart'
    as _i42;
import 'package:shift/presentation/contractor_earning/contractor_withdraw_payment_view.dart'
    as _i43;
import 'package:shift/presentation/core/enum.dart' as _i155;
import 'package:shift/presentation/core/widgets/google_map/show_google_map.dart'
    as _i116;
import 'package:shift/presentation/customer_support/customer_support_view.dart'
    as _i45;
import 'package:shift/presentation/customer_support/support_ticket_view.dart'
    as _i119;
import 'package:shift/presentation/employer/employer_availability/employer_availability_view.dart'
    as _i50;
import 'package:shift/presentation/employer/employer_full_posting/employer_full_position_add_view.dart'
    as _i52;
import 'package:shift/presentation/employer/employer_full_posting/employer_full_posting_confirm_view.dart'
    as _i53;
import 'package:shift/presentation/employer/employer_full_posting/employer_full_posting_review_view.dart'
    as _i54;
import 'package:shift/presentation/employer/employer_full_posting/employer_full_posting_view.dart'
    as _i55;
import 'package:shift/presentation/employer/employer_location/employer_location_form_view.dart'
    as _i56;
import 'package:shift/presentation/employer/employer_location/employer_location_view.dart'
    as _i57;
import 'package:shift/presentation/employer/employer_long_term/employer_long_term_applicant_view.dart'
    as _i58;
import 'package:shift/presentation/employer/employer_long_term/employer_long_term_payable_view.dart'
    as _i59;
import 'package:shift/presentation/employer/employer_long_term/employer_long_term_position_add_detail_view.dart'
    as _i60;
import 'package:shift/presentation/employer/employer_long_term/employer_long_term_position_add_view.dart'
    as _i61;
import 'package:shift/presentation/employer/employer_long_term/employer_long_term_position_detail_view.dart'
    as _i62;
import 'package:shift/presentation/employer/employer_long_term/employer_long_term_post_confirmation_view.dart'
    as _i63;
import 'package:shift/presentation/employer/employer_long_term/employer_long_term_review_detail_view.dart'
    as _i64;
import 'package:shift/presentation/employer/employer_long_term/employer_long_term_view.dart'
    as _i65;
import 'package:shift/presentation/employer/healthcare_post/add_multi_date_time.dart'
    as _i9;
import 'package:shift/presentation/employer/healthcare_post/healthcare_post.dart'
    as _i70;
import 'package:shift/presentation/employer/healthcare_post/healthcare_post_shit_type.dart'
    as _i71;
import 'package:shift/presentation/employer/healthcare_post/payable_detail.dart'
    as _i91;
import 'package:shift/presentation/employer/healthcare_post/post_shift_recurring.dart'
    as _i96;
import 'package:shift/presentation/employer/healthcare_post/review_post_detail.dart'
    as _i112;
import 'package:shift/presentation/employer/hired_contractor/hired_contractor_view.dart'
    as _i72;
import 'package:shift/presentation/employer/home_view/view_dates.dart' as _i129;
import 'package:shift/presentation/employer/home_view/view_shift_details.dart'
    as _i132;
import 'package:shift/presentation/employer/profile/completed_shift/employer_completed_shift.dart'
    as _i51;
import 'package:shift/presentation/employer/profile/edit_profile/edit_profile_view.dart'
    as _i47;
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart'
    as _i97;
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_view.dart'
    as _i98;
import 'package:shift/presentation/employer/save_template/save_template_view.dart'
    as _i113;
import 'package:shift/presentation/main/main_tab.dart' as _i82;
import 'package:shift/presentation/main/tabs/employer_shift_view.dart' as _i66;
import 'package:shift/presentation/main/tabs/home/home_view.dart' as _i73;
import 'package:shift/presentation/main/tabs/home/praposals/counter_prapose/awaiting_confirmation_view.dart'
    as _i17;
import 'package:shift/presentation/main/tabs/home/praposals/counter_prapose/counter_purpose_view.dart'
    as _i44;
import 'package:shift/presentation/main/tabs/home/praposals/total_praposal_view.dart'
    as _i123;
import 'package:shift/presentation/main/tabs/home/praposals/widgets/view_person_praposal_view.dart'
    as _i133;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/education_profile_view.dart'
    as _i49;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/personal_profile_view.dart'
    as _i94;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/professional_profile_view.dart'
    as _i100;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/view_applicant_profile.dart'
    as _i125;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/common_document_view.dart'
    as _i25;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/pdf_viewer.dart'
    as _i32;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/personal_reference_detail.dart'
    as _i95;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/professional_reference_detail.dart'
    as _i101;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_single_applicants.dart'
    as _i134;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/add_card_view.dart'
    as _i5;
import 'package:shift/presentation/main/tabs/notification_view.dart' as _i87;
import 'package:shift/presentation/main/tabs/profile/profile_view.dart'
    as _i102;
import 'package:shift/presentation/main/tabs/profile/teams/add_new_member/add_new_member_view.dart'
    as _i10;
import 'package:shift/presentation/main/tabs/profile/teams/add_new_team/add_new_team_view.dart'
    as _i11;
import 'package:shift/presentation/main/tabs/profile/teams/team_detail/team_detail_view.dart'
    as _i120;
import 'package:shift/presentation/main/tabs/profile/teams/teams_view.dart'
    as _i121;
import 'package:shift/presentation/main/tabs/shifts/agreed_proposal.dart'
    as _i15;
import 'package:shift/presentation/main/tabs/shifts/approved_shifts/widgets/approved_contractor_list.dart'
    as _i16;
import 'package:shift/presentation/main/tabs/shifts/cancelled_shifts/widgets/cancel_contractor_list.dart'
    as _i22;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/filled_shifts_view.dart'
    as _i69;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/filled_hired_contractor_list.dart'
    as _i68;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/view_agreed_praposal.dart'
    as _i124;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/view_filled_shifts_dates.dart'
    as _i130;
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/view_filled_shifts_details.dart'
    as _i131;
import 'package:shift/presentation/main/tabs/shifts/multi_agreed_shift.dart'
    as _i85;
import 'package:shift/presentation/main/tabs/shifts/shift_actions_view.dart'
    as _i115;
import 'package:shift/presentation/main/tabs/shifts/single_agreed_shift.dart'
    as _i117;
import 'package:shift/presentation/onboarding/onboarding1.dart' as _i88;
import 'package:shift/presentation/onboarding/onboarding2.dart' as _i89;
import 'package:shift/presentation/onboarding/onboarding3.dart' as _i90;
import 'package:shift/presentation/privacy_policy/privacy_policy.dart' as _i99;
import 'package:shift/presentation/splash/splash_page.dart' as _i118;

/// generated route for
/// [_i1.AboutView]
class AboutView extends _i136.PageRouteInfo<void> {
  const AboutView({List<_i136.PageRouteInfo>? children})
      : super(
          AboutView.name,
          initialChildren: children,
        );

  static const String name = 'AboutView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutView();
    },
  );
}

/// generated route for
/// [_i2.AccountManagementView]
class AccountManagementView extends _i136.PageRouteInfo<void> {
  const AccountManagementView({List<_i136.PageRouteInfo>? children})
      : super(
          AccountManagementView.name,
          initialChildren: children,
        );

  static const String name = 'AccountManagementView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i2.AccountManagementView();
    },
  );
}

/// generated route for
/// [_i3.AddBankDetailsScreen]
class AddBankDetailsScreen
    extends _i136.PageRouteInfo<AddBankDetailsScreenArgs> {
  AddBankDetailsScreen({
    _i137.Key? key,
    bool isFromSplash = false,
    _i138.BankDTO? bankDetail,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          AddBankDetailsScreen.name,
          args: AddBankDetailsScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
            bankDetail: bankDetail,
          ),
          initialChildren: children,
        );

  static const String name = 'AddBankDetailsScreen';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddBankDetailsScreenArgs>(
          orElse: () => const AddBankDetailsScreenArgs());
      return _i3.AddBankDetailsScreen(
        key: args.key,
        isFromSplash: args.isFromSplash,
        bankDetail: args.bankDetail,
      );
    },
  );
}

class AddBankDetailsScreenArgs {
  const AddBankDetailsScreenArgs({
    this.key,
    this.isFromSplash = false,
    this.bankDetail,
  });

  final _i137.Key? key;

  final bool isFromSplash;

  final _i138.BankDTO? bankDetail;

  @override
  String toString() {
    return 'AddBankDetailsScreenArgs{key: $key, isFromSplash: $isFromSplash, bankDetail: $bankDetail}';
  }
}

/// generated route for
/// [_i4.AddCardDetailPage]
class AddCardDetailPage extends _i136.PageRouteInfo<AddCardDetailPageArgs> {
  AddCardDetailPage({
    _i137.Key? key,
    bool isFromSplash = false,
    bool fromRegister = true,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
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

  final _i137.Key? key;

  final bool isFromSplash;

  final bool fromRegister;

  @override
  String toString() {
    return 'AddCardDetailPageArgs{key: $key, isFromSplash: $isFromSplash, fromRegister: $fromRegister}';
  }
}

/// generated route for
/// [_i5.AddCardView]
class AddCardView extends _i136.PageRouteInfo<void> {
  const AddCardView({List<_i136.PageRouteInfo>? children})
      : super(
          AddCardView.name,
          initialChildren: children,
        );

  static const String name = 'AddCardView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i5.AddCardView();
    },
  );
}

/// generated route for
/// [_i6.AddContractorSkillsForm]
class AddContractorSkillsForm
    extends _i136.PageRouteInfo<AddContractorSkillsFormArgs> {
  AddContractorSkillsForm({
    _i137.Key? key,
    bool isFromSplash = false,
    bool isUpdate = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          AddContractorSkillsForm.name,
          args: AddContractorSkillsFormArgs(
            key: key,
            isFromSplash: isFromSplash,
            isUpdate: isUpdate,
          ),
          initialChildren: children,
        );

  static const String name = 'AddContractorSkillsForm';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddContractorSkillsFormArgs>(
          orElse: () => const AddContractorSkillsFormArgs());
      return _i6.AddContractorSkillsForm(
        key: args.key,
        isFromSplash: args.isFromSplash,
        isUpdate: args.isUpdate,
      );
    },
  );
}

class AddContractorSkillsFormArgs {
  const AddContractorSkillsFormArgs({
    this.key,
    this.isFromSplash = false,
    this.isUpdate = false,
  });

  final _i137.Key? key;

  final bool isFromSplash;

  final bool isUpdate;

  @override
  String toString() {
    return 'AddContractorSkillsFormArgs{key: $key, isFromSplash: $isFromSplash, isUpdate: $isUpdate}';
  }
}

/// generated route for
/// [_i7.AddEducationDetail]
class AddEducationDetailScreen
    extends _i136.PageRouteInfo<AddEducationDetailScreenArgs> {
  AddEducationDetailScreen({
    _i137.Key? key,
    bool isFromSplash = false,
    _i139.EducationDTO? educationObj,
    bool readOnly = false,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
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

  final _i137.Key? key;

  final bool isFromSplash;

  final _i139.EducationDTO? educationObj;

  final bool readOnly;

  @override
  String toString() {
    return 'AddEducationDetailScreenArgs{key: $key, isFromSplash: $isFromSplash, educationObj: $educationObj, readOnly: $readOnly}';
  }
}

/// generated route for
/// [_i8.AddExperienceDetail]
class AddExperienceDetailScreen
    extends _i136.PageRouteInfo<AddExperienceDetailScreenArgs> {
  AddExperienceDetailScreen({
    _i137.Key? key,
    bool isFromSplash = false,
    bool isUpdate = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          AddExperienceDetailScreen.name,
          args: AddExperienceDetailScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
            isUpdate: isUpdate,
          ),
          initialChildren: children,
        );

  static const String name = 'AddExperienceDetailScreen';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddExperienceDetailScreenArgs>(
          orElse: () => const AddExperienceDetailScreenArgs());
      return _i8.AddExperienceDetail(
        key: args.key,
        isFromSplash: args.isFromSplash,
        isUpdate: args.isUpdate,
      );
    },
  );
}

class AddExperienceDetailScreenArgs {
  const AddExperienceDetailScreenArgs({
    this.key,
    this.isFromSplash = false,
    this.isUpdate = false,
  });

  final _i137.Key? key;

  final bool isFromSplash;

  final bool isUpdate;

  @override
  String toString() {
    return 'AddExperienceDetailScreenArgs{key: $key, isFromSplash: $isFromSplash, isUpdate: $isUpdate}';
  }
}

/// generated route for
/// [_i9.AddMultiDateTime]
class AddMultiDateTime extends _i136.PageRouteInfo<AddMultiDateTimeArgs> {
  AddMultiDateTime({
    _i137.Key? key,
    bool fromSaveTemplate = false,
    required _i140.MultiShiftDTO selectedObj,
    _i141.HealthcarePostDTO? updateShift,
    required _i142.PostShiftDTO post,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          AddMultiDateTime.name,
          args: AddMultiDateTimeArgs(
            key: key,
            fromSaveTemplate: fromSaveTemplate,
            selectedObj: selectedObj,
            updateShift: updateShift,
            post: post,
          ),
          initialChildren: children,
        );

  static const String name = 'AddMultiDateTime';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddMultiDateTimeArgs>();
      return _i9.AddMultiDateTime(
        key: args.key,
        fromSaveTemplate: args.fromSaveTemplate,
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
    this.fromSaveTemplate = false,
    required this.selectedObj,
    this.updateShift,
    required this.post,
  });

  final _i137.Key? key;

  final bool fromSaveTemplate;

  final _i140.MultiShiftDTO selectedObj;

  final _i141.HealthcarePostDTO? updateShift;

  final _i142.PostShiftDTO post;

  @override
  String toString() {
    return 'AddMultiDateTimeArgs{key: $key, fromSaveTemplate: $fromSaveTemplate, selectedObj: $selectedObj, updateShift: $updateShift, post: $post}';
  }
}

/// generated route for
/// [_i10.AddNewMemberView]
class AddNewMemberView extends _i136.PageRouteInfo<AddNewMemberViewArgs> {
  AddNewMemberView({
    _i137.Key? key,
    bool isUpdateMember = false,
    required _i143.Members? getTeamsListDTO,
    required String teamID,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
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

  final _i137.Key? key;

  final bool isUpdateMember;

  final _i143.Members? getTeamsListDTO;

  final String teamID;

  @override
  String toString() {
    return 'AddNewMemberViewArgs{key: $key, isUpdateMember: $isUpdateMember, getTeamsListDTO: $getTeamsListDTO, teamID: $teamID}';
  }
}

/// generated route for
/// [_i11.AddNewTeamView]
class AddNewTeamView extends _i136.PageRouteInfo<AddNewTeamViewArgs> {
  AddNewTeamView({
    _i137.Key? key,
    bool isUpdateMember = false,
    _i143.GetTeamsListDTO? getTeamsListDTO,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
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

  final _i137.Key? key;

  final bool isUpdateMember;

  final _i143.GetTeamsListDTO? getTeamsListDTO;

  @override
  String toString() {
    return 'AddNewTeamViewArgs{key: $key, isUpdateMember: $isUpdateMember, getTeamsListDTO: $getTeamsListDTO}';
  }
}

/// generated route for
/// [_i12.AddReferenceDetail]
class AddReferenceDetailScreen
    extends _i136.PageRouteInfo<AddReferenceDetailScreenArgs> {
  AddReferenceDetailScreen({
    _i137.Key? key,
    bool isFromSplash = false,
    _i144.ReferenceDTO? referenceObj,
    bool readOnly = false,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
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

  final _i137.Key? key;

  final bool isFromSplash;

  final _i144.ReferenceDTO? referenceObj;

  final bool readOnly;

  @override
  String toString() {
    return 'AddReferenceDetailScreenArgs{key: $key, isFromSplash: $isFromSplash, referenceObj: $referenceObj, readOnly: $readOnly}';
  }
}

/// generated route for
/// [_i13.AddSpecialityExperience]
class AddSpecialityExperience
    extends _i136.PageRouteInfo<AddSpecialityExperienceArgs> {
  AddSpecialityExperience({
    _i137.Key? key,
    bool isFromSplash = false,
    bool isUpdate = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          AddSpecialityExperience.name,
          args: AddSpecialityExperienceArgs(
            key: key,
            isFromSplash: isFromSplash,
            isUpdate: isUpdate,
          ),
          initialChildren: children,
        );

  static const String name = 'AddSpecialityExperience';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddSpecialityExperienceArgs>(
          orElse: () => const AddSpecialityExperienceArgs());
      return _i13.AddSpecialityExperience(
        key: args.key,
        isFromSplash: args.isFromSplash,
        isUpdate: args.isUpdate,
      );
    },
  );
}

class AddSpecialityExperienceArgs {
  const AddSpecialityExperienceArgs({
    this.key,
    this.isFromSplash = false,
    this.isUpdate = false,
  });

  final _i137.Key? key;

  final bool isFromSplash;

  final bool isUpdate;

  @override
  String toString() {
    return 'AddSpecialityExperienceArgs{key: $key, isFromSplash: $isFromSplash, isUpdate: $isUpdate}';
  }
}

/// generated route for
/// [_i14.AddressProofScreen]
class AddressProofScreen extends _i136.PageRouteInfo<AddressProofScreenArgs> {
  AddressProofScreen({
    _i137.Key? key,
    bool isFromSplash = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          AddressProofScreen.name,
          args: AddressProofScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddressProofScreen';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddressProofScreenArgs>(
          orElse: () => const AddressProofScreenArgs());
      return _i14.AddressProofScreen(
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

  final _i137.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddressProofScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i15.AgreedProposal]
class AgreedProposal extends _i136.PageRouteInfo<AgreedProposalArgs> {
  AgreedProposal({
    _i137.Key? key,
    required _i145.HiredContractorListDTO post,
    required int userId,
    required int postId,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AgreedProposalArgs>();
      return _i15.AgreedProposal(
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

  final _i137.Key? key;

  final _i145.HiredContractorListDTO post;

  final int userId;

  final int postId;

  @override
  String toString() {
    return 'AgreedProposalArgs{key: $key, post: $post, userId: $userId, postId: $postId}';
  }
}

/// generated route for
/// [_i16.ApprovedHiredList]
class ApprovedHiredList extends _i136.PageRouteInfo<ApprovedHiredListArgs> {
  ApprovedHiredList({
    _i137.Key? key,
    required int postId,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          ApprovedHiredList.name,
          args: ApprovedHiredListArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'ApprovedHiredList';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ApprovedHiredListArgs>();
      return _i16.ApprovedHiredList(
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

  final _i137.Key? key;

  final int postId;

  @override
  String toString() {
    return 'ApprovedHiredListArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i17.AwaitingConfirmationView]
class AwaitingConfirmationView extends _i136.PageRouteInfo<void> {
  const AwaitingConfirmationView({List<_i136.PageRouteInfo>? children})
      : super(
          AwaitingConfirmationView.name,
          initialChildren: children,
        );

  static const String name = 'AwaitingConfirmationView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i17.AwaitingConfirmationView();
    },
  );
}

/// generated route for
/// [_i18.BackgroundDocument]
class BackgroundDocument extends _i136.PageRouteInfo<BackgroundDocumentArgs> {
  BackgroundDocument({
    _i137.Key? key,
    bool isFromSplash = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          BackgroundDocument.name,
          args: BackgroundDocumentArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'BackgroundDocument';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BackgroundDocumentArgs>(
          orElse: () => const BackgroundDocumentArgs());
      return _i18.BackgroundDocument(
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

  final _i137.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'BackgroundDocumentArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i19.BankListView]
class BankListView extends _i136.PageRouteInfo<void> {
  const BankListView({List<_i136.PageRouteInfo>? children})
      : super(
          BankListView.name,
          initialChildren: children,
        );

  static const String name = 'BankListView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i19.BankListView();
    },
  );
}

/// generated route for
/// [_i20.BillingView]
class BillingView extends _i136.PageRouteInfo<void> {
  const BillingView({List<_i136.PageRouteInfo>? children})
      : super(
          BillingView.name,
          initialChildren: children,
        );

  static const String name = 'BillingView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i20.BillingView();
    },
  );
}

/// generated route for
/// [_i21.CancellationPolicyView]
class CancellationPolicyView extends _i136.PageRouteInfo<void> {
  const CancellationPolicyView({List<_i136.PageRouteInfo>? children})
      : super(
          CancellationPolicyView.name,
          initialChildren: children,
        );

  static const String name = 'CancellationPolicyView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i21.CancellationPolicyView();
    },
  );
}

/// generated route for
/// [_i22.CancelledContractorList]
class CancelledContractorList
    extends _i136.PageRouteInfo<CancelledContractorListArgs> {
  CancelledContractorList({
    required String title,
    required int postId,
    required int cancelFilter,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CancelledContractorListArgs>();
      return _i22.CancelledContractorList(
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
/// [_i23.ChangePasswordView]
class ChangePasswordView extends _i136.PageRouteInfo<void> {
  const ChangePasswordView({List<_i136.PageRouteInfo>? children})
      : super(
          ChangePasswordView.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i23.ChangePasswordView();
    },
  );
}

/// generated route for
/// [_i24.Chat]
class Chat extends _i136.PageRouteInfo<void> {
  const Chat({List<_i136.PageRouteInfo>? children})
      : super(
          Chat.name,
          initialChildren: children,
        );

  static const String name = 'Chat';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i24.Chat();
    },
  );
}

/// generated route for
/// [_i25.CommonDocumentView]
class CommonDocumentView extends _i136.PageRouteInfo<CommonDocumentViewArgs> {
  CommonDocumentView({
    _i137.Key? key,
    required String title,
    required String frontPage,
    required String backPage,
    required List<_i146.DocumentDTO> documentList,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CommonDocumentViewArgs>();
      return _i25.CommonDocumentView(
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

  final _i137.Key? key;

  final String title;

  final String frontPage;

  final String backPage;

  final List<_i146.DocumentDTO> documentList;

  @override
  String toString() {
    return 'CommonDocumentViewArgs{key: $key, title: $title, frontPage: $frontPage, backPage: $backPage, documentList: $documentList}';
  }
}

/// generated route for
/// [_i26.ContractorEarningView]
class ContractorEarningView extends _i136.PageRouteInfo<void> {
  const ContractorEarningView({List<_i136.PageRouteInfo>? children})
      : super(
          ContractorEarningView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorEarningView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i26.ContractorEarningView();
    },
  );
}

/// generated route for
/// [_i27.ContractorFullTimePositionDetailView]
class ContractorFullTimePositionDetailView extends _i136.PageRouteInfo<void> {
  const ContractorFullTimePositionDetailView(
      {List<_i136.PageRouteInfo>? children})
      : super(
          ContractorFullTimePositionDetailView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorFullTimePositionDetailView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i27.ContractorFullTimePositionDetailView();
    },
  );
}

/// generated route for
/// [_i28.ContractorFullTimePositionView]
class ContractorFullTimePositionView extends _i136.PageRouteInfo<void> {
  const ContractorFullTimePositionView({List<_i136.PageRouteInfo>? children})
      : super(
          ContractorFullTimePositionView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorFullTimePositionView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i28.ContractorFullTimePositionView();
    },
  );
}

/// generated route for
/// [_i29.ContractorHomeView]
class ContractorHomeView extends _i136.PageRouteInfo<void> {
  const ContractorHomeView({List<_i136.PageRouteInfo>? children})
      : super(
          ContractorHomeView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorHomeView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i29.ContractorHomeView();
    },
  );
}

/// generated route for
/// [_i30.ContractorLongTermView]
class ContractorLongTermView extends _i136.PageRouteInfo<void> {
  const ContractorLongTermView({List<_i136.PageRouteInfo>? children})
      : super(
          ContractorLongTermView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorLongTermView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i30.ContractorLongTermView();
    },
  );
}

/// generated route for
/// [_i31.ContractorMainTabView]
class ContractorMainTabView extends _i136.PageRouteInfo<void> {
  const ContractorMainTabView({List<_i136.PageRouteInfo>? children})
      : super(
          ContractorMainTabView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorMainTabView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i31.ContractorMainTabView();
    },
  );
}

/// generated route for
/// [_i32.ContractorPdfViewer]
class ContractorPdfViewer extends _i136.PageRouteInfo<ContractorPdfViewerArgs> {
  ContractorPdfViewer({
    required String pdfUrl,
    _i137.Key? key,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          ContractorPdfViewer.name,
          args: ContractorPdfViewerArgs(
            pdfUrl: pdfUrl,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ContractorPdfViewer';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ContractorPdfViewerArgs>();
      return _i32.ContractorPdfViewer(
        pdfUrl: args.pdfUrl,
        key: args.key,
      );
    },
  );
}

class ContractorPdfViewerArgs {
  const ContractorPdfViewerArgs({
    required this.pdfUrl,
    this.key,
  });

  final String pdfUrl;

  final _i137.Key? key;

  @override
  String toString() {
    return 'ContractorPdfViewerArgs{pdfUrl: $pdfUrl, key: $key}';
  }
}

/// generated route for
/// [_i33.ContractorPerformanceInsightView]
class ContractorPerformanceInsightView extends _i136.PageRouteInfo<void> {
  const ContractorPerformanceInsightView({List<_i136.PageRouteInfo>? children})
      : super(
          ContractorPerformanceInsightView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorPerformanceInsightView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i33.ContractorPerformanceInsightView();
    },
  );
}

/// generated route for
/// [_i34.ContractorPreviousShiftView]
class ContractorPreviousShiftView extends _i136.PageRouteInfo<void> {
  const ContractorPreviousShiftView({List<_i136.PageRouteInfo>? children})
      : super(
          ContractorPreviousShiftView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorPreviousShiftView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i34.ContractorPreviousShiftView();
    },
  );
}

/// generated route for
/// [_i35.ContractorProfileView]
class ContractorProfileView extends _i136.PageRouteInfo<void> {
  const ContractorProfileView({List<_i136.PageRouteInfo>? children})
      : super(
          ContractorProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorProfileView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i35.ContractorProfileView();
    },
  );
}

/// generated route for
/// [_i36.ContractorProposedAvailability]
class ContractorProposedAvailability
    extends _i136.PageRouteInfo<ContractorProposedAvailabilityArgs> {
  ContractorProposedAvailability({
    _i137.Key? key,
    required List<_i147.EmployerProposalShiftDetailDto> list,
    bool confirmDialog = false,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ContractorProposedAvailabilityArgs>();
      return _i36.ContractorProposedAvailability(
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

  final _i137.Key? key;

  final List<_i147.EmployerProposalShiftDetailDto> list;

  final bool confirmDialog;

  @override
  String toString() {
    return 'ContractorProposedAvailabilityArgs{key: $key, list: $list, confirmDialog: $confirmDialog}';
  }
}

/// generated route for
/// [_i37.ContractorRatingView]
class ContractorRatingView extends _i136.PageRouteInfo<void> {
  const ContractorRatingView({List<_i136.PageRouteInfo>? children})
      : super(
          ContractorRatingView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorRatingView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i37.ContractorRatingView();
    },
  );
}

/// generated route for
/// [_i38.ContractorShiftView]
class ContractorShiftView extends _i136.PageRouteInfo<void> {
  const ContractorShiftView({List<_i136.PageRouteInfo>? children})
      : super(
          ContractorShiftView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorShiftView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i38.ContractorShiftView();
    },
  );
}

/// generated route for
/// [_i39.ContractorStatementView]
class ContractorStatementView extends _i136.PageRouteInfo<void> {
  const ContractorStatementView({List<_i136.PageRouteInfo>? children})
      : super(
          ContractorStatementView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorStatementView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i39.ContractorStatementView();
    },
  );
}

/// generated route for
/// [_i40.ContractorTotalEarningView]
class ContractorTotalEarningView extends _i136.PageRouteInfo<void> {
  const ContractorTotalEarningView({List<_i136.PageRouteInfo>? children})
      : super(
          ContractorTotalEarningView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorTotalEarningView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i40.ContractorTotalEarningView();
    },
  );
}

/// generated route for
/// [_i41.ContractorUpdateProfileView]
class ContractorUpdateProfileView extends _i136.PageRouteInfo<void> {
  const ContractorUpdateProfileView({List<_i136.PageRouteInfo>? children})
      : super(
          ContractorUpdateProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorUpdateProfileView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i41.ContractorUpdateProfileView();
    },
  );
}

/// generated route for
/// [_i42.ContractorWalletView]
class ContractorWalletView extends _i136.PageRouteInfo<void> {
  const ContractorWalletView({List<_i136.PageRouteInfo>? children})
      : super(
          ContractorWalletView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorWalletView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i42.ContractorWalletView();
    },
  );
}

/// generated route for
/// [_i43.ContractorWithdrawPaymentView]
class ContractorWithdrawPaymentView extends _i136.PageRouteInfo<void> {
  const ContractorWithdrawPaymentView({List<_i136.PageRouteInfo>? children})
      : super(
          ContractorWithdrawPaymentView.name,
          initialChildren: children,
        );

  static const String name = 'ContractorWithdrawPaymentView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i43.ContractorWithdrawPaymentView();
    },
  );
}

/// generated route for
/// [_i44.CounterPurposeView]
class CounterPurposeView extends _i136.PageRouteInfo<CounterPurposeViewArgs> {
  CounterPurposeView({
    _i137.Key? key,
    required _i147.EmployerProposalDto data,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          CounterPurposeView.name,
          args: CounterPurposeViewArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'CounterPurposeView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CounterPurposeViewArgs>();
      return _i44.CounterPurposeView(
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

  final _i137.Key? key;

  final _i147.EmployerProposalDto data;

  @override
  String toString() {
    return 'CounterPurposeViewArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [_i45.CustomerSupportView]
class CustomerSupportView extends _i136.PageRouteInfo<void> {
  const CustomerSupportView({List<_i136.PageRouteInfo>? children})
      : super(
          CustomerSupportView.name,
          initialChildren: children,
        );

  static const String name = 'CustomerSupportView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i45.CustomerSupportView();
    },
  );
}

/// generated route for
/// [_i46.DocumentPage]
class DocumentPageScreen extends _i136.PageRouteInfo<DocumentPageScreenArgs> {
  DocumentPageScreen({
    _i137.Key? key,
    bool isFromSplash = false,
    bool isUpdate = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          DocumentPageScreen.name,
          args: DocumentPageScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
            isUpdate: isUpdate,
          ),
          initialChildren: children,
        );

  static const String name = 'DocumentPageScreen';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DocumentPageScreenArgs>(
          orElse: () => const DocumentPageScreenArgs());
      return _i46.DocumentPage(
        key: args.key,
        isFromSplash: args.isFromSplash,
        isUpdate: args.isUpdate,
      );
    },
  );
}

class DocumentPageScreenArgs {
  const DocumentPageScreenArgs({
    this.key,
    this.isFromSplash = false,
    this.isUpdate = false,
  });

  final _i137.Key? key;

  final bool isFromSplash;

  final bool isUpdate;

  @override
  String toString() {
    return 'DocumentPageScreenArgs{key: $key, isFromSplash: $isFromSplash, isUpdate: $isUpdate}';
  }
}

/// generated route for
/// [_i47.EditProfileView]
class EditProfileView extends _i136.PageRouteInfo<void> {
  const EditProfileView({List<_i136.PageRouteInfo>? children})
      : super(
          EditProfileView.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i47.EditProfileView();
    },
  );
}

/// generated route for
/// [_i48.EducationListScreen]
class EducationListScreen extends _i136.PageRouteInfo<EducationListScreenArgs> {
  EducationListScreen({
    _i137.Key? key,
    bool isFromSplash = false,
    bool isFromProfile = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          EducationListScreen.name,
          args: EducationListScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
            isFromProfile: isFromProfile,
          ),
          initialChildren: children,
        );

  static const String name = 'EducationListScreen';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EducationListScreenArgs>(
          orElse: () => const EducationListScreenArgs());
      return _i48.EducationListScreen(
        key: args.key,
        isFromSplash: args.isFromSplash,
        isFromProfile: args.isFromProfile,
      );
    },
  );
}

class EducationListScreenArgs {
  const EducationListScreenArgs({
    this.key,
    this.isFromSplash = false,
    this.isFromProfile = false,
  });

  final _i137.Key? key;

  final bool isFromSplash;

  final bool isFromProfile;

  @override
  String toString() {
    return 'EducationListScreenArgs{key: $key, isFromSplash: $isFromSplash, isFromProfile: $isFromProfile}';
  }
}

/// generated route for
/// [_i49.EducationProfileListView]
class EducationProfileListView
    extends _i136.PageRouteInfo<EducationProfileListViewArgs> {
  EducationProfileListView({
    _i137.Key? key,
    required _i148.ApplicantDto applicantDto,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          EducationProfileListView.name,
          args: EducationProfileListViewArgs(
            key: key,
            applicantDto: applicantDto,
          ),
          initialChildren: children,
        );

  static const String name = 'EducationProfileListView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EducationProfileListViewArgs>();
      return _i49.EducationProfileListView(
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

  final _i137.Key? key;

  final _i148.ApplicantDto applicantDto;

  @override
  String toString() {
    return 'EducationProfileListViewArgs{key: $key, applicantDto: $applicantDto}';
  }
}

/// generated route for
/// [_i50.EmployerAvailabilityView]
class EmployerAvailabilityView
    extends _i136.PageRouteInfo<EmployerAvailabilityViewArgs> {
  EmployerAvailabilityView({
    _i137.Key? key,
    required List<_i147.EmployerProposalShiftDetailDto> list,
    bool confirmDialog = false,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployerAvailabilityViewArgs>();
      return _i50.EmployerAvailabilityView(
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

  final _i137.Key? key;

  final List<_i147.EmployerProposalShiftDetailDto> list;

  final bool confirmDialog;

  @override
  String toString() {
    return 'EmployerAvailabilityViewArgs{key: $key, list: $list, confirmDialog: $confirmDialog}';
  }
}

/// generated route for
/// [_i51.EmployerCompletedShiftView]
class EmployerCompletedShiftView extends _i136.PageRouteInfo<void> {
  const EmployerCompletedShiftView({List<_i136.PageRouteInfo>? children})
      : super(
          EmployerCompletedShiftView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerCompletedShiftView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i51.EmployerCompletedShiftView();
    },
  );
}

/// generated route for
/// [_i52.EmployerFullPositionAddView]
class EmployerFullPositionAddView extends _i136.PageRouteInfo<void> {
  const EmployerFullPositionAddView({List<_i136.PageRouteInfo>? children})
      : super(
          EmployerFullPositionAddView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerFullPositionAddView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i52.EmployerFullPositionAddView();
    },
  );
}

/// generated route for
/// [_i53.EmployerFullPostingConfirmView]
class EmployerFullPostingConfirmView extends _i136.PageRouteInfo<void> {
  const EmployerFullPostingConfirmView({List<_i136.PageRouteInfo>? children})
      : super(
          EmployerFullPostingConfirmView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerFullPostingConfirmView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i53.EmployerFullPostingConfirmView();
    },
  );
}

/// generated route for
/// [_i54.EmployerFullPostingReviewView]
class EmployerFullPostingReviewView extends _i136.PageRouteInfo<void> {
  const EmployerFullPostingReviewView({List<_i136.PageRouteInfo>? children})
      : super(
          EmployerFullPostingReviewView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerFullPostingReviewView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i54.EmployerFullPostingReviewView();
    },
  );
}

/// generated route for
/// [_i55.EmployerFullPostingView]
class EmployerFullPostingView extends _i136.PageRouteInfo<void> {
  const EmployerFullPostingView({List<_i136.PageRouteInfo>? children})
      : super(
          EmployerFullPostingView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerFullPostingView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i55.EmployerFullPostingView();
    },
  );
}

/// generated route for
/// [_i56.EmployerLocationFormView]
class EmployerLocationFormView
    extends _i136.PageRouteInfo<EmployerLocationFormViewArgs> {
  EmployerLocationFormView({
    _i137.Key? key,
    int? id,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          EmployerLocationFormView.name,
          args: EmployerLocationFormViewArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'EmployerLocationFormView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployerLocationFormViewArgs>(
          orElse: () => const EmployerLocationFormViewArgs());
      return _i56.EmployerLocationFormView(
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

  final _i137.Key? key;

  final int? id;

  @override
  String toString() {
    return 'EmployerLocationFormViewArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i57.EmployerLocationView]
class EmployerLocationView extends _i136.PageRouteInfo<void> {
  const EmployerLocationView({List<_i136.PageRouteInfo>? children})
      : super(
          EmployerLocationView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerLocationView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i57.EmployerLocationView();
    },
  );
}

/// generated route for
/// [_i58.EmployerLongTermApplicantView]
class EmployerLongTermApplicantView
    extends _i136.PageRouteInfo<EmployerLongTermApplicantViewArgs> {
  EmployerLongTermApplicantView({
    _i137.Key? key,
    required int id,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          EmployerLongTermApplicantView.name,
          args: EmployerLongTermApplicantViewArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'EmployerLongTermApplicantView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployerLongTermApplicantViewArgs>();
      return _i58.EmployerLongTermApplicantView(
        key: args.key,
        id: args.id,
      );
    },
  );
}

class EmployerLongTermApplicantViewArgs {
  const EmployerLongTermApplicantViewArgs({
    this.key,
    required this.id,
  });

  final _i137.Key? key;

  final int id;

  @override
  String toString() {
    return 'EmployerLongTermApplicantViewArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i59.EmployerLongTermPayableView]
class EmployerLongTermPayableView
    extends _i136.PageRouteInfo<EmployerLongTermPayableViewArgs> {
  EmployerLongTermPayableView({
    _i137.Key? key,
    required _i149.EmployerLongTermSuccessDto employerLongTermSuccessDto,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          EmployerLongTermPayableView.name,
          args: EmployerLongTermPayableViewArgs(
            key: key,
            employerLongTermSuccessDto: employerLongTermSuccessDto,
          ),
          initialChildren: children,
        );

  static const String name = 'EmployerLongTermPayableView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployerLongTermPayableViewArgs>();
      return _i59.EmployerLongTermPayableView(
        key: args.key,
        employerLongTermSuccessDto: args.employerLongTermSuccessDto,
      );
    },
  );
}

class EmployerLongTermPayableViewArgs {
  const EmployerLongTermPayableViewArgs({
    this.key,
    required this.employerLongTermSuccessDto,
  });

  final _i137.Key? key;

  final _i149.EmployerLongTermSuccessDto employerLongTermSuccessDto;

  @override
  String toString() {
    return 'EmployerLongTermPayableViewArgs{key: $key, employerLongTermSuccessDto: $employerLongTermSuccessDto}';
  }
}

/// generated route for
/// [_i60.EmployerLongTermPositionAddDetailView]
class EmployerLongTermPositionAddDetailView
    extends _i136.PageRouteInfo<EmployerLongTermPositionAddDetailViewArgs> {
  EmployerLongTermPositionAddDetailView({
    _i137.Key? key,
    required _i142.PostShiftDTO postShiftDTO,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          EmployerLongTermPositionAddDetailView.name,
          args: EmployerLongTermPositionAddDetailViewArgs(
            key: key,
            postShiftDTO: postShiftDTO,
          ),
          initialChildren: children,
        );

  static const String name = 'EmployerLongTermPositionAddDetailView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployerLongTermPositionAddDetailViewArgs>();
      return _i60.EmployerLongTermPositionAddDetailView(
        key: args.key,
        postShiftDTO: args.postShiftDTO,
      );
    },
  );
}

class EmployerLongTermPositionAddDetailViewArgs {
  const EmployerLongTermPositionAddDetailViewArgs({
    this.key,
    required this.postShiftDTO,
  });

  final _i137.Key? key;

  final _i142.PostShiftDTO postShiftDTO;

  @override
  String toString() {
    return 'EmployerLongTermPositionAddDetailViewArgs{key: $key, postShiftDTO: $postShiftDTO}';
  }
}

/// generated route for
/// [_i61.EmployerLongTermPositionAddView]
class EmployerLongTermPositionAddView
    extends _i136.PageRouteInfo<EmployerLongTermPositionAddViewArgs> {
  EmployerLongTermPositionAddView({
    _i137.Key? key,
    int? postId,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          EmployerLongTermPositionAddView.name,
          args: EmployerLongTermPositionAddViewArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'EmployerLongTermPositionAddView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployerLongTermPositionAddViewArgs>(
          orElse: () => const EmployerLongTermPositionAddViewArgs());
      return _i61.EmployerLongTermPositionAddView(
        key: args.key,
        postId: args.postId,
      );
    },
  );
}

class EmployerLongTermPositionAddViewArgs {
  const EmployerLongTermPositionAddViewArgs({
    this.key,
    this.postId,
  });

  final _i137.Key? key;

  final int? postId;

  @override
  String toString() {
    return 'EmployerLongTermPositionAddViewArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i62.EmployerLongTermPositionDetailView]
class EmployerLongTermPositionDetailView extends _i136.PageRouteInfo<void> {
  const EmployerLongTermPositionDetailView(
      {List<_i136.PageRouteInfo>? children})
      : super(
          EmployerLongTermPositionDetailView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerLongTermPositionDetailView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i62.EmployerLongTermPositionDetailView();
    },
  );
}

/// generated route for
/// [_i63.EmployerLongTermPostConfirmationView]
class EmployerLongTermPostConfirmationView
    extends _i136.PageRouteInfo<EmployerLongTermPostConfirmationViewArgs> {
  EmployerLongTermPostConfirmationView({
    _i137.Key? key,
    required _i142.PostShiftDTO postShiftDTO,
    required _i150.EmployerLongTermAddDetailDto employerAddDetailDto,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          EmployerLongTermPostConfirmationView.name,
          args: EmployerLongTermPostConfirmationViewArgs(
            key: key,
            postShiftDTO: postShiftDTO,
            employerAddDetailDto: employerAddDetailDto,
          ),
          initialChildren: children,
        );

  static const String name = 'EmployerLongTermPostConfirmationView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployerLongTermPostConfirmationViewArgs>();
      return _i63.EmployerLongTermPostConfirmationView(
        key: args.key,
        postShiftDTO: args.postShiftDTO,
        employerAddDetailDto: args.employerAddDetailDto,
      );
    },
  );
}

class EmployerLongTermPostConfirmationViewArgs {
  const EmployerLongTermPostConfirmationViewArgs({
    this.key,
    required this.postShiftDTO,
    required this.employerAddDetailDto,
  });

  final _i137.Key? key;

  final _i142.PostShiftDTO postShiftDTO;

  final _i150.EmployerLongTermAddDetailDto employerAddDetailDto;

  @override
  String toString() {
    return 'EmployerLongTermPostConfirmationViewArgs{key: $key, postShiftDTO: $postShiftDTO, employerAddDetailDto: $employerAddDetailDto}';
  }
}

/// generated route for
/// [_i64.EmployerLongTermReviewDetailView]
class EmployerLongTermReviewDetailView
    extends _i136.PageRouteInfo<EmployerLongTermReviewDetailViewArgs> {
  EmployerLongTermReviewDetailView({
    _i137.Key? key,
    required _i149.EmployerLongTermSuccessDto employerLongTermSuccessDto,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          EmployerLongTermReviewDetailView.name,
          args: EmployerLongTermReviewDetailViewArgs(
            key: key,
            employerLongTermSuccessDto: employerLongTermSuccessDto,
          ),
          initialChildren: children,
        );

  static const String name = 'EmployerLongTermReviewDetailView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployerLongTermReviewDetailViewArgs>();
      return _i64.EmployerLongTermReviewDetailView(
        key: args.key,
        employerLongTermSuccessDto: args.employerLongTermSuccessDto,
      );
    },
  );
}

class EmployerLongTermReviewDetailViewArgs {
  const EmployerLongTermReviewDetailViewArgs({
    this.key,
    required this.employerLongTermSuccessDto,
  });

  final _i137.Key? key;

  final _i149.EmployerLongTermSuccessDto employerLongTermSuccessDto;

  @override
  String toString() {
    return 'EmployerLongTermReviewDetailViewArgs{key: $key, employerLongTermSuccessDto: $employerLongTermSuccessDto}';
  }
}

/// generated route for
/// [_i65.EmployerLongTermView]
class EmployerLongTermView extends _i136.PageRouteInfo<void> {
  const EmployerLongTermView({List<_i136.PageRouteInfo>? children})
      : super(
          EmployerLongTermView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerLongTermView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i65.EmployerLongTermView();
    },
  );
}

/// generated route for
/// [_i66.EmployerShiftView]
class EmployerShiftView extends _i136.PageRouteInfo<void> {
  const EmployerShiftView({List<_i136.PageRouteInfo>? children})
      : super(
          EmployerShiftView.name,
          initialChildren: children,
        );

  static const String name = 'EmployerShiftView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i66.EmployerShiftView();
    },
  );
}

/// generated route for
/// [_i67.FaqView]
class FaqView extends _i136.PageRouteInfo<void> {
  const FaqView({List<_i136.PageRouteInfo>? children})
      : super(
          FaqView.name,
          initialChildren: children,
        );

  static const String name = 'FaqView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i67.FaqView();
    },
  );
}

/// generated route for
/// [_i68.FilledHiredContractorList]
class FilledHiredContractorList
    extends _i136.PageRouteInfo<FilledHiredContractorListArgs> {
  FilledHiredContractorList({
    required int postId,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          FilledHiredContractorList.name,
          args: FilledHiredContractorListArgs(postId: postId),
          initialChildren: children,
        );

  static const String name = 'FilledHiredContractorList';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FilledHiredContractorListArgs>();
      return _i68.FilledHiredContractorList(postId: args.postId);
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
/// [_i69.FilledShiftsView]
class FilledShiftsView extends _i136.PageRouteInfo<void> {
  const FilledShiftsView({List<_i136.PageRouteInfo>? children})
      : super(
          FilledShiftsView.name,
          initialChildren: children,
        );

  static const String name = 'FilledShiftsView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i69.FilledShiftsView();
    },
  );
}

/// generated route for
/// [_i70.HealthCarePostForm]
class HealthCarePostForm extends _i136.PageRouteInfo<HealthCarePostFormArgs> {
  HealthCarePostForm({
    _i137.Key? key,
    int? postId,
    bool isFromSplash = false,
    bool fromSaveTemplate = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          HealthCarePostForm.name,
          args: HealthCarePostFormArgs(
            key: key,
            postId: postId,
            isFromSplash: isFromSplash,
            fromSaveTemplate: fromSaveTemplate,
          ),
          initialChildren: children,
        );

  static const String name = 'HealthCarePostForm';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HealthCarePostFormArgs>(
          orElse: () => const HealthCarePostFormArgs());
      return _i70.HealthCarePostForm(
        key: args.key,
        postId: args.postId,
        isFromSplash: args.isFromSplash,
        fromSaveTemplate: args.fromSaveTemplate,
      );
    },
  );
}

class HealthCarePostFormArgs {
  const HealthCarePostFormArgs({
    this.key,
    this.postId,
    this.isFromSplash = false,
    this.fromSaveTemplate = false,
  });

  final _i137.Key? key;

  final int? postId;

  final bool isFromSplash;

  final bool fromSaveTemplate;

  @override
  String toString() {
    return 'HealthCarePostFormArgs{key: $key, postId: $postId, isFromSplash: $isFromSplash, fromSaveTemplate: $fromSaveTemplate}';
  }
}

/// generated route for
/// [_i71.HealthcarePostShift]
class HealthcarePostShift extends _i136.PageRouteInfo<HealthcarePostShiftArgs> {
  HealthcarePostShift({
    _i137.Key? key,
    required int postId,
    _i141.HealthcarePostDTO? updateShift,
    required _i142.PostShiftDTO post,
    bool fromSaveTemplate = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          HealthcarePostShift.name,
          args: HealthcarePostShiftArgs(
            key: key,
            postId: postId,
            updateShift: updateShift,
            post: post,
            fromSaveTemplate: fromSaveTemplate,
          ),
          initialChildren: children,
        );

  static const String name = 'HealthcarePostShift';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HealthcarePostShiftArgs>();
      return _i71.HealthcarePostShift(
        key: args.key,
        postId: args.postId,
        updateShift: args.updateShift,
        post: args.post,
        fromSaveTemplate: args.fromSaveTemplate,
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
    this.fromSaveTemplate = false,
  });

  final _i137.Key? key;

  final int postId;

  final _i141.HealthcarePostDTO? updateShift;

  final _i142.PostShiftDTO post;

  final bool fromSaveTemplate;

  @override
  String toString() {
    return 'HealthcarePostShiftArgs{key: $key, postId: $postId, updateShift: $updateShift, post: $post, fromSaveTemplate: $fromSaveTemplate}';
  }
}

/// generated route for
/// [_i72.HiredContractorView]
class HiredContractorView extends _i136.PageRouteInfo<HiredContractorViewArgs> {
  HiredContractorView({
    _i137.Key? key,
    required int postId,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          HiredContractorView.name,
          args: HiredContractorViewArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'HiredContractorView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HiredContractorViewArgs>();
      return _i72.HiredContractorView(
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

  final _i137.Key? key;

  final int postId;

  @override
  String toString() {
    return 'HiredContractorViewArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i73.HomeView]
class HomeView extends _i136.PageRouteInfo<void> {
  const HomeView({List<_i136.PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i73.HomeView();
    },
  );
}

/// generated route for
/// [_i74.IntroQuizScreen]
class IntroQuizScreen extends _i136.PageRouteInfo<void> {
  const IntroQuizScreen({List<_i136.PageRouteInfo>? children})
      : super(
          IntroQuizScreen.name,
          initialChildren: children,
        );

  static const String name = 'IntroQuizScreen';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return _i74.IntroQuizScreen();
    },
  );
}

/// generated route for
/// [_i75.IntroVideoScreen]
class IntroVideoScreen extends _i136.PageRouteInfo<void> {
  const IntroVideoScreen({List<_i136.PageRouteInfo>? children})
      : super(
          IntroVideoScreen.name,
          initialChildren: children,
        );

  static const String name = 'IntroVideoScreen';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return _i75.IntroVideoScreen();
    },
  );
}

/// generated route for
/// [_i76.InvoiceDetailView]
class InvoiceDetailView extends _i136.PageRouteInfo<InvoiceDetailViewArgs> {
  InvoiceDetailView({
    _i137.Key? key,
    required int id,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          InvoiceDetailView.name,
          args: InvoiceDetailViewArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'InvoiceDetailView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InvoiceDetailViewArgs>();
      return _i76.InvoiceDetailView(
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

  final _i137.Key? key;

  final int id;

  @override
  String toString() {
    return 'InvoiceDetailViewArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i77.InvoiceView]
class InvoiceView extends _i136.PageRouteInfo<void> {
  const InvoiceView({List<_i136.PageRouteInfo>? children})
      : super(
          InvoiceView.name,
          initialChildren: children,
        );

  static const String name = 'InvoiceView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i77.InvoiceView();
    },
  );
}

/// generated route for
/// [_i78.LegalScreeningQuestionsPage]
class LegalScreeningQuestionsPage
    extends _i136.PageRouteInfo<LegalScreeningQuestionsPageArgs> {
  LegalScreeningQuestionsPage({
    _i137.Key? key,
    bool isFromSplash = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          LegalScreeningQuestionsPage.name,
          args: LegalScreeningQuestionsPageArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'LegalScreeningQuestionsPage';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LegalScreeningQuestionsPageArgs>(
          orElse: () => const LegalScreeningQuestionsPageArgs());
      return _i78.LegalScreeningQuestionsPage(
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

  final _i137.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'LegalScreeningQuestionsPageArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i79.LocationDetailForm]
class LocationDetailForm extends _i136.PageRouteInfo<LocationDetailFormArgs> {
  LocationDetailForm({
    _i137.Key? key,
    bool isFromSplash = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          LocationDetailForm.name,
          args: LocationDetailFormArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'LocationDetailForm';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LocationDetailFormArgs>(
          orElse: () => const LocationDetailFormArgs());
      return _i79.LocationDetailForm(
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

  final _i137.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'LocationDetailFormArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i80.LocationExample]
class LocationExample extends _i136.PageRouteInfo<void> {
  const LocationExample({List<_i136.PageRouteInfo>? children})
      : super(
          LocationExample.name,
          initialChildren: children,
        );

  static const String name = 'LocationExample';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return _i80.LocationExample();
    },
  );
}

/// generated route for
/// [_i81.LoginScreen]
class LoginPage extends _i136.PageRouteInfo<void> {
  const LoginPage({List<_i136.PageRouteInfo>? children})
      : super(
          LoginPage.name,
          initialChildren: children,
        );

  static const String name = 'LoginPage';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i81.LoginScreen();
    },
  );
}

/// generated route for
/// [_i82.MainTabView]
class MainTabView extends _i136.PageRouteInfo<void> {
  const MainTabView({List<_i136.PageRouteInfo>? children})
      : super(
          MainTabView.name,
          initialChildren: children,
        );

  static const String name = 'MainTabView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i82.MainTabView();
    },
  );
}

/// generated route for
/// [_i83.Message]
class Message extends _i136.PageRouteInfo<MessageArgs> {
  Message({
    _i137.Key? key,
    required int receiverId,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          Message.name,
          args: MessageArgs(
            key: key,
            receiverId: receiverId,
          ),
          initialChildren: children,
        );

  static const String name = 'Message';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MessageArgs>();
      return _i83.Message(
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

  final _i137.Key? key;

  final int receiverId;

  @override
  String toString() {
    return 'MessageArgs{key: $key, receiverId: $receiverId}';
  }
}

/// generated route for
/// [_i84.MonthlyStatementView]
class MonthlyStatementView extends _i136.PageRouteInfo<void> {
  const MonthlyStatementView({List<_i136.PageRouteInfo>? children})
      : super(
          MonthlyStatementView.name,
          initialChildren: children,
        );

  static const String name = 'MonthlyStatementView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i84.MonthlyStatementView();
    },
  );
}

/// generated route for
/// [_i85.MultiAgreedShift]
class MultiAgreedShift extends _i136.PageRouteInfo<MultiAgreedShiftArgs> {
  MultiAgreedShift({
    required _i147.EmployerProposalDto contractor,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          MultiAgreedShift.name,
          args: MultiAgreedShiftArgs(contractor: contractor),
          initialChildren: children,
        );

  static const String name = 'MultiAgreedShift';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MultiAgreedShiftArgs>();
      return _i85.MultiAgreedShift(contractor: args.contractor);
    },
  );
}

class MultiAgreedShiftArgs {
  const MultiAgreedShiftArgs({required this.contractor});

  final _i147.EmployerProposalDto contractor;

  @override
  String toString() {
    return 'MultiAgreedShiftArgs{contractor: $contractor}';
  }
}

/// generated route for
/// [_i86.MyCalendarView]
class MyCalendarView extends _i136.PageRouteInfo<void> {
  const MyCalendarView({List<_i136.PageRouteInfo>? children})
      : super(
          MyCalendarView.name,
          initialChildren: children,
        );

  static const String name = 'MyCalendarView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i86.MyCalendarView();
    },
  );
}

/// generated route for
/// [_i87.NotificationView]
class NotificationView extends _i136.PageRouteInfo<void> {
  const NotificationView({List<_i136.PageRouteInfo>? children})
      : super(
          NotificationView.name,
          initialChildren: children,
        );

  static const String name = 'NotificationView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i87.NotificationView();
    },
  );
}

/// generated route for
/// [_i88.OnBoarding1]
class Onboarding1 extends _i136.PageRouteInfo<Onboarding1Args> {
  Onboarding1({
    _i137.Key? key,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          Onboarding1.name,
          args: Onboarding1Args(key: key),
          initialChildren: children,
        );

  static const String name = 'Onboarding1';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<Onboarding1Args>(orElse: () => const Onboarding1Args());
      return _i88.OnBoarding1(key: args.key);
    },
  );
}

class Onboarding1Args {
  const Onboarding1Args({this.key});

  final _i137.Key? key;

  @override
  String toString() {
    return 'Onboarding1Args{key: $key}';
  }
}

/// generated route for
/// [_i89.OnBoarding2]
class Onboarding2 extends _i136.PageRouteInfo<Onboarding2Args> {
  Onboarding2({
    _i137.Key? key,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          Onboarding2.name,
          args: Onboarding2Args(key: key),
          initialChildren: children,
        );

  static const String name = 'Onboarding2';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<Onboarding2Args>(orElse: () => const Onboarding2Args());
      return _i89.OnBoarding2(key: args.key);
    },
  );
}

class Onboarding2Args {
  const Onboarding2Args({this.key});

  final _i137.Key? key;

  @override
  String toString() {
    return 'Onboarding2Args{key: $key}';
  }
}

/// generated route for
/// [_i90.OnBoarding3]
class OnBoarding3 extends _i136.PageRouteInfo<OnBoarding3Args> {
  OnBoarding3({
    _i137.Key? key,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          OnBoarding3.name,
          args: OnBoarding3Args(key: key),
          initialChildren: children,
        );

  static const String name = 'OnBoarding3';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<OnBoarding3Args>(orElse: () => const OnBoarding3Args());
      return _i90.OnBoarding3(key: args.key);
    },
  );
}

class OnBoarding3Args {
  const OnBoarding3Args({this.key});

  final _i137.Key? key;

  @override
  String toString() {
    return 'OnBoarding3Args{key: $key}';
  }
}

/// generated route for
/// [_i91.PayableDetail]
class PayableDetail extends _i136.PageRouteInfo<PayableDetailArgs> {
  PayableDetail({
    _i137.Key? key,
    required _i141.HealthcarePostDTO post,
    bool isUpdate = false,
    _i142.PostShiftDTO? updatedPost,
    bool fromSaveTemplate = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          PayableDetail.name,
          args: PayableDetailArgs(
            key: key,
            post: post,
            isUpdate: isUpdate,
            updatedPost: updatedPost,
            fromSaveTemplate: fromSaveTemplate,
          ),
          initialChildren: children,
        );

  static const String name = 'PayableDetail';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PayableDetailArgs>();
      return _i91.PayableDetail(
        key: args.key,
        post: args.post,
        isUpdate: args.isUpdate,
        updatedPost: args.updatedPost,
        fromSaveTemplate: args.fromSaveTemplate,
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
    this.fromSaveTemplate = false,
  });

  final _i137.Key? key;

  final _i141.HealthcarePostDTO post;

  final bool isUpdate;

  final _i142.PostShiftDTO? updatedPost;

  final bool fromSaveTemplate;

  @override
  String toString() {
    return 'PayableDetailArgs{key: $key, post: $post, isUpdate: $isUpdate, updatedPost: $updatedPost, fromSaveTemplate: $fromSaveTemplate}';
  }
}

/// generated route for
/// [_i92.PaymentHistoryView]
class PaymentHistoryView extends _i136.PageRouteInfo<void> {
  const PaymentHistoryView({List<_i136.PageRouteInfo>? children})
      : super(
          PaymentHistoryView.name,
          initialChildren: children,
        );

  static const String name = 'PaymentHistoryView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i92.PaymentHistoryView();
    },
  );
}

/// generated route for
/// [_i93.PaymentMethodView]
class PaymentMethodView extends _i136.PageRouteInfo<void> {
  const PaymentMethodView({List<_i136.PageRouteInfo>? children})
      : super(
          PaymentMethodView.name,
          initialChildren: children,
        );

  static const String name = 'PaymentMethodView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i93.PaymentMethodView();
    },
  );
}

/// generated route for
/// [_i94.PersonalProfileView]
class PersonalProfileView extends _i136.PageRouteInfo<PersonalProfileViewArgs> {
  PersonalProfileView({
    _i137.Key? key,
    required _i148.ApplicantDto applicantDto,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          PersonalProfileView.name,
          args: PersonalProfileViewArgs(
            key: key,
            applicantDto: applicantDto,
          ),
          initialChildren: children,
        );

  static const String name = 'PersonalProfileView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PersonalProfileViewArgs>();
      return _i94.PersonalProfileView(
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

  final _i137.Key? key;

  final _i148.ApplicantDto applicantDto;

  @override
  String toString() {
    return 'PersonalProfileViewArgs{key: $key, applicantDto: $applicantDto}';
  }
}

/// generated route for
/// [_i95.PersonalReferenceDetail]
class PersonalReferenceDetail
    extends _i136.PageRouteInfo<PersonalReferenceDetailArgs> {
  PersonalReferenceDetail({
    _i137.Key? key,
    required _i144.ReferenceDTO data,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          PersonalReferenceDetail.name,
          args: PersonalReferenceDetailArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'PersonalReferenceDetail';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PersonalReferenceDetailArgs>();
      return _i95.PersonalReferenceDetail(
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

  final _i137.Key? key;

  final _i144.ReferenceDTO data;

  @override
  String toString() {
    return 'PersonalReferenceDetailArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [_i96.PostShiftRecurring]
class PostShiftRecurring extends _i136.PageRouteInfo<PostShiftRecurringArgs> {
  PostShiftRecurring({
    _i137.Key? key,
    required int shiftType,
    required _i141.HealthcarePostDTO? updateShift,
    required _i142.PostShiftDTO post,
    bool fromSaveTemplate = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          PostShiftRecurring.name,
          args: PostShiftRecurringArgs(
            key: key,
            shiftType: shiftType,
            updateShift: updateShift,
            post: post,
            fromSaveTemplate: fromSaveTemplate,
          ),
          initialChildren: children,
        );

  static const String name = 'PostShiftRecurring';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostShiftRecurringArgs>();
      return _i96.PostShiftRecurring(
        key: args.key,
        shiftType: args.shiftType,
        updateShift: args.updateShift,
        post: args.post,
        fromSaveTemplate: args.fromSaveTemplate,
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
    this.fromSaveTemplate = false,
  });

  final _i137.Key? key;

  final int shiftType;

  final _i141.HealthcarePostDTO? updateShift;

  final _i142.PostShiftDTO post;

  final bool fromSaveTemplate;

  @override
  String toString() {
    return 'PostShiftRecurringArgs{key: $key, shiftType: $shiftType, updateShift: $updateShift, post: $post, fromSaveTemplate: $fromSaveTemplate}';
  }
}

/// generated route for
/// [_i97.PreviousShiftAllView]
class PreviousShiftAllView
    extends _i136.PageRouteInfo<PreviousShiftAllViewArgs> {
  PreviousShiftAllView({
    _i137.Key? key,
    bool completedShift = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          PreviousShiftAllView.name,
          args: PreviousShiftAllViewArgs(
            key: key,
            completedShift: completedShift,
          ),
          initialChildren: children,
        );

  static const String name = 'PreviousShiftAllView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PreviousShiftAllViewArgs>(
          orElse: () => const PreviousShiftAllViewArgs());
      return _i97.PreviousShiftAllView(
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

  final _i137.Key? key;

  final bool completedShift;

  @override
  String toString() {
    return 'PreviousShiftAllViewArgs{key: $key, completedShift: $completedShift}';
  }
}

/// generated route for
/// [_i98.PreviousShiftView]
class PreviousShiftView extends _i136.PageRouteInfo<void> {
  const PreviousShiftView({List<_i136.PageRouteInfo>? children})
      : super(
          PreviousShiftView.name,
          initialChildren: children,
        );

  static const String name = 'PreviousShiftView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i98.PreviousShiftView();
    },
  );
}

/// generated route for
/// [_i99.PrivacyPolicyScreen]
class PrivacyPolicyScreen extends _i136.PageRouteInfo<PrivacyPolicyScreenArgs> {
  PrivacyPolicyScreen({
    _i137.Key? key,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          PrivacyPolicyScreen.name,
          args: PrivacyPolicyScreenArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'PrivacyPolicyScreen';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PrivacyPolicyScreenArgs>(
          orElse: () => const PrivacyPolicyScreenArgs());
      return _i99.PrivacyPolicyScreen(key: args.key);
    },
  );
}

class PrivacyPolicyScreenArgs {
  const PrivacyPolicyScreenArgs({this.key});

  final _i137.Key? key;

  @override
  String toString() {
    return 'PrivacyPolicyScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i100.ProfessionalProfileView]
class ProfessionalProfileView
    extends _i136.PageRouteInfo<ProfessionalProfileViewArgs> {
  ProfessionalProfileView({
    _i137.Key? key,
    required _i148.ApplicantDto applicantDto,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          ProfessionalProfileView.name,
          args: ProfessionalProfileViewArgs(
            key: key,
            applicantDto: applicantDto,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfessionalProfileView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfessionalProfileViewArgs>();
      return _i100.ProfessionalProfileView(
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

  final _i137.Key? key;

  final _i148.ApplicantDto applicantDto;

  @override
  String toString() {
    return 'ProfessionalProfileViewArgs{key: $key, applicantDto: $applicantDto}';
  }
}

/// generated route for
/// [_i101.ProfessionalReferenceDetail]
class ProfessionalReferenceDetail
    extends _i136.PageRouteInfo<ProfessionalReferenceDetailArgs> {
  ProfessionalReferenceDetail({
    _i137.Key? key,
    required _i144.ReferenceDTO data,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          ProfessionalReferenceDetail.name,
          args: ProfessionalReferenceDetailArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfessionalReferenceDetail';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfessionalReferenceDetailArgs>();
      return _i101.ProfessionalReferenceDetail(
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

  final _i137.Key? key;

  final _i144.ReferenceDTO data;

  @override
  String toString() {
    return 'ProfessionalReferenceDetailArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [_i102.ProfileView]
class ProfileView extends _i136.PageRouteInfo<void> {
  const ProfileView({List<_i136.PageRouteInfo>? children})
      : super(
          ProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ProfileView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i102.ProfileView();
    },
  );
}

/// generated route for
/// [_i103.ProofOfLegalStatus]
class ProofOfLegalStatus extends _i136.PageRouteInfo<ProofOfLegalStatusArgs> {
  ProofOfLegalStatus({
    _i137.Key? key,
    bool isFromSplash = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          ProofOfLegalStatus.name,
          args: ProofOfLegalStatusArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'ProofOfLegalStatus';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProofOfLegalStatusArgs>(
          orElse: () => const ProofOfLegalStatusArgs());
      return _i103.ProofOfLegalStatus(
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

  final _i137.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'ProofOfLegalStatusArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i104.ProposalReceived]
class ProposalReceived extends _i136.PageRouteInfo<ProposalReceivedArgs> {
  ProposalReceived({
    _i137.Key? key,
    required _i151.AppliedShiftDTO post,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          ProposalReceived.name,
          args: ProposalReceivedArgs(
            key: key,
            post: post,
          ),
          initialChildren: children,
        );

  static const String name = 'ProposalReceived';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProposalReceivedArgs>();
      return _i104.ProposalReceived(
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

  final _i137.Key? key;

  final _i151.AppliedShiftDTO post;

  @override
  String toString() {
    return 'ProposalReceivedArgs{key: $key, post: $post}';
  }
}

/// generated route for
/// [_i105.ProposeAvailability]
class ProposeAvailability extends _i136.PageRouteInfo<ProposeAvailabilityArgs> {
  ProposeAvailability({
    required _i141.HealthcarePostDTO post,
    List<_i152.DateTimeDTO>? updatedDates,
    String? totalPayableHours,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          ProposeAvailability.name,
          args: ProposeAvailabilityArgs(
            post: post,
            updatedDates: updatedDates,
            totalPayableHours: totalPayableHours,
          ),
          initialChildren: children,
        );

  static const String name = 'ProposeAvailability';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProposeAvailabilityArgs>();
      return _i105.ProposeAvailability(
        post: args.post,
        updatedDates: args.updatedDates,
        totalPayableHours: args.totalPayableHours,
      );
    },
  );
}

class ProposeAvailabilityArgs {
  const ProposeAvailabilityArgs({
    required this.post,
    this.updatedDates,
    this.totalPayableHours,
  });

  final _i141.HealthcarePostDTO post;

  final List<_i152.DateTimeDTO>? updatedDates;

  final String? totalPayableHours;

  @override
  String toString() {
    return 'ProposeAvailabilityArgs{post: $post, updatedDates: $updatedDates, totalPayableHours: $totalPayableHours}';
  }
}

/// generated route for
/// [_i106.QuizResultScreen]
class QuizResultScreen extends _i136.PageRouteInfo<void> {
  const QuizResultScreen({List<_i136.PageRouteInfo>? children})
      : super(
          QuizResultScreen.name,
          initialChildren: children,
        );

  static const String name = 'QuizResultScreen';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return _i106.QuizResultScreen();
    },
  );
}

/// generated route for
/// [_i107.ReferColleagueView]
class ReferColleagueView extends _i136.PageRouteInfo<void> {
  const ReferColleagueView({List<_i136.PageRouteInfo>? children})
      : super(
          ReferColleagueView.name,
          initialChildren: children,
        );

  static const String name = 'ReferColleagueView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i107.ReferColleagueView();
    },
  );
}

/// generated route for
/// [_i108.ReferenceListScreen]
class ReferenceListScreen extends _i136.PageRouteInfo<ReferenceListScreenArgs> {
  ReferenceListScreen({
    _i137.Key? key,
    bool isFromSplash = false,
    bool isFromProfile = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          ReferenceListScreen.name,
          args: ReferenceListScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
            isFromProfile: isFromProfile,
          ),
          initialChildren: children,
        );

  static const String name = 'ReferenceListScreen';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReferenceListScreenArgs>(
          orElse: () => const ReferenceListScreenArgs());
      return _i108.ReferenceListScreen(
        key: args.key,
        isFromSplash: args.isFromSplash,
        isFromProfile: args.isFromProfile,
      );
    },
  );
}

class ReferenceListScreenArgs {
  const ReferenceListScreenArgs({
    this.key,
    this.isFromSplash = false,
    this.isFromProfile = false,
  });

  final _i137.Key? key;

  final bool isFromSplash;

  final bool isFromProfile;

  @override
  String toString() {
    return 'ReferenceListScreenArgs{key: $key, isFromSplash: $isFromSplash, isFromProfile: $isFromProfile}';
  }
}

/// generated route for
/// [_i109.ReferenceListView]
class ReferenceListView extends _i136.PageRouteInfo<void> {
  const ReferenceListView({List<_i136.PageRouteInfo>? children})
      : super(
          ReferenceListView.name,
          initialChildren: children,
        );

  static const String name = 'ReferenceListView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i109.ReferenceListView();
    },
  );
}

/// generated route for
/// [_i110.RegisterProfileScreen]
class RegisterProfilePage extends _i136.PageRouteInfo<RegisterProfilePageArgs> {
  RegisterProfilePage({
    _i137.Key? key,
    required String firstName,
    required String lastName,
    required int checkTermsPrivacy,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterProfilePageArgs>();
      return _i110.RegisterProfileScreen(
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

  final _i137.Key? key;

  final String firstName;

  final String lastName;

  final int checkTermsPrivacy;

  @override
  String toString() {
    return 'RegisterProfilePageArgs{key: $key, firstName: $firstName, lastName: $lastName, checkTermsPrivacy: $checkTermsPrivacy}';
  }
}

/// generated route for
/// [_i111.RegisterScreen]
class RegisterPage extends _i136.PageRouteInfo<void> {
  const RegisterPage({List<_i136.PageRouteInfo>? children})
      : super(
          RegisterPage.name,
          initialChildren: children,
        );

  static const String name = 'RegisterPage';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i111.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i112.ReviewPostShiftDetail]
class ReviewPostShiftDetail
    extends _i136.PageRouteInfo<ReviewPostShiftDetailArgs> {
  ReviewPostShiftDetail({
    _i137.Key? key,
    required _i141.HealthcarePostDTO post,
    bool isUpdate = false,
    _i142.PostShiftDTO? updatedPost,
    bool fromSaveTemplate = false,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          ReviewPostShiftDetail.name,
          args: ReviewPostShiftDetailArgs(
            key: key,
            post: post,
            isUpdate: isUpdate,
            updatedPost: updatedPost,
            fromSaveTemplate: fromSaveTemplate,
          ),
          initialChildren: children,
        );

  static const String name = 'ReviewPostShiftDetail';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReviewPostShiftDetailArgs>();
      return _i112.ReviewPostShiftDetail(
        key: args.key,
        post: args.post,
        isUpdate: args.isUpdate,
        updatedPost: args.updatedPost,
        fromSaveTemplate: args.fromSaveTemplate,
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
    this.fromSaveTemplate = false,
  });

  final _i137.Key? key;

  final _i141.HealthcarePostDTO post;

  final bool isUpdate;

  final _i142.PostShiftDTO? updatedPost;

  final bool fromSaveTemplate;

  @override
  String toString() {
    return 'ReviewPostShiftDetailArgs{key: $key, post: $post, isUpdate: $isUpdate, updatedPost: $updatedPost, fromSaveTemplate: $fromSaveTemplate}';
  }
}

/// generated route for
/// [_i113.SaveTemplateView]
class SaveTemplateView extends _i136.PageRouteInfo<void> {
  const SaveTemplateView({List<_i136.PageRouteInfo>? children})
      : super(
          SaveTemplateView.name,
          initialChildren: children,
        );

  static const String name = 'SaveTemplateView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i113.SaveTemplateView();
    },
  );
}

/// generated route for
/// [_i114.SendProposal]
class SendProposal extends _i136.PageRouteInfo<SendProposalArgs> {
  SendProposal({
    _i137.Key? key,
    required int postId,
    required int? id,
    bool isFromCounterPropose = false,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SendProposalArgs>();
      return _i114.SendProposal(
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

  final _i137.Key? key;

  final int postId;

  final int? id;

  final bool isFromCounterPropose;

  @override
  String toString() {
    return 'SendProposalArgs{key: $key, postId: $postId, id: $id, isFromCounterPropose: $isFromCounterPropose}';
  }
}

/// generated route for
/// [_i115.ShiftActionsView]
class ShiftActionsView extends _i136.PageRouteInfo<ShiftActionsViewArgs> {
  ShiftActionsView({
    _i137.Key? key,
    required int postId,
    required int userId,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ShiftActionsViewArgs>();
      return _i115.ShiftActionsView(
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

  final _i137.Key? key;

  final int postId;

  final int userId;

  @override
  String toString() {
    return 'ShiftActionsViewArgs{key: $key, postId: $postId, userId: $userId}';
  }
}

/// generated route for
/// [_i116.ShowGoogleMap]
class ShowGoogleMap extends _i136.PageRouteInfo<ShowGoogleMapArgs> {
  ShowGoogleMap({
    _i137.Key? key,
    required double latitude,
    required double longitude,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ShowGoogleMapArgs>();
      return _i116.ShowGoogleMap(
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

  final _i137.Key? key;

  final double latitude;

  final double longitude;

  @override
  String toString() {
    return 'ShowGoogleMapArgs{key: $key, latitude: $latitude, longitude: $longitude}';
  }
}

/// generated route for
/// [_i117.SingleAgreedShift]
class SingleAgreedShift extends _i136.PageRouteInfo<SingleAgreedShiftArgs> {
  SingleAgreedShift({
    required _i147.EmployerProposalDto contractor,
    int? index,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          SingleAgreedShift.name,
          args: SingleAgreedShiftArgs(
            contractor: contractor,
            index: index,
          ),
          initialChildren: children,
        );

  static const String name = 'SingleAgreedShift';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SingleAgreedShiftArgs>();
      return _i117.SingleAgreedShift(
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

  final _i147.EmployerProposalDto contractor;

  final int? index;

  @override
  String toString() {
    return 'SingleAgreedShiftArgs{contractor: $contractor, index: $index}';
  }
}

/// generated route for
/// [_i118.SplashPage]
class SplashPage extends _i136.PageRouteInfo<void> {
  const SplashPage({List<_i136.PageRouteInfo>? children})
      : super(
          SplashPage.name,
          initialChildren: children,
        );

  static const String name = 'SplashPage';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i118.SplashPage();
    },
  );
}

/// generated route for
/// [_i119.SupportTicketView]
class SupportTicketView extends _i136.PageRouteInfo<void> {
  const SupportTicketView({List<_i136.PageRouteInfo>? children})
      : super(
          SupportTicketView.name,
          initialChildren: children,
        );

  static const String name = 'SupportTicketView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i119.SupportTicketView();
    },
  );
}

/// generated route for
/// [_i120.TeamDetailView]
class TeamDetailView extends _i136.PageRouteInfo<TeamDetailViewArgs> {
  TeamDetailView({
    _i137.Key? key,
    required _i143.GetTeamsListDTO getTeamsListDTO,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          TeamDetailView.name,
          args: TeamDetailViewArgs(
            key: key,
            getTeamsListDTO: getTeamsListDTO,
          ),
          initialChildren: children,
        );

  static const String name = 'TeamDetailView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TeamDetailViewArgs>();
      return _i120.TeamDetailView(
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

  final _i137.Key? key;

  final _i143.GetTeamsListDTO getTeamsListDTO;

  @override
  String toString() {
    return 'TeamDetailViewArgs{key: $key, getTeamsListDTO: $getTeamsListDTO}';
  }
}

/// generated route for
/// [_i121.TeamsView]
class TeamsView extends _i136.PageRouteInfo<void> {
  const TeamsView({List<_i136.PageRouteInfo>? children})
      : super(
          TeamsView.name,
          initialChildren: children,
        );

  static const String name = 'TeamsView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i121.TeamsView();
    },
  );
}

/// generated route for
/// [_i122.TermsAndConditionsScreen]
class TermsAndConditionsScreen
    extends _i136.PageRouteInfo<TermsAndConditionsScreenArgs> {
  TermsAndConditionsScreen({
    _i137.Key? key,
    bool isFromSplash = false,
    bool isFromRegister = false,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TermsAndConditionsScreenArgs>(
          orElse: () => const TermsAndConditionsScreenArgs());
      return _i122.TermsAndConditionsScreen(
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

  final _i137.Key? key;

  final bool isFromSplash;

  final bool isFromRegister;

  @override
  String toString() {
    return 'TermsAndConditionsScreenArgs{key: $key, isFromSplash: $isFromSplash, isFromRegister: $isFromRegister}';
  }
}

/// generated route for
/// [_i123.TotalPraposalView]
class TotalPraposalView extends _i136.PageRouteInfo<TotalPraposalViewArgs> {
  TotalPraposalView({
    _i137.Key? key,
    required int postId,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          TotalPraposalView.name,
          args: TotalPraposalViewArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'TotalPraposalView';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TotalPraposalViewArgs>();
      return _i123.TotalPraposalView(
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

  final _i137.Key? key;

  final int postId;

  @override
  String toString() {
    return 'TotalPraposalViewArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i124.ViewAgreedPraposal]
class ViewAgreedPraposal extends _i136.PageRouteInfo<void> {
  const ViewAgreedPraposal({List<_i136.PageRouteInfo>? children})
      : super(
          ViewAgreedPraposal.name,
          initialChildren: children,
        );

  static const String name = 'ViewAgreedPraposal';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i124.ViewAgreedPraposal();
    },
  );
}

/// generated route for
/// [_i125.ViewApplicantProfile]
class ViewApplicantProfile
    extends _i136.PageRouteInfo<ViewApplicantProfileArgs> {
  ViewApplicantProfile({
    _i137.Key? key,
    required int id,
    required int postId,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewApplicantProfileArgs>();
      return _i125.ViewApplicantProfile(
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

  final _i137.Key? key;

  final int id;

  final int postId;

  @override
  String toString() {
    return 'ViewApplicantProfileArgs{key: $key, id: $id, postId: $postId}';
  }
}

/// generated route for
/// [_i126.ViewCollegueProfile]
class ViewCollegueProfile extends _i136.PageRouteInfo<ViewCollegueProfileArgs> {
  ViewCollegueProfile({
    _i137.Key? key,
    required int id,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          ViewCollegueProfile.name,
          args: ViewCollegueProfileArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewCollegueProfile';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewCollegueProfileArgs>();
      return _i126.ViewCollegueProfile(
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

  final _i137.Key? key;

  final int id;

  @override
  String toString() {
    return 'ViewCollegueProfileArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i127.ViewContractorShift]
class ViewContractorShift extends _i136.PageRouteInfo<ViewContractorShiftArgs> {
  ViewContractorShift({
    _i137.Key? key,
    required int postId,
    bool isTotalApplicants = false,
    bool fromDashboard = false,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewContractorShiftArgs>();
      return _i127.ViewContractorShift(
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

  final _i137.Key? key;

  final int postId;

  final bool isTotalApplicants;

  final bool fromDashboard;

  @override
  String toString() {
    return 'ViewContractorShiftArgs{key: $key, postId: $postId, isTotalApplicants: $isTotalApplicants, fromDashboard: $fromDashboard}';
  }
}

/// generated route for
/// [_i128.ViewContractorShiftDates]
class ViewContractorShiftDates
    extends _i136.PageRouteInfo<ViewContractorShiftDatesArgs> {
  ViewContractorShiftDates({
    _i137.Key? key,
    required _i153.ContactorDashboardDTO shiftDetail,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          ViewContractorShiftDates.name,
          args: ViewContractorShiftDatesArgs(
            key: key,
            shiftDetail: shiftDetail,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewContractorShiftDates';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewContractorShiftDatesArgs>();
      return _i128.ViewContractorShiftDates(
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

  final _i137.Key? key;

  final _i153.ContactorDashboardDTO shiftDetail;

  @override
  String toString() {
    return 'ViewContractorShiftDatesArgs{key: $key, shiftDetail: $shiftDetail}';
  }
}

/// generated route for
/// [_i129.ViewDates]
class ViewDates extends _i136.PageRouteInfo<ViewDatesArgs> {
  ViewDates({
    _i137.Key? key,
    required _i154.ShiftDetailDTO shiftDetail,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          ViewDates.name,
          args: ViewDatesArgs(
            key: key,
            shiftDetail: shiftDetail,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewDates';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewDatesArgs>();
      return _i129.ViewDates(
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

  final _i137.Key? key;

  final _i154.ShiftDetailDTO shiftDetail;

  @override
  String toString() {
    return 'ViewDatesArgs{key: $key, shiftDetail: $shiftDetail}';
  }
}

/// generated route for
/// [_i130.ViewFilledShiftsDates]
class ViewFilledShiftsDates extends _i136.PageRouteInfo<void> {
  const ViewFilledShiftsDates({List<_i136.PageRouteInfo>? children})
      : super(
          ViewFilledShiftsDates.name,
          initialChildren: children,
        );

  static const String name = 'ViewFilledShiftsDates';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i130.ViewFilledShiftsDates();
    },
  );
}

/// generated route for
/// [_i131.ViewFilledShiftsDetails]
class ViewFilledShiftsDetails extends _i136.PageRouteInfo<void> {
  const ViewFilledShiftsDetails({List<_i136.PageRouteInfo>? children})
      : super(
          ViewFilledShiftsDetails.name,
          initialChildren: children,
        );

  static const String name = 'ViewFilledShiftsDetails';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      return const _i131.ViewFilledShiftsDetails();
    },
  );
}

/// generated route for
/// [_i132.ViewHomeShiftDetails]
class ViewHomeShiftDetails
    extends _i136.PageRouteInfo<ViewHomeShiftDetailsArgs> {
  ViewHomeShiftDetails({
    _i137.Key? key,
    required int postId,
    _i155.ShiftDetailRoute? route,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewHomeShiftDetailsArgs>();
      return _i132.ViewHomeShiftDetails(
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

  final _i137.Key? key;

  final int postId;

  final _i155.ShiftDetailRoute? route;

  @override
  String toString() {
    return 'ViewHomeShiftDetailsArgs{key: $key, postId: $postId, route: $route}';
  }
}

/// generated route for
/// [_i133.ViewPersonPraposalView]
class ViewPersonPraposalView
    extends _i136.PageRouteInfo<ViewPersonPraposalViewArgs> {
  ViewPersonPraposalView({
    _i137.Key? key,
    required int postId,
    required int userId,
    required _i147.EmployerProposalPendingUserDto user,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewPersonPraposalViewArgs>();
      return _i133.ViewPersonPraposalView(
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

  final _i137.Key? key;

  final int postId;

  final int userId;

  final _i147.EmployerProposalPendingUserDto user;

  @override
  String toString() {
    return 'ViewPersonPraposalViewArgs{key: $key, postId: $postId, userId: $userId, user: $user}';
  }
}

/// generated route for
/// [_i134.ViewSingleApplicants]
class ViewSingleApplicants
    extends _i136.PageRouteInfo<ViewSingleApplicantsArgs> {
  ViewSingleApplicants({
    _i137.Key? key,
    required int postId,
    List<_i136.PageRouteInfo>? children,
  }) : super(
          ViewSingleApplicants.name,
          args: ViewSingleApplicantsArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewSingleApplicants';

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewSingleApplicantsArgs>();
      return _i134.ViewSingleApplicants(
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

  final _i137.Key? key;

  final int postId;

  @override
  String toString() {
    return 'ViewSingleApplicantsArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i135.ViewUpcomingShiftDetails]
class ViewUpcomingShiftDetails
    extends _i136.PageRouteInfo<ViewUpcomingShiftDetailsArgs> {
  ViewUpcomingShiftDetails({
    _i137.Key? key,
    required int postId,
    bool isTotalApplicants = false,
    List<_i136.PageRouteInfo>? children,
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

  static _i136.PageInfo page = _i136.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewUpcomingShiftDetailsArgs>();
      return _i135.ViewUpcomingShiftDetails(
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

  final _i137.Key? key;

  final int postId;

  final bool isTotalApplicants;

  @override
  String toString() {
    return 'ViewUpcomingShiftDetailsArgs{key: $key, postId: $postId, isTotalApplicants: $isTotalApplicants}';
  }
}
