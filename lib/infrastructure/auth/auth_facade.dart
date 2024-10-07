// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:logger/web.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/domain/core/api_constants.dart';
import 'package:shift/infrastructure/account/account_entity.dart';
import 'package:shift/infrastructure/account/current_user_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/network/hive_box_names.dart';
import 'package:shift/infrastructure/core/network/injectable_module.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/core/speciality/speciality_dto.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthFacade)
class AuthFacade implements IAuthFacade {
  var logger = Logger();

  final ApiService apiService;

  AuthFacade(this.apiService);

  @override
  Future<Either<AuthFailure, Unit>> changePassword(
      {required Password oldPassword, required Password newPassword, required Password confirmNewPassword}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> checkAuthenticated() async {
    log('getUserToken() : ${getUserToken()}');
    // getCookie returns null as a String, so it has to be checked like this.
    return getUserToken() != null;
  }

  @override
  Future<bool> checkUserVerified() async {
    log('getUserVerified() : ${getCurrentUser().isVerified}');
    // getCookie returns null as a String, so it has to be checked like this.
    return getCurrentUser().isVerified == 1;
  }

  @override
  Future<Either<AuthFailure, Account>> login({
    required EmailAddress email,
    required Password password,
  }) async {
    try {
      final response = await apiService.postMethod(
        ApiConstants.login,
        {
          "email": email.getOrCrash(),
          "password": password.getOrCrash(),
          "service_roles": getCurrentRole(),
          "industry_id": getCurrentIndustry(),
        },
      );

      final account = CurrentUserDto.fromJson(response.data).toDomain();
      // logger.d("RESPONSE OF LOGIN---> ${response.data}");
      setUserToken(account.auth?.accessToken ?? "");
      setCurrentUser(account);
      return right(account);
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AuthFailure.networkError());
      }

      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, String>> logout() async {
    try {
      return apiService
          .getMethod(
        ApiConstants.logout,
      )
          .then((value) async {
        final currentRole = getCurrentRole();
        final currentIndustry = getCurrentIndustry();
        final isUserShowIntro = getUserShowIntro();

        print("getCurrent isUserShowIntro----> $isUserShowIntro");

        Hive.box(BoxNames.settingsBox).clear();
        Hive.box<AccountEntity>(BoxNames.currentUser).clear();

        /// Set Intro screen Data
        await Hive.box(BoxNames.settingsBox).put(BoxKeys.isUserShowIntro, isUserShowIntro);
        await Hive.box(BoxNames.settingsBox).put(BoxKeys.currentRole, currentRole);
        await Hive.box(BoxNames.settingsBox).put(BoxKeys.currentIndustry, currentIndustry);

        return right(value?.dioMessage ?? "");
      });
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      }

      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, String>> register({
    required Username firstName,
    required Username lastName,
    required int check_terms_privacy,
    required String? companyName,
    required String countryCode,
    required String countryFlag,
    required MobileNumber phoneNumber,
    required EmailAddress email,
    required Password password,
    required ConfirmPassword confirmPassword,
    required String profileImage,

    /// if current user is employer
    required String? association,
    required String? companyDescription,

    /// if current user is contractor
    required String? referralCode,
    required String? locationAddress,
  }) async {
    try {
      var formData = FormData.fromMap({
        "service_roles": getCurrentRole(),
        "industry_id": getCurrentIndustry(),
        "country_code": countryCode,
        "country_name_code": countryFlag,
        "first_name": firstName.getOrCrash(),
        "last_name": lastName.getOrCrash(),
        "check_terms_privacy": check_terms_privacy,
        "email": email.getOrCrash(),
        "password": password.getOrCrash(),
        "password_confirmation": confirmPassword.getOrCrash(),
        "company_name": companyName,
        "phone": phoneNumber.getOrCrash(),
        "association_you_belong_to": association,
        "company_description": companyDescription,
        "location": locationAddress,
        "referral_code": referralCode,
        "last_page": "Login",
      });
      // var formData = FormData.fromMap({
      //   "service_roles": 2,
      //   "industry_id": 2,
      //   "country_code": "",
      //   "first_name": "karan",
      //   "last_name": "gajjar",
      //   "check_terms_privacy": 1,
      //   "email": "karan2@mailinator.com",
      //   "password": "12345678",
      //   "password_confirmation": "12345678",
      //   "company_name": "iroid",
      //   "phone": "1234567895",
      //   "association_you_belong_to": "",
      //   "company_description": "",
      //   "location": "",
      //   "referral_code": "",
      //   "last_page": 1,
      // });

      // logger.d('formData: ${jsonEncode(formData)}');

      // logger.d('formData : ${formData.fields.map((e) => e)}');
      // log('role : ${getCurrentRole()} \n ${getCurrentIndustry()}');
      // log('');

      if (profileImage.isNotEmpty) {
        var multipartFile = await MultipartFile.fromFile(
          profileImage,
          filename: 'profile.png',
          headers: {
            'contentType': ['image/png'],
          },
        );
        formData.files.add(MapEntry('profile', multipartFile));
      }

      // print('formData after add image: ${formData.fields.map((e) => e)}');

      final response = await apiService.postMethod(
        ApiConstants.register,
        {},
        formData: formData,
        isMultipart: true,
      );
      logger.d("RESPONSE OF REGISTER---> ${response.data}");

      final account = CurrentUserDto.fromJson(response.data).toDomain();
      setCurrentUser(account);
      return right(response.dioMessage ?? "");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);
        if (commonRespose.dioMessage != null) {
          return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      }

      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, String>> editEmailOrPhone({
    String? email,
    String? countryCode,
    String? countryNameCode,
    String? phone,
  }) async {
    try {
      var mapData = {
        "id": getCurrentUser().userId,
        // "id": 313,
        "email": email,
        "country_code": countryCode?.replaceAll('+', ''),
        "country_name_code": countryNameCode,
        "phone": phone,
      };
      print("get currentUser id ---> ${getCurrentUser().userId}");

      final response = await apiService.postMethod(
        ApiConstants.editEmailOrPhone,
        mapData,
      );
      print("RESPONSE OF EDIT PHONE---> ${response.data}");

      final account = CurrentUserDto.fromJson(response.data).toDomain();
      setCurrentUser(account);
      return right(response.dioMessage ?? "");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);
        if (commonRespose.dioMessage != null) {
          return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      }

      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> registerForPush({required String fcmToken}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, String>> verifyOtp({
    required String emailAddress,
    required String phoneNumber,
    required OTPText otp,
    bool isForgotPassword = false,
  }) async {
    try {
      final mapData = {
        "otp": otp.getOrCrash(),
        "phone": phoneNumber,
        "service_roles": getCurrentRole(),
        "last_page": (isForgotPassword == true)
            ? "Login"
            : (getCurrentRole() == 1)
                ? "ContractorSkill"
                : "EmployerLocation",
      };
      if (emailAddress.isNotEmpty) {
        mapData["email"] = emailAddress;
      }

      print("Sending Data--->  ${jsonEncode(mapData)}");
      final response = await apiService.postMethod(ApiConstants.verifyOtp, mapData);

      final account = CurrentUserDto.fromJson(response.data).toDomain();
      setUserToken(account.auth?.accessToken ?? "");
      setCurrentUser(account);
      return right(response.dioMessage ?? "");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      }

      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, String>> resendOtp({
    required String emailAddress,
    required String phoneNumber,
    bool forgotPassword = false,
  }) async {
    try {
      var mapData = {"email": emailAddress, "phone": phoneNumber, "service_roles": getCurrentRole()};

      if (forgotPassword == true) {
        mapData.addAll({
          "is_forgot_password": 1,
        });
      }

      print("Sending Data---> ${jsonEncode(mapData)}");

      final response = await apiService.postMethod(ApiConstants.resendOtp, mapData);

      final account = CurrentUserDto.fromJson(response.data).toDomain();
      if (forgotPassword != true) {
        setUserToken(account.auth?.accessToken ?? "");
        setCurrentUser(account);
      }
      return right(response.dioMessage ?? "");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      }

      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, String>> forgotPassword({
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final mapData = {
        "password": password,
        "password_confirmation": confirmPassword,
      };

      final response = await apiService.postMethod(ApiConstants.forgotPassword, mapData);

      return right(response.dioMessage ?? "");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);
        if (commonRespose.dioMessage != null) {
          return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      }
      return left(const AuthFailure.serverError());
    }
  }

  /// ROLE LIST
  @override
  Future<Either<AuthFailure, List<SkillDTO>>> getRoleList() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.roleList,
      );

      if (response != null) {
        var account = response.data as List<dynamic>;
        var list = account.map((e) => SkillDTO.fromJson(e)).toList();

        logger.d("ROLE LIST RESPONSE---> $list");
        return right(list);
        // final list = SkillListDTO.fromJson(response.data);

        // logger.d("ROLE LIST RESPONSE---> ${account.data}");
        // return right(account);
      } else {
        return left(const AuthFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AuthFailure.networkError());
      }

      return left(const AuthFailure.serverError());
    }
  }

  /// SPECIALITY LIST
  @override
  Future<Either<AuthFailure, List<SpecialityDTO>>> getSpecialityList() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.specialtieList,
      );

      if (response != null) {
        var account = response.data as List<dynamic>;
        var list = account.map((e) => SpecialityDTO.fromJson(e)).toList();

        logger.d("SPECIALITY LIST RESPONSE---> $list");
        return right(list);
      } else {
        return left(const AuthFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AuthFailure.networkError());
      }

      return left(const AuthFailure.serverError());
    }
  }

