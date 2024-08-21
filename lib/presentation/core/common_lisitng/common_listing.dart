// ignore_for_file: prefer_const_constructors

import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/onboarding_model/onboarding_dto.dart';
import 'package:shift/presentation/contractor_earning/contractor_statement_view.dart';
import 'package:shift/presentation/contractor_earning/contractor_wallet_view.dart';

class CommonList {
  static List<OnBoardingDTO> userList = [
    OnBoardingDTO(
      id: 1,
      title: "Health Service\nProfessional\n",
      description: "Contractor",
      image: PngImageConstants.doctors,
      backgroundImage: SvgImageConstant.personSetting,
    ),
    OnBoardingDTO(
      id: 2,
      title: "Healt Service \nFacilities\n",
      description: "Employer",
      image: PngImageConstants.patient,
      backgroundImage: SvgImageConstant.nurse,
    ),
  ];

  static List<OnBoardingDTO> industryList = [
    OnBoardingDTO(
      id: 1,
      title: "Healthcare",
      description: "",
      image: SvgImageConstant.heart,
      backgroundImage: "",
    ),
    OnBoardingDTO(
      id: 2,
      title: "Pharmacy",
      description: "",
      image: SvgImageConstant.medicine,
      backgroundImage: "",
    ),
    OnBoardingDTO(
      id: 3,
      title: "Dental",
      description: "",
      image: SvgImageConstant.teeth,
      backgroundImage: "",
    ),
    OnBoardingDTO(
      id: 4,
      title: "Hospitality",
      description: "",
      image: SvgImageConstant.nurseGreen,
      backgroundImage: "",
    ),
    OnBoardingDTO(
      id: 5,
      title: "Ophthalmology",
      description: "",
      image: SvgImageConstant.eye,
      backgroundImage: "",
    ),
  ];

  static List<String> yearList = [
    "-",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
    "32",
    "33",
    "34",
    "35",
    "36",
    "37",
    "38",
    "39",
    "40",
    "41",
    "42",
    "43",
    "44",
    "45",
    "46",
    "47",
    "48",
    "49",
    "50"
  ];

  static List<String> monthList = [
    "-",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12"
  ];

  static List<String> hourList = [
    '01 AM',
    '02 AM',
    '03 AM',
    '04 AM',
    '05 AM',
    '06 AM',
    '07 AM',
    '08 AM',
    '09 AM',
    '10 AM',
    '11 AM',
    '12 AM',
    '01 PM',
    '02 PM',
    '03 PM',
    '04 PM',
    '05 PM',
    '06 PM',
    '07 PM',
    '08 PM',
    '09 PM',
    '10 PM',
    '11 PM',
    '12 PM',
  ];

  static List<String> minutesList = ['00 Min', '15 Min', '30 Min', '45 Min'];
  static List<String> commuteAllownceList = ['None', 'Flat Rate', 'Hours'];
  static List<String> recurrenceModeList = ['Weekly'];
  static List<String> recurrenceModeOnlyDaily = ['Daily'];
  static List<SkillDTO> weekList = [
    SkillDTO(id: 0, name: "Monday"),
    SkillDTO(id: 1, name: "Tuesday"),
    SkillDTO(id: 2, name: "Wednesday"),
    SkillDTO(id: 3, name: "Thursday"),
    SkillDTO(id: 4, name: "Friday"),
    SkillDTO(id: 5, name: "Saturday"),
    SkillDTO(id: 6, name: "Sunday"),
  ];

  static List<SkillDTO> accountTypeList = [
    SkillDTO(id: 1, name: "checking"),
    SkillDTO(id: 2, name: "savings")
  ];

  static List<SkillDTO> scriptVolumeList = [
    SkillDTO(id: 1, name: "Low"),
    SkillDTO(id: 2, name: "Medium"),
    SkillDTO(id: 3, name: "High")
  ];

  static List<SkillDTO> govermentIdList = [
    SkillDTO(id: 1, name: "Driver’s License"),
    SkillDTO(id: 2, name: "Health Card"),
    SkillDTO(id: 3, name: "Citizenship Card"),
    SkillDTO(id: 4, name: "Citizenship Certificate"),
    SkillDTO(id: 5, name: "PR Card"),
    SkillDTO(id: 6, name: "Passport"),
  ];

  static List<SkillDTO> addressProofList = [
    SkillDTO(
      id: 1,
      name: "Driver’s License",
      short_name: null,
      yearLimit: "10",
      isMandatory: true,
    ),
    SkillDTO(
      id: 2,
      name: "Utility Bill",
      short_name: "No more than 3 months old",
      yearLimit: "0.3",
      isMandatory: false,
    ),
    SkillDTO(
      id: 3,
      name: "Bank Statement",
      short_name: "No more than 3 months old",
      yearLimit: "0.3",
      isMandatory: false,
    ),
    SkillDTO(
      id: 4,
      name: "Pay Slip",
      short_name: "No more than 3 months old",
      yearLimit: "0.3",
      isMandatory: false,
    ),
    SkillDTO(
      id: 5,
      name: "Home Insurance Certificate",
      short_name: "No more than 1 year old",
      yearLimit: "1",
      isMandatory: false,
    ),
    SkillDTO(
      id: 6,
      name: "Car Insurance Certificate",
      short_name: "No more than 1 year old",
      yearLimit: "1",
      isMandatory: false,
    ),
    SkillDTO(
      id: 7,
      name: "Municipal Tax Bill",
      short_name: "No more than 1 year old",
      yearLimit: "1",
      isMandatory: false,
    ),
  ];

  static List<SkillDTO> proofLegalWorkList = [
    SkillDTO(id: 1, name: "PR Card", isMandatory: true, yearLimit: '5'),
    SkillDTO(id: 2, name: "Work Permit", isMandatory: true, yearLimit: '1,2'),
    SkillDTO(id: 3, name: "Passport", isMandatory: true),
    SkillDTO(id: 4, name: "Citizenship Card", isMandatory: false),
    SkillDTO(id: 5, name: "Citizenship Certificate", isMandatory: false),
    SkillDTO(id: 6, name: "SIN Card or SIN Letter", isMandatory: false),
    SkillDTO(
        id: 7,
        name: "Certificate of Indian Status",
        isMandatory: false,
        yearLimit: '10'),
    SkillDTO(id: 8, name: "Birth Certificate", isMandatory: false),
    SkillDTO(
        id: 9, name: "Canadian Forces Identification Card", isMandatory: false),
    SkillDTO(id: 10, name: "Nexus Card", isMandatory: true, yearLimit: '5'),
  ];

  static List<SkillDTO> cancelSortingList = [
    SkillDTO(id: 1, name: StringConstant.cancelledByYou),
    SkillDTO(id: 2, name: StringConstant.withdrawnByContractor),
  ];

  static List<WalletDropdownModel> walletList = [
    WalletDropdownModel(id: 0, label: "All Transactions"),
    WalletDropdownModel(id: 1, label: "Earnings"),
    WalletDropdownModel(id: 2, label: "Compensations"),
    WalletDropdownModel(id: 3, label: "Referrals"),
    WalletDropdownModel(id: 4, label: "Deposits"),
  ];

  static List<StatementFilterModel> statementList = [
    StatementFilterModel(id: 1, label: "Shifts Earnings"),
    StatementFilterModel(id: 2, label: "Compensations"),
    StatementFilterModel(id: 3, label: "Referrals Bonus"),
    StatementFilterModel(id: 4, label: "Bank"),
  ];
}
