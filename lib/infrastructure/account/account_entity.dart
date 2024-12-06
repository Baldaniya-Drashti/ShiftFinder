import 'package:hive/hive.dart';
import 'package:shift/domain/account/account.dart';

part 'account_entity.g.dart';

@HiveType(typeId: 0)
class AccountEntity extends HiveObject {
  @HiveField(0)
  final int? userId;
  @HiveField(1)
  final String? firstName;
  @HiveField(2)
  final String? lastName;
  @HiveField(3)
  final String? email;
  @HiveField(4)
  final int? isVerified;
  @HiveField(5)
  final int? serviceRole;
  @HiveField(6)
  final int? industryId;
  @HiveField(7)
  final String? profileImage;
  @HiveField(8)
  final String? companyName;
  @HiveField(9)
  final String? countryCode;
  @HiveField(10)
  final String? countryNameCode;
  @HiveField(11)
  final int? phone;
  @HiveField(12)
  final String? association;
  @HiveField(13)
  final String? companyDescription;
  @HiveField(14)
  final String? location;
  @HiveField(15)
  final String? referralCode;
  @HiveField(16)
  final String? lastPage;
  @HiveField(17)
  final int? isProfileComplete;
  @HiveField(18)
  final int? isDialogBox;
  @HiveField(19)
  final String? your_referral_code;

  AccountEntity(
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.countryCode,
    this.phone,
    this.association,
    this.companyDescription,
    this.companyName,
    this.countryNameCode,
    this.industryId,
    this.isVerified,
    this.lastPage,
    this.location,
    this.profileImage,
    this.isProfileComplete,
    this.referralCode,
    this.serviceRole,
    this.isDialogBox,
    this.your_referral_code,
  );

  Account toDomain() {
    return Account(
      userId: userId,
      isDialogBox: isDialogBox,
      firstName: firstName,
      lastName: lastName,
      email: email,
      countryCode: countryCode,
      phone: phone,
      association: association,
      companyDescription: companyDescription,
      companyName: companyName,
      countryNameCode: countryNameCode,
      industryId: industryId,
      isVerified: isVerified,
      lastPage: lastPage,
      location: location,
      profileImage: profileImage,
      isProfileComplete: isProfileComplete,
      referralCode: referralCode,
      serviceRole: serviceRole,
      your_referral_code: your_referral_code,
    );
  }

  factory AccountEntity.fromDomain(Account account) {
    return AccountEntity(
      account.userId,
      account.firstName,
      account.lastName,
      account.email,
      account.countryCode,
      account.phone,
      account.association,
      account.companyDescription,
      account.companyName,
      account.countryNameCode,
      account.industryId,
      account.isVerified,
      account.lastPage,
      account.location,
      account.profileImage,
      account.isProfileComplete,
      account.referralCode,
      account.serviceRole,
      account.isDialogBox,
      account.your_referral_code,
    );
  }
}