  /// EXPERIENCE LIST
  @override
  Future<Either<AuthFailure, List<SkillDTO>>> getExperienceList() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.experienceList,
      );

      if (response != null) {
        var account = response.data as List<dynamic>;
        var list = account.map((e) => SkillDTO.fromJson(e)).toList();

        logger.d("EXPERIENCE LIST RESPONSE---> $list");
        return right(list);
      } else {
        return left(const AuthFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AuthFailure.networkError());
      }

      return left(const AuthFailure.serverError());
    }
  }

  /// SOFTWARE SKILL LIST
  @override
  Future<Either<AuthFailure, List<SkillDTO>>> getSoftwareSkillList() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.softwaresSkillList,
      );

      if (response != null) {
        var account = response.data as List<dynamic>;
        var list = account.map((e) => SkillDTO.fromJson(e)).toList();

        logger.d("SOFTWARE LIST RESPONSE---> $list");
        return right(list);
      } else {
        return left(const AuthFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AuthFailure.networkError());
      }

      return left(const AuthFailure.serverError());
    }
  }

  /// LANGUAGE LIST
  @override
  Future<Either<AuthFailure, List<SkillDTO>>> getLanguageList() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.languageList,
      );

      if (response != null) {
        var account = response.data as List<dynamic>;
        var list = account.map((e) => SkillDTO.fromJson(e)).toList();

        logger.d("LANGUAGE LIST RESPONSE---> $list");
        return right(list);
      } else {
        return left(const AuthFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AuthFailure.networkError());
      }

      return left(const AuthFailure.serverError());
    }
  }

  /// COMPLETE PROFILE
  @override
  Future<Either<AuthFailure, String>> completeProfileAPI({
    required String? languageOther,
    required String languageListId,
    required String softwareSkillOther,
    required String softwaresSkillListId,
    required String specialtiesDetail,
    required String specialityOther,
    required String rolesListId,
  }) async {
    try {
      final mapData = {
        "roles_list_id": rolesListId,
        "specialties_list_id": specialtiesDetail,
        "specialties_other": specialityOther,
        "softwares_skill_list_id": softwaresSkillListId,
        "software_skill_other": softwareSkillOther,
        "languages_list_id": languageListId,
        "language_other": languageOther,
        "last_page": "Experience",
      };

      print("Sending Params:---> ${jsonEncode(mapData)}");
      final response = await apiService.postMethod(ApiConstants.completeProfile, mapData);
      logger.d("RESPONSE OF COMPLETE PROFILE---> ${jsonEncode(response.data)}");

      return right(response.dioMessage ?? "");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AuthFailure.networkError());
      }

      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, String>> addEducationApi({
    required InputEmptyOrNot programCompleted,
    required InputEmptyOrNot yearOfCompletion,
    required InputEmptyOrNot graduatingInstitution,
  }) async {
    try {
      final mapData = {
        "program_completed": programCompleted.getOrCrash(),
        "year_of_completion": yearOfCompletion.getOrCrash(),
        "graduating_institution": graduatingInstitution.getOrCrash(),
        "last_page": "Education",
      };

      print("Sending Params:---> ${jsonEncode(mapData)}");
      final response = await apiService.postMethod(ApiConstants.education, mapData);
      logger.d("Response of Add Education---> ${jsonEncode(response.data)}");

      return right(response.dioMessage ?? "");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AuthFailure.networkError());
      }

      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Account>> addLastPageApi({
    required String lastPage,
  }) async {
    try {
      final response = await apiService.postMethod(
        ApiConstants.editLastPage,
        {"last_page": lastPage},
      );

      final account = CurrentUserDto.fromJson(response.data).toDomain();
      logger.d("RESPONSE OF LAST PAGE---> ${response.data}");

      return right(account);
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AuthFailure.networkError());
      }

      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, String>> editEmployerProfile({required Map<String, dynamic> data}) async {
    try {
      final response = await apiService.postMethod(ApiConstants.editLastPage, FormData.fromMap(data));

      final account = CurrentUserDto.fromJson(response.data).toDomain();
      logger.d("RESPONSE OF LAST PAGE---> ${response.data}");

      return right("");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AuthFailure.networkError());
      }

      return left(const AuthFailure.serverError());
    }
  }

