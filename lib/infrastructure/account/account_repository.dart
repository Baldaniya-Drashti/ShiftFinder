// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/api_constants.dart';
import 'package:shift/infrastructure/account/current_user_dto.dart';
import 'package:shift/infrastructure/auth/contractor/bank/bank_dto.dart';
import 'package:shift/infrastructure/core/document_dto/document_dto.dart';
import 'package:shift/infrastructure/core/experience_model/experience_dto.dart';
import 'package:shift/infrastructure/core/legal_screening_dto/legal_screening_dto.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/network/injectable_module.dart';
import 'package:shift/infrastructure/core/quiz_dto/quiz_dto.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import '../core/skill_list_model/skill_dto.dart';

@LazySingleton(as: IAccountRepository)
class AccountRepository extends IAccountRepository {
  final ApiService apiService;

  AccountRepository(this.apiService);

  @override
  Future<Either<AccountFailure, Account>> getCurrentUserApi() async {
    try {
      final response = await apiService.getMethod(ApiConstants.getUserInfo,
          queryParameters: {"id": getCurrentUser().userId});
      if (response != null && response.data != null) {
        final account = CurrentUserDto.fromJson(response.data).toDomain();
        setCurrentUser(account);
        return right(account);
      } else {
        return left(const AccountFailure.serverError());
      }
      //  setUserToken(account.auth?.accessToken ?? "");
      //_setUserData(account);
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);
        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      }
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, List<ExperienceDTO>>>
      getExperienceRoleList() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.getYourRolesList,
      );

      if (response != null) {
        var account = response.data as List<dynamic>;
        var list = account.map((e) => ExperienceDTO.fromJson(e)).toList();

        print("Experience Role List Response---> $list");
        return right(list);
      } else {
        return left(const AccountFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }

      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, Account>> addExperienceApi({
    required String experienceDetail,
  }) async {
    try {
      final mapData = {
        "experience_detail": experienceDetail,
        "last_page": "SpecialityExperience",
      };

      print("Sending Params:---> ${jsonEncode(mapData)}");
      final response =
          await apiService.postMethod(ApiConstants.addRoleExperience, mapData);
      print("Response of Add Experience---> ${jsonEncode(response.data)}");

      final account = CurrentUserDto.fromJson(response.data).toDomain();
      return right(account);
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, List<ExperienceDTO>>>
      getExperienceSpecialityList() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.getYourSpecialityList,
      );

      if (response != null) {
        var account = response.data as List<dynamic>;
        var list = account.map((e) => ExperienceDTO.fromJson(e)).toList();

        print("Experience Speciality List Response---> $list");
        return right(list);
      } else {
        return left(const AccountFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }

      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, Account>> addSpecialityExperienceApi({
    required String experienceDetail,
  }) async {
    try {
      final mapData = {
        "experience_detail": experienceDetail,
        "last_page": "Education",
      };

      print("Sending Params:---> ${jsonEncode(mapData)}");
      final response = await apiService.postMethod(
          ApiConstants.addSpecialityExperience, mapData);
      print(
          "Response of Add Speciality Experience---> ${jsonEncode(response.data)}");

      final account = CurrentUserDto.fromJson(response.data).toDomain();
      return right(account);
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, String>> addEducationApi({
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
      final response =
          await apiService.postMethod(ApiConstants.education, mapData);
      print("Response of Add Education---> ${jsonEncode(response.data)}");
      print("Response of Add Education---> ${response.dioMessage}");

      return right(response.dioMessage ?? "");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }

      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, String>> updateEducationApi({
    required int id,
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
      final response = await apiService.putMethod(
        '${ApiConstants.updateEducation}/$id',
        data: mapData,
      );
      if (response != null) {
        print("Response of Update Education---> ${jsonEncode(response.data)}");
        return right(response.dioMessage ?? "");
      } else {
        return left(const AccountFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }

      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, Account>> deleteEducationApi({
    required int educationId,
  }) async {
    try {
      final mapData = {
        "id": educationId,
      };

      print("Sending Params:---> ${jsonEncode(mapData)}");

      final response = await apiService
          .deleteMethod('${ApiConstants.destroyEducation}?id=$educationId');

      if (response != null && response.data != null) {
        final account = CurrentUserDto.fromJson(response.data).toDomain();
        return right(account);
      } else {
        return left(const AccountFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }

      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, Account>> addReferenceApi({
    required int type,
    required String? jobPosition,
    required String? organization,
    required String? referrer,
    required String email,
    required String countryCode,
    required String countryFlag,
    required String phone,
    String? jobLatitude,
    String? jobLongitude,
    required String? jobLocation,
    required String? unit,
    required String? startDate,
    required String? endDate,
    required String? contactPerson,
    required String? professionReferrer,
  }) async {
    try {
      final mapData = {
        "type": type,
        "email": email,
        "country_code": countryCode,
        "country_name_code": countryFlag,
        "phone": phone,
        "last_page": "Reference",
      };

      if (type == 1) {
        mapData.addAll({
          "job_position": jobPosition ?? "",
          "organization": organization ?? "",
          "referrer": referrer ?? "",
          "job_location": jobLocation ?? "",
          "unit": unit ?? "",
          "start_date": (startDate != null && startDate.isNotEmpty)
              ? (DateTime.parse(startDate).toUtc().millisecondsSinceEpoch /
                      1000)
                  .toString()
              : "",
          "end_date": (endDate != null && endDate.isNotEmpty)
              ? (DateTime.parse(endDate).toUtc().millisecondsSinceEpoch / 1000)
                  .toString()
              : "",
        });
      }
      if (type == 2) {
        mapData.addAll({
          "contact_person": contactPerson ?? "",
          "profession_referrer": professionReferrer ?? "",
        });
      }

      print("Sending Params:---> ${jsonEncode(mapData)}");
      final response =
          await apiService.postMethod(ApiConstants.reference, mapData);
      print("Response of Add Reference---> ${jsonEncode(response.data)}");

      final account = CurrentUserDto.fromJson(response.data).toDomain();
      return right(account);
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, Account>> updateReferenceApi({
    required int id,
    required int type,
    required String? jobPosition,
    required String? organization,
    required String? referrer,
    required String email,
    required String countryCode,
    required String countryFlag,
    required String phone,
    String? jobLatitude,
    String? jobLongitude,
    required String? jobLocation,
    required String? unit,
    required String? startDate,
    required String? endDate,
    required String? contactPerson,
    required String? professionReferrer,
  }) async {
    try {
      final mapData = {
        "type": type,
        "email": email,
        "country_code": countryCode,
        "country_name_code": countryFlag,
        "phone": phone,
        "last_page": "Reference",
      };

      if (type == 1) {
        mapData.addAll({
          "job_position": jobPosition ?? "",
          "organization": organization ?? "",
          "referrer": referrer ?? "",
          "job_location": jobLocation ?? "",
          "unit": unit ?? "",
          "start_date": (startDate != null && startDate.isNotEmpty)
              ? (DateTime.parse(startDate).toUtc().millisecondsSinceEpoch /
                      1000)
                  .toString()
              : "",
          "end_date": (endDate != null && endDate.isNotEmpty)
              ? (DateTime.parse(endDate).toUtc().millisecondsSinceEpoch / 1000)
                  .toString()
              : "",
        });
      }
      if (type == 2) {
        mapData.addAll({
          "contact_person": contactPerson ?? "",
          "profession_referrer": professionReferrer ?? "",
        });
      }

      print("Sending Params:---> ${jsonEncode(mapData)}");
      final response = await apiService.putMethod(
        '${ApiConstants.updateReference}/$id',
        data: mapData,
      );

      if (response != null) {
        print("Response of Update Reference---> ${jsonEncode(response.data)}");

        final account = CurrentUserDto.fromJson(response.data).toDomain();
        return right(account);
      } else {
        return left(const AccountFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, Account>> deleteReferenceApi({
    required int referenceId,
  }) async {
    try {
      final mapData = {
        "id": referenceId,
      };

      print("Sending Params:---> ${jsonEncode(mapData)}");

      final response = await apiService
          .deleteMethod('${ApiConstants.destroyReference}?id=$referenceId');

      if (response != null && response.data != null) {
        final account = CurrentUserDto.fromJson(response.data).toDomain();
        return right(account);
      } else {
        return left(const AccountFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }

      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, List<DocumentDTO>>> getDocumentApi({
    required int? documentType,
  }) async {
    try {
      print("Sending Params:---> $documentType");

      final response = await apiService.getMethod(
        (documentType != null)
            ? "${ApiConstants.getDocument}?document_type=$documentType"
            : ApiConstants.getDocument,
      );

      if (response != null && response.data != null) {
        print("Response of Get Document---> ${jsonEncode(response.data)}");

        var account = response.data as List<dynamic>;
        var list = account.map((e) => DocumentDTO.fromJson(e)).toList();
        return right(list);
      } else {
        return left(const AccountFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      print("ERRORRRRRR----->  $e");
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, String>> addDocumentApi({
    required int documentType,
    int? subType,
    required String documentFile,
    String? documentBackFile,
    String? expiryDate,
    bool? expiryDateNotApplicable,
    String? registrationNumber,
    String? provinceOfRegistration,
    String? documentTitle,
    String? nameOfVaccinations,
    String? lastPage,
  }) async {
    try {
      print("expiry dat---> $expiryDate");
      print(
          "expiry date after timestamp---> ${DateTime.now().millisecondsSinceEpoch}");

      var formData = FormData.fromMap({
        "document_type": documentType,
        "sub_type": subType,
        "expiry_date": (expiryDate != null && expiryDate.isNotEmpty)
            ? (DateTime.parse(expiryDate).toUtc().millisecondsSinceEpoch / 1000)
                .toString()
            : "",
        "expiry_date_not_applicable": (expiryDateNotApplicable == true) ? 1 : 0,
        "registration_number": registrationNumber,
        "province_of_registration": provinceOfRegistration,
        "document_title": documentTitle,
        "name_of_vaccinations": nameOfVaccinations,
        "last_page": lastPage ?? "Document",
      });
      if (documentFile.isNotEmpty && !documentFile.contains('http')) {
        var multipartFile = await MultipartFile.fromFile(
          documentFile,
        );
        formData.files.add(MapEntry('file', multipartFile));
      }
      if (documentBackFile != null &&
          documentBackFile.isNotEmpty &&
          !documentBackFile.contains('http')) {
        var multipartFile = await MultipartFile.fromFile(
          documentBackFile,
        );
        formData.files.add(MapEntry('back_file', multipartFile));
      }

      print('Sending Data: ${formData.fields.map((e) => e)}');

      final response = await apiService.postMethod(
        ApiConstants.document,
        {},
        formData: formData,
        isMultipart: true,
      );

      print("Response of Add Document---> ${jsonEncode(response.data)}");

      // var account = response.data as List<dynamic>;
      // var list = account.map((e) => DocumentDTO.fromJson(e)).toList();
      return right(response.dioMessage ?? "");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      print("CATCH ERRO---> ${e}");
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, String>> addAddressProofApi({
    required int documentType,
    int? subType,
    required String documentFile,
    String? documentBackFile,
    String? expiryDate,
    bool? expiryDateNotApplicable,
    String? lastPage,
  }) async {
    try {
      print("expiry dat---> $expiryDate");
      print(
          "expiry date after timestamp---> ${DateTime.now().millisecondsSinceEpoch}");

      var formData = FormData.fromMap({
        "document_type": documentType,
        "sub_type": subType,
        if (expiryDate != null && expiryDate.isNotEmpty)
          "expiry_date":
              (DateTime.parse(expiryDate).toUtc().millisecondsSinceEpoch / 1000)
                  .toString(),
        // "expiry_date_not_applicable": (expiryDateNotApplicable == true) ? 1 : 0,
        "last_page": lastPage ?? "AddressProofScreen",
      });
      if (documentFile.isNotEmpty && !documentFile.contains('http')) {
        var multipartFile = await MultipartFile.fromFile(
          documentFile,
        );
        formData.files.add(MapEntry('file', multipartFile));
      }
      if (documentBackFile != null &&
          documentBackFile.isNotEmpty &&
          !documentBackFile.contains('http')) {
        var multipartFile = await MultipartFile.fromFile(
          documentBackFile,
        );
        formData.files.add(MapEntry('back_file', multipartFile));
      }

      print('Sending Data: ${formData.fields.map((e) => e)}');

      final response = await apiService.postMethod(
        ApiConstants.stripeDocument,
        {},
        formData: formData,
        isMultipart: true,
      );

      print("Response of Add Address proof---> ${jsonEncode(response.data)}");

      // var account = response.data as List<dynamic>;
      // var list = account.map((e) => DocumentDTO.fromJson(e)).toList();
      return right(response.dioMessage ?? "");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, String>> addBankDetail({
    required String bankName,
    required String jobTitle,
    required String accountNumber,
    required String transitNumber,
    required String institutionNumber,
    required String accountType,
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String bankAddress,
    required String city,
    required String state,
    required String postalCode,
    required String countryFlag,
    required String countryCode,
    required String phone,
    String? lastPage,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        'bank_name': bankName,
        'job_title': jobTitle,
        'account_number': accountNumber,
        'transit_number': transitNumber,
        'institution_number': institutionNumber,
        'account_type': accountType,
        'first_name': firstName,
        'last_name': lastName,
        'dob': dateOfBirth,
        'bank_address': bankAddress,
        'city': city,
        'state': state,
        'postal_code': postalCode,
        'country_name_code': countryFlag,
        'country_code': countryCode,
        'phone': phone,
        if (lastPage != null) 'last_page': lastPage,
      };

      print('Sending Data: ${jsonEncode(mapData)}');

      final response = await apiService.postMethod(
        ApiConstants.contractorConnectAccount,
        mapData,
      );

      print("Response of Add Bank Detail---> ${jsonEncode(response.data)}");

      return right(response.dioMessage ?? "");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, String>> updateDocumentApi({
    required int id,
    required int documentType,
    int? subType,
    required String documentFile,
    String? documentBackFile,
    String? expiryDate,
    bool? expiryDateNotApplicable,
    String? registrationNumber,
    String? provinceOfRegistration,
    String? documentTitle,
    String? nameOfVaccinations,
    String? lastPage,
  }) async {
    try {
      print("expiry dat---> $expiryDate");
      print("Document file---> $documentFile");

      var formData = FormData.fromMap({
        "id": id,
        "document_type": documentType,
        "sub_type": subType,
        "expiry_date": (expiryDate != null && expiryDate.isNotEmpty)
            ? (DateTime.parse(expiryDate).toUtc().millisecondsSinceEpoch / 1000)
                .toString()
            : "",
        "expiry_date_not_applicable": (expiryDateNotApplicable == true) ? 1 : 0,
        "registration_number": registrationNumber,
        "province_of_registration": provinceOfRegistration,
        "document_title": documentTitle,
        "name_of_vaccinations": nameOfVaccinations,
      });
      if (documentFile.isNotEmpty && !documentFile.contains('http')) {
        var multipartFile = await MultipartFile.fromFile(
          documentFile,
        );
        formData.files.add(MapEntry('file', multipartFile));
      }
      if (documentBackFile != null &&
          documentBackFile.isNotEmpty &&
          !documentBackFile.contains('http')) {
        var multipartFile = await MultipartFile.fromFile(
          documentBackFile,
        );
        formData.files.add(MapEntry('back_file', multipartFile));
      }

      print('Sending Data: ${formData.fields.map((e) => e)}');
      print('Sending Data frontpage: $documentFile');
      print('Sending Data backpage: $documentBackFile');
      print(
          'Sending Data with send proposal: ${formData.fields.map((e) => e.value)}');
      // print('Sending Data: ${formData['file']}');

      final response = await apiService.postMethod(
        ApiConstants.updateDocument,
        {},
        formData: formData,
        isMultipart: true,
      );

      print("Response of Update Document---> ${jsonEncode(response.data)}");

      // var account = response.data as List<dynamic>;
      // var list = account.map((e) => DocumentDTO.fromJson(e)).toList();
      return right(response.dioMessage ?? "");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      print("CATCH ERROR---> ${e}");
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, Account>> addMultiDocumentApi({
    required int documentType,
    required String documentFile,
    String? expiryDate,
    bool? expiryDateNotApplicable,
    String? registrationNumber,
    String? provinceOfRegistration,
    String? documentTitle,
    String? nameOfVaccinations,
    String? lastPage,
  }) async {
    try {
      print("expiry dat---> $expiryDate");
      print(
          "expiry date after timestamp---> ${DateTime.now().millisecondsSinceEpoch}");

      var formData = FormData.fromMap({
        "document_type": documentType,
        "province_of_registration": provinceOfRegistration,
        "expiry_date": (expiryDate != null && expiryDate.isNotEmpty)
            ? (DateTime.parse(expiryDate).toUtc().millisecondsSinceEpoch / 1000)
                .toString()
            : "",
        "expiry_date_not_applicable": (expiryDateNotApplicable == true) ? 1 : 0,
        "registration_number": registrationNumber,
        "document_title": documentTitle,
        "name_of_vaccinations": nameOfVaccinations,
        "last_page": lastPage ?? "Document",
      });
      if (documentFile.isNotEmpty && !documentFile.contains('http')) {
        var multipartFile = await MultipartFile.fromFile(
          documentFile,
        );
        formData.files.add(MapEntry('file', multipartFile));
      }

      print('Sending Data: ${formData.fields.map((e) => e)}');

      final response = await apiService.postMethod(
        ApiConstants.document,
        {},
        formData: formData,
        isMultipart: true,
      );

      // print("Response of Add Document---> ${jsonEncode(response.data)}");
      final account = CurrentUserDto.fromJson(response.data).toDomain();
      // return right(account);
      // var account = response.data as List<dynamic>;
      // var list = account.values.map((e) => DocumentDTO.fromJson(e)).toList();

      // var list = account.map((e) => DocumentDTO.fromJson(e)).toList();
      return right(account);
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      print("CATCH ERRO---> ${e}");
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, Account>> updateMultiDocumentApi({
    required int id,
    required int documentType,
    required String documentFile,
    String? expiryDate,
    bool? expiryDateNotApplicable,
    String? registrationNumber,
    String? provinceOfRegistration,
    String? documentTitle,
    String? nameOfVaccinations,
    String? lastPage,
  }) async {
    try {
      print("expiry dat---> $expiryDate");
      print("Document file---> $documentFile");
      print(
          "expiry date after timestamp---> ${DateTime.now().millisecondsSinceEpoch}");

      var formData = FormData.fromMap({
        "id": id,
        "document_type": documentType,
        "expiry_date": (expiryDate != null && expiryDate.isNotEmpty)
            ? (DateTime.parse(expiryDate).toUtc().millisecondsSinceEpoch / 1000)
                .toString()
            : "",
        "expiry_date_not_applicable": (expiryDateNotApplicable == true) ? 1 : 0,
        "registration_number": registrationNumber,
        "province_of_registration": provinceOfRegistration,
        "document_title": documentTitle,
        "name_of_vaccinations": nameOfVaccinations,
      });
      if (documentFile.isNotEmpty && !documentFile.contains('http')) {
        var multipartFile = await MultipartFile.fromFile(
          documentFile,
        );
        formData.files.add(MapEntry('file', multipartFile));
      }

      print('Sending Data: ${formData.fields.map((e) => e)}');

      final response = await apiService.postMethod(
        ApiConstants.updateDocument,
        {},
        formData: formData,
        isMultipart: true,
      );

      print("Response of Update Document---> ${jsonEncode(response.data)}");
      final account = CurrentUserDto.fromJson(response.data).toDomain();
      return right(account);
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      print("CATCH ERRO---> ${e}");
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, Account>> deleteDocumentApi({
    required int credId,
  }) async {
    try {
      final response = await apiService.deleteMethod(
        "${ApiConstants.destroyDocument}?id=$credId",
      );

      if (response != null && response.data != null) {
        final account = CurrentUserDto.fromJson(response.data).toDomain();
        print("Response of Delete Document---> ${jsonEncode(response.data)}");

        return right(account);
      } else {
        return left(const AccountFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      print("CATCH ERRO---> ${e}");
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, List<LegalScreeningDTO>>>
      getLegalScreeningListApi() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.legalScreeningQuestionList,
      );

      if (response != null && response.data != null) {
        print("Response of Legal Screening---> ${jsonEncode(response.data)}");

        var account = response.data as List<dynamic>;
        var list = account.map((e) => LegalScreeningDTO.fromJson(e)).toList();
        return right(list);
      } else {
        return left(const AccountFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      print("ERRORRRRRR----->  $e");
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, Account>> addLergalScreeningAnswerApi({
    required int affirmIsCheck,
    required String questionAnswerDetail,
  }) async {
    try {
      var mapData = {
        "check_affirm_resp_release_shiftfinder_liabilities": affirmIsCheck,
        "question_answer_detail": questionAnswerDetail,
        "last_page": "TermsAndCondition",
      };

      print('Sending Data: $mapData');

      final response = await apiService.postMethod(
        ApiConstants.legalScreeningQuestionAnswer,
        mapData,
      );
      print("Response of Add Questions---> ${jsonEncode(response.data)}");

      final account = CurrentUserDto.fromJson(response.data).toDomain();

      // return right(account);
      // var account = response.data as List<dynamic>;
      // var list = account.values.map((e) => DocumentDTO.fromJson(e)).toList();

      // var list = account.map((e) => DocumentDTO.fromJson(e)).toList();
      return right(account);
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      print("CATCH ERRO---> ${e}");
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, List<QuizDTO>>> getQuizListApi() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.quizList,
      );

      if (response != null && response.data != null) {
        print("Response of Quiz List---> ${jsonEncode(response.data)}");

        var account = response.data as List<dynamic>;
        var list = account.map((e) => QuizDTO.fromJson(e)).toList();
        return right(list);
      } else {
        return left(const AccountFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      print("ERRORRRRRR----->  $e");
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, QuizAnswerDTO>> addQuizAnswerApi({
    required String quizDetails,
  }) async {
    try {
      var mapData = {
        'quiz_details': quizDetails,
        'last_page': "ContractorMainTab",
        'isProfileComplete': "1",
      };

      print('Sending Data: ${jsonEncode(quizDetails)}');

      final response = await apiService.postMethod(
        ApiConstants.quiz,
        mapData,
      );
      print("Response of Add Quiz---> ${jsonEncode(response.data)}");

      final res = QuizAnswerDTO.fromJson(response.data);
      return right(res);
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      print("CATCH ERROR---> ${e}");
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, QuizAnswerDTO>> getQuizResultApi() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.quizResult,
      );
      if (response != null) {
        print("Response of Quiz Result---> ${jsonEncode(response.data)}");

        final res = QuizAnswerDTO.fromJson(response.data);
        return right(res);
      } else {
        return left(const AccountFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      print("CATCH ERROR---> ${e}");
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, List<SkillDTO>>> getFacilityTypeList() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.facilityTypeList,
      );

      if (response != null) {
        var account = response.data as List<dynamic>;
        var list = account.map((e) => SkillDTO.fromJson(e)).toList();

        print("FACILITY TYPE LIST RESPONSE---> $list");
        return right(list);
      } else {
        return left(const AccountFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }

      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, List<SkillDTO>>> getLocationBrandList() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.locationBrandsList,
      );

      if (response != null) {
        var account = response.data as List<dynamic>;
        var list = account.map((e) => SkillDTO.fromJson(e)).toList();

        print("LOCATION BRAND LIST RESPONSE---> $list");
        return right(list);
      } else {
        return left(const AccountFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }

      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, Account>> addLocationDetailsApi({
    required String locationAddress,
    required String facilityType,
    required String facilityTypeOther,
    required String locationId,
    required String accreditationNumber,
    required String locationNotes,
    // required String unitNumber,
    // required String unitNotes,
    required List<UnitDTO> units,
    required String latitude,
    required String longitude,
    required bool fromRegister,
    String? locationBrand,
    String? locationBrandOther,
    int? type,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        "location": locationAddress,
        "facility_type_lists_id": facilityType,
        "facility_type_other": facilityTypeOther,
        "location_id": locationId,
        "accreditation_number": accreditationNumber,
        "location_note": locationNotes,
        // "units_number_or_name": unitNumber,
        // "units_note": unitNotes,
        // "last_page": "AddCardDetail",
        if (fromRegister) "last_page": "AddCardDetail",
        if (fromRegister) "isProfileComplete": "1",

        // "units_number_or_name": unitNumber,
        // "units_note": unitNotes,
        if (type != null) "type": type,
        "units": units,
        "latitude": latitude,
        "longitude": longitude,
      };

      if (units.isNotEmpty) {
        mapData.addAll({
          "units": jsonEncode(units),
        });
      }

      if (getCurrentIndustry() == 2) {
        mapData.addAll({
          "location_brand_lists_id": locationBrand,
          "location_brand_other": locationBrandOther,
        });
      }

      print('Sending Data: ${jsonEncode(mapData)}');

      final response = await apiService.postMethod(
        ApiConstants.location,
        mapData,
      );
      print(
          "Response of Add location details---> ${jsonEncode(response.data)}");

      final account = CurrentUserDto.fromJson(response.data).toDomain();

      // return right(account);
      // var account = response.data as List<dynamic>;
      // var list = account.values.map((e) => DocumentDTO.fromJson(e)).toList();
      // var list = account.map((e) => DocumentDTO.fromJson(e)).toList();
      return right(account);
    } on DioException catch (err) {
      if (err.response != null) {
        var commonResponse = CommonResponse.fromJson(err.response?.data);

        if (commonResponse.dioMessage != null) {
          return left(AccountFailure.showAPIResponseMessage(
              commonResponse.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      print("CATCH ERROR---> ${e}");
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, List<LocationDTO>>> getLocationListApi() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.getLocation,
      );

      if (response != null) {
        var account = response.data as List<dynamic>;
        var list = account.map((e) => LocationDTO.fromJson(e)).toList();

        print("LOCATION LIST RESPONSE---> $list");
        return right(list);
      } else {
        return left(const AccountFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }

      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, Account>> updateLocation({
    required String locationAddress,
    required int id,
    required String facilityType,
    required String facilityTypeOther,
    required String locationId,
    required String accreditationNumber,
    required String locationNotes,
    required List<UnitDTO> units,
    required String latitude,
    required String longitude,
    required bool fromRegister,
    String? locationBrand,
    String? locationBrandOther,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        "id": id,
        "location": locationAddress,
        "facility_type_lists_id": facilityType,
        "facility_type_other": facilityTypeOther,
        "location_id": locationId,
        "accreditation_number": accreditationNumber,
        "location_note": locationNotes,
        // "units_number_or_name": unitNumber,
        // "units_note": unitNotes,
        // "last_page": "AddCardDetail",

        // "units_number_or_name": unitNumber,
        // "units_note": unitNotes,
        "units": units,
        "latitude": latitude,
        "longitude": longitude,
      };
      if (units.isNotEmpty) {
        mapData.addAll({
          "units": jsonEncode(units),
        });
      }

      if (getCurrentIndustry() == 2) {
        mapData.addAll({
          "location_brand_lists_id": locationBrand,
          "location_brand_other": locationBrandOther,
        });
      }
      print('Sending Data: ${jsonEncode(mapData)}');

      final response = await apiService.postMethod(
        ApiConstants.updateLocation,
        mapData,
      );
      print(
          "Response of Add location details---> ${jsonEncode(response.data)}");

      final account = CurrentUserDto.fromJson(response.data).toDomain();

      // return right(account);
      // var account = response.data as List<dynamic>;
      // var list = account.values.map((e) => DocumentDTO.fromJson(e)).toList();
      // var list = account.map((e) => DocumentDTO.fromJson(e)).toList();
      return right(account);
    } on DioException catch (err) {
      if (err.response != null) {
        var commonResponse = CommonResponse.fromJson(err.response?.data);

        if (commonResponse.dioMessage != null) {
          return left(AccountFailure.showAPIResponseMessage(
              commonResponse.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      print("CATCH ERROR---> ${e}");
      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, BankDTO>> getBankDetailAPI() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.contractorRetrieveAccountDetail,
      );

      if (response != null) {
        // print("Response of Get Bank Detail---> ${jsonEncode(response.data)}");
        final data = BankDTO.fromJson(response.data);

        return right(data);
      } else {
        return left(const AccountFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }
      return left(const AccountFailure.serverError());
    } catch (e) {
      print("ERRORRRRRR----->  $e");
      return left(const AccountFailure.serverError());
    }
  }
}
