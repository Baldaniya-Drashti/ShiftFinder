// ignore_for_file: prefer_const_constructors

import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/onboarding_model/onboarding_dto.dart';

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

  static List<SkillDTO> govermentIdList = [
    SkillDTO(id: 1, name: "Driver’s License"),
    SkillDTO(id: 2, name: "Health Card"),
    SkillDTO(id: 3, name: "Citizenship Card "),
    SkillDTO(id: 4, name: "Citizenship Certificate"),
    SkillDTO(id: 5, name: "PR Card"),
    SkillDTO(id: 6, name: "Passport"),
  ];

  static List<SkillDTO> addressProofList = [
    SkillDTO(
      id: 1,
      name: "Driver’s License",
      short_name: "",
    ),
    SkillDTO(
      id: 2,
      name: "Utility Bill",
      short_name: "No more than 3 months old",
    ),
    SkillDTO(
      id: 3,
      name: "Bank Statement",
      short_name: "No more than 3 months old",
    ),
    SkillDTO(
      id: 4,
      name: "Pay Slip",
      short_name: "No more than 3 months old",
    ),
    SkillDTO(
      id: 5,
      name: "Home Insurance Certificate",
      short_name: "No more than 1 year old",
    ),
    SkillDTO(
      id: 6,
      name: "Car Insurance Certificate",
      short_name: "No more than 1 year old",
    ),
    SkillDTO(
      id: 7,
      name: "Municipal Tax Bill",
      short_name: "No more than 1 year old",
    ),
  ];

  static List<SkillDTO> cancelSortingList = [
    SkillDTO(id: 1, name: StringConstant.cancelledByYou),
    SkillDTO(id: 2, name: StringConstant.withdrawnByContractor),
  ];
}
