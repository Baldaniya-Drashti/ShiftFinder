import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
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
      title: "Health Service \nFacilities\n",
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

  // static List<ListDTO> languageList = [
  //   ListDTO(id: 1, title: "English"),
  //   ListDTO(id: 2, title: "Hindi"),
  //   ListDTO(id: 3, title: "Gujrati"),
  //   ListDTO(id: 4, title: "Punjabi"),
  //   ListDTO(id: 5, title: "Marathi"),
  //   ListDTO(id: 6, title: "Italian"),
  //   ListDTO(id: 7, title: "Japanese"),
  //   ListDTO(id: 8, title: "Kannada"),
  //   ListDTO(id: 9, title: "Mandarin"),
  //   ListDTO(id: 10, title: "Persian"),
  //   ListDTO(id: 11, title: "Spanish"),
  //   ListDTO(id: 12, title: "Tamil"),
  //   ListDTO(id: 13, title: "Other"),
  // ];
}
