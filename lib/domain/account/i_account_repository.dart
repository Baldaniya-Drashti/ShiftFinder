import 'package:dartz/dartz.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';

abstract class IAccountRepository {
  Future<Either<AccountFailure, Account>> getCurrentUserApi();
  Future<Either<AccountFailure, String>> addEducationApi({
    required InputEmptyOrNot programCompleted,
    required InputEmptyOrNot yearOfCompletion,
    required InputEmptyOrNot graduatingInstitution,
  });
  Future<Either<AccountFailure, Account>> deleteEducationApi({
    required int educationId,
  });
}
