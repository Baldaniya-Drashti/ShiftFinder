// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_previous_shift_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployerPreviousShiftDtoImpl _$$EmployerPreviousShiftDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployerPreviousShiftDtoImpl(
      post_id: (json['post_id'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      user_id: (json['user_id'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      profile: json['profile'] as String?,
      role_lists_name: json['role_lists_name'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      all_over_rating: (json['all_over_rating'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      location: json['location'] as String?,
      remarks: json['remarks'] as String?,
      distance: json['distance'] as String?,
      last_worked_date: (json['last_worked_date'] as num?)?.toInt(),
      last_worked_start_time: (json['last_worked_start_time'] as num?)?.toInt(),
      last_worked_end_time: (json['last_worked_end_time'] as num?)?.toInt(),
      isRating: json['isRating'] as bool?,
      isFavourite: json['isFavourite'] as bool?,
      isRemark: json['isRemark'] as bool?,
      isBlock: json['isBlock'] as bool?,
      email: json['email'] as String?,
      remark: json['remark'] as String?,
      total_amount: json['total_amount'] as String?,
    );

Map<String, dynamic> _$$EmployerPreviousShiftDtoImplToJson(
        _$EmployerPreviousShiftDtoImpl instance) =>
    <String, dynamic>{
      'post_id': instance.post_id,
      'id': instance.id,
      'user_id': instance.user_id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'profile': instance.profile,
      'role_lists_name': instance.role_lists_name,
      'rating': instance.rating,
      'all_over_rating': instance.all_over_rating,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'location': instance.location,
      'remarks': instance.remarks,
      'distance': instance.distance,
      'last_worked_date': instance.last_worked_date,
      'last_worked_start_time': instance.last_worked_start_time,
      'last_worked_end_time': instance.last_worked_end_time,
      'isRating': instance.isRating,
      'isFavourite': instance.isFavourite,
      'isRemark': instance.isRemark,
      'isBlock': instance.isBlock,
      'email': instance.email,
      'remark': instance.remark,
      'total_amount': instance.total_amount,
    };
