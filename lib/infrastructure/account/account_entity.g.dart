// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountEntityAdapter extends TypeAdapter<AccountEntity> {
  @override
  final int typeId = 0;

  @override
  AccountEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountEntity(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[9] as String?,
      fields[11] as int?,
      fields[12] as String?,
      fields[13] as String?,
      fields[8] as String?,
      fields[10] as String?,
      fields[6] as int?,
      fields[4] as int?,
      fields[16] as String?,
      fields[14] as String?,
      fields[7] as String?,
      fields[17] as int?,
      fields[15] as String?,
      fields[5] as int?,
      fields[18] as int?,
      fields[19] as String?,
      fields[20] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, AccountEntity obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.isVerified)
      ..writeByte(5)
      ..write(obj.serviceRole)
      ..writeByte(6)
      ..write(obj.industryId)
      ..writeByte(7)
      ..write(obj.profileImage)
      ..writeByte(8)
      ..write(obj.companyName)
      ..writeByte(9)
      ..write(obj.countryCode)
      ..writeByte(10)
      ..write(obj.countryNameCode)
      ..writeByte(11)
      ..write(obj.phone)
      ..writeByte(12)
      ..write(obj.association)
      ..writeByte(13)
      ..write(obj.companyDescription)
      ..writeByte(14)
      ..write(obj.location)
      ..writeByte(15)
      ..write(obj.referralCode)
      ..writeByte(16)
      ..write(obj.lastPage)
      ..writeByte(17)
      ..write(obj.isProfileComplete)
      ..writeByte(18)
      ..write(obj.isDialogBox)
      ..writeByte(19)
      ..write(obj.your_referral_code)
      ..writeByte(20)
      ..write(obj.isUserEnable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
