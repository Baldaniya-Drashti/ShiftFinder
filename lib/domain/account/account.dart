import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/education_dto/education_dto.dart';
import 'package:shift/infrastructure/core/reference_dto/reference_dto.dart';

part 'account.freezed.dart';

@freezed
class Account with _$Account {
  const Account._();

  const factory Account({
    int? userId,
    String? firstName,
    String? lastName,
    String? email,
    int? isVerified,
    int? serviceRole,
    int? industryId,
    String? profileImage,
    String? companyName,
    String? countryCode,
    String? countryNameCode,
    int? phone,
    String? association,
    String? companyDescription,
    String? location,
    String? referralCode,
    String? lastPage,
    List<EducationDTO>? education,
    List<ReferenceDTO>? reference,
    Auth? auth,
  }) = _Account;
}

@freezed
class Auth with _$Auth {
  const Auth._();
  const factory Auth({
    String? tokenType,
    int? expiresIn,
    String? accessToken,
    String? refreshToken,
  }) = _Auth;
}