// @override
// Future<Either<AuthFailure, String>> editEmployerProfile({required Map<String, dynamic> data}) async {
//
//   try {
//     final response = await apiService.postMethod(
//       ApiConstants.editProfile,
//       FormData.fromMap(data)
//
//     );
//
//     // final account = CurrentUserDto.fromJson(response.data).toDomain();
//     // logger.d("RESPONSE OF LAST PAGE---> ${response.data}");
//     //
//     // return right(account);
//     return right(response.data);
//   } on DioException catch (err) {
//     if (err.response != null) {
//       var commonRespose = CommonResponse.fromJson(err.response?.data);
//
//       if (commonRespose.dioMessage != null) {
//         return left(AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//       }
//     } else if (err.type == DioExceptionType.connectionError) {
//       return left(const AuthFailure.networkError());
//     }
//
//     return left(const AuthFailure.serverError());
//   }
// }

// @override
// Future<Either<AuthFailure, String>> deleteEducationApi({
//   required int educationId,
// }) async {
//   try {
//     final mapData = {
//       "id": educationId,
//     };

//     print("Sending Params:---> ${jsonEncode(mapData)}");

//     final response = await apiService
//         .deleteMethod('${ApiConstants.destroyEducation}?id=$educationId');

//     if (response != null && response.data != null) {
//       // final account = CurrentUserDto.fromJson(response.data).toDomain();
//       print("Response:---> ${response.dioMessage}");

