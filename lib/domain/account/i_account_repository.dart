import 'package:dartz/dartz.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/infrastructure/core/document_dto/document_dto.dart';
import 'package:shift/infrastructure/core/experience_model/experience_dto.dart';
import 'package:shift/infrastructure/core/legal_screening_dto/legal_screening_dto.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/quiz_dto/quiz_dto.dart';

import '../../infrastructure/core/skill_list_model/skill_dto.dart';

abstract class IAccountRepository {
  Future<Either<AccountFailure, Account>> getCurrentUserApi();

  Future<Either<AccountFailure, List<ExperienceDTO>>> getExperienceRoleList();
  Future<Either<AccountFailure, List<ExperienceDTO>>>
      getExperienceSpecialityList();
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
  });
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
  });
  Future<Either<AccountFailure, Account>> addExperienceApi({
    required String experienceDetail,
  });
  Future<Either<AccountFailure, Account>> addSpecialityExperienceApi({
    required String experienceDetail,
  });
  Future<Either<AccountFailure, String>> addEducationApi({
    required InputEmptyOrNot programCompleted,
    required InputEmptyOrNot yearOfCompletion,
    required InputEmptyOrNot graduatingInstitution,
  });
  Future<Either<AccountFailure, String>> updateEducationApi({
    required int id,
    required InputEmptyOrNot programCompleted,
    required InputEmptyOrNot yearOfCompletion,
    required InputEmptyOrNot graduatingInstitution,
  });
  Future<Either<AccountFailure, Account>> deleteEducationApi({
    required int educationId,
  });
  Future<Either<AccountFailure, Account>> deleteReferenceApi({
    required int referenceId,
  });
  Future<Either<AccountFailure, List<DocumentDTO>>> getDocumentApi({
    required int? documentType,
  });
  Future<Either<AccountFailure, List<LegalScreeningDTO>>>
      getLegalScreeningListApi();

  Future<Either<AccountFailure, String>> addDocumentApi({
    required int documentType,
    required String documentFile,
    String? expiryDate,
    bool? expiryDateNotApplicable,
    String? registrationNumber,
    String? provinceOfRegistration,
    String? documentTitle,
    String? nameOfVaccinations,
    String? lastPage,
  });

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
  });

  Future<Either<AccountFailure, String>> updateDocumentApi({
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
  });

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
  });
  Future<Either<AccountFailure, Account>> deleteDocumentApi({
    required int credId,
  });

  Future<Either<AccountFailure, Account>> addLergalScreeningAnswerApi({
    required int affirmIsCheck,
    required String questionAnswerDetail,
  });
  Future<Either<AccountFailure, QuizAnswerDTO>> addQuizAnswerApi({
    required String quizDetails,
  });
  Future<Either<AccountFailure, QuizAnswerDTO>> getQuizResultApi();

  Future<Either<AccountFailure, List<QuizDTO>>> getQuizListApi();
  Future<Either<AccountFailure, List<SkillDTO>>> getFacilityTypeList();
  Future<Either<AccountFailure, List<LocationDTO>>> getLocationListApi();

  Future<Either<AccountFailure, Account>> addLocationDetailsApi({
    required String locationAddress,
    required String facilityType,
    required String facilityTypeOther,
    required String locationId,
    required String accreditationNumber,
    required String locationNotes,
    required String unitNumber,
    required String unitNotes,
    required List<UnitDTO> units,
    required String latitude,
    required String longitude,
  });
}
