import 'package:shift/domain/core/failures.dart';
import 'package:shift/domain/core/value_objects.dart';
import 'package:shift/domain/core/value_validators.dart';
import 'package:dartz/dartz.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);
}

class PinCode extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory PinCode(String input) {
    return PinCode._(
      validatePincode(input),
    );
  }

  const PinCode._(this.value);
}

class OTPText extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory OTPText(String input) {
    return OTPText._(
      validateMaxStringLength(input, 4),
    );
  }

  const OTPText._(this.value);
}

class Rate extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Rate(String input) {
    return Rate._(
      validateRate(input),
    );
  }

  const Rate._(this.value);
}

class Username extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Username(String input) {
    return Username._(
      validateUsername(input),
    );
  }

  const Username._(this.value);
}

class Lastname extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Lastname(String input) {
    return Lastname._(
      validateLastname(input),
    );
  }
  const Lastname._(this.value);
}

class Vacancy extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Vacancy(String input) {
    return Vacancy._(
      validateNumberOfVacancy(input),
    );
  }

  const Vacancy._(this.value);
}

class MobileNumber extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory MobileNumber(String input) {
    return MobileNumber._(
      validateMobileNumber(input),
    );
  }

  const MobileNumber._(this.value);
}

class InputEmptyOrNot extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String?> value;

  factory InputEmptyOrNot(String input) {
    return InputEmptyOrNot._(
      validateStringNotEmpty(input),
    );
  }
  const InputEmptyOrNot._(this.value);
}

// class ListInputEmptyOrNot extends ValueObject<List> {
//   @override
//   final Either<ValueFailure<List>, List> value;

//   factory ListInputEmptyOrNot(List list) {
//     return ListInputEmptyOrNot._(
//       validateMaxGuildLength(list, 0),
//     );
//   }
//   const ListInputEmptyOrNot._(this.value);
// }

class ListInputEmptyOrNot<T> extends ValueObject<List<T>> {
  @override
  final Either<ValueFailure<List<T>>, List<T>> value;

  factory ListInputEmptyOrNot(List<T> input) {
    return ListInputEmptyOrNot._(
      validateListNotEmpty(input),
    );
  }

  const ListInputEmptyOrNot._(this.value);
  Map<String, dynamic> toJson() {
    return {
      'value': value.fold(
        (l) => null,
        (r) => r.map((e) => (e as dynamic).toJson()).toList(),
      ),
    };
  }
}

class CardNumber extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String?> value;

  factory CardNumber(String input) {
    return CardNumber._(
      validateCardNumber(input),
    );
  }

  const CardNumber._(this.value);
}

class CardDate extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String?> value;

  factory CardDate(String input) {
    return CardDate._(
      validateCardDate(input),
    );
  }

  const CardDate._(this.value);
}

class CVV extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String?> value;

  factory CVV(String value) {
    return CVV._(
      validateCvv(value),
    );
  }
  const CVV._(this.value);
}

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    return Password._(
      validatePassword(input),
    );
  }
  const Password._(this.value);
}

class ConfirmPassword extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory ConfirmPassword(String confirmPassword, String newPassword) {
    return ConfirmPassword._(
      validateConfirmPassword(confirmPassword.trim(), newPassword.trim()),
    );
  }
  const ConfirmPassword._(this.value);
}