//       return right(response.dioMessage ?? "");
//     } else {
//       return left(const AuthFailure.serverError());
//     }
//   } on DioException catch (err) {
//     if (err.response != null) {
//       var commonRespose = CommonResponse.fromJson(err.response?.data);

//       if (commonRespose.dioMessage != null) {
//         return left(
//             AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//       }
//     } else if (err.type == DioExceptionType.connectionError) {
//       return left(const AuthFailure.networkError());
//     }

//     return left(const AuthFailure.serverError());
//   }
// }

// @override
// Future<Either<AuthFailure, String>> login({
//   required String countryCode,
//   required EmailAddress mobileNumber,
// }) async {
//   try {
//     final response = await apiService.postMethod(
//       ApiConstants.login,
//       {
//         "role": 2,
//         "country_code": countryCode,
//         "mobile": "9664620465",
//       },
//     );

//     final account = CurrentUserDto.fromJson(response.data).toDomain();
//     setRememberToken(account.rememberToken ?? "");
//     _setUserData(account);
//     return right(response.dioMessage ?? "");
//   } on DioException catch (err) {
//     if (err.response != null) {
//       var commonRespose = CommonResponse.fromJson(err.response?.data);
//       if (commonRespose.dioMessage != null) {
//         return left(
//             AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//       }
//     } else if (err.type == DioExceptionType.connectionError) {
//       return left(const AuthFailure.networkError());
//     }
//     return left(const AuthFailure.serverError());
//   }
// }
}
