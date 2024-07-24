// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'healthcare_post_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HealthcarePostEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String roleType) roleTypeChanged,
    required TResult Function(String language) selectedLanguageChanged,
    required TResult Function(String location) locationChanged,
    required TResult Function(String selectedUnit) locationUnitSelectionChanged,
    required TResult Function(String rateHour) rateHourChanged,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addRequiredSpecialitichips,
    required TResult Function(String selectedValue)
        removeRequiredSpecialitichips,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addPreferedSoftwareSkillchips,
    required TResult Function(String selectedValue)
        removePreferedSoftwareSkillchips,
    required TResult Function() continueBtnPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String roleType)? roleTypeChanged,
    TResult? Function(String language)? selectedLanguageChanged,
    TResult? Function(String location)? locationChanged,
    TResult? Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult? Function(String rateHour)? rateHourChanged,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult? Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult? Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult? Function()? continueBtnPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String roleType)? roleTypeChanged,
    TResult Function(String language)? selectedLanguageChanged,
    TResult Function(String location)? locationChanged,
    TResult Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult Function(String rateHour)? rateHourChanged,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult Function()? continueBtnPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoleTypeChanged value) roleTypeChanged,
    required TResult Function(SelectedLanguageChanged value)
        selectedLanguageChanged,
    required TResult Function(LocationChanged value) locationChanged,
    required TResult Function(LocationUnitSelectionChanged value)
        locationUnitSelectionChanged,
    required TResult Function(RateHourChanged value) rateHourChanged,
    required TResult Function(AddRequiredSpecialitichips value)
        addRequiredSpecialitichips,
    required TResult Function(RemoveRequiredSpecialitichips value)
        removeRequiredSpecialitichips,
    required TResult Function(AddPreferedSoftwareSkillchips value)
        addPreferedSoftwareSkillchips,
    required TResult Function(RemovePreferedSoftwareSkillchips value)
        removePreferedSoftwareSkillchips,
    required TResult Function(ContinueBtnPressed value) continueBtnPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoleTypeChanged value)? roleTypeChanged,
    TResult? Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult? Function(LocationChanged value)? locationChanged,
    TResult? Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult? Function(RateHourChanged value)? rateHourChanged,
    TResult? Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult? Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult? Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult? Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult? Function(ContinueBtnPressed value)? continueBtnPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoleTypeChanged value)? roleTypeChanged,
    TResult Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult Function(LocationChanged value)? locationChanged,
    TResult Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult Function(RateHourChanged value)? rateHourChanged,
    TResult Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult Function(ContinueBtnPressed value)? continueBtnPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthcarePostEventCopyWith<$Res> {
  factory $HealthcarePostEventCopyWith(
          HealthcarePostEvent value, $Res Function(HealthcarePostEvent) then) =
      _$HealthcarePostEventCopyWithImpl<$Res, HealthcarePostEvent>;
}

/// @nodoc
class _$HealthcarePostEventCopyWithImpl<$Res, $Val extends HealthcarePostEvent>
    implements $HealthcarePostEventCopyWith<$Res> {
  _$HealthcarePostEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$RoleTypeChangedImplCopyWith<$Res> {
  factory _$$RoleTypeChangedImplCopyWith(_$RoleTypeChangedImpl value,
          $Res Function(_$RoleTypeChangedImpl) then) =
      __$$RoleTypeChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String roleType});
}

/// @nodoc
class __$$RoleTypeChangedImplCopyWithImpl<$Res>
    extends _$HealthcarePostEventCopyWithImpl<$Res, _$RoleTypeChangedImpl>
    implements _$$RoleTypeChangedImplCopyWith<$Res> {
  __$$RoleTypeChangedImplCopyWithImpl(
      _$RoleTypeChangedImpl _value, $Res Function(_$RoleTypeChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roleType = null,
  }) {
    return _then(_$RoleTypeChangedImpl(
      null == roleType
          ? _value.roleType
          : roleType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RoleTypeChangedImpl implements RoleTypeChanged {
  const _$RoleTypeChangedImpl(this.roleType);

  @override
  final String roleType;

  @override
  String toString() {
    return 'HealthcarePostEvent.roleTypeChanged(roleType: $roleType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoleTypeChangedImpl &&
            (identical(other.roleType, roleType) ||
                other.roleType == roleType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, roleType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoleTypeChangedImplCopyWith<_$RoleTypeChangedImpl> get copyWith =>
      __$$RoleTypeChangedImplCopyWithImpl<_$RoleTypeChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String roleType) roleTypeChanged,
    required TResult Function(String language) selectedLanguageChanged,
    required TResult Function(String location) locationChanged,
    required TResult Function(String selectedUnit) locationUnitSelectionChanged,
    required TResult Function(String rateHour) rateHourChanged,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addRequiredSpecialitichips,
    required TResult Function(String selectedValue)
        removeRequiredSpecialitichips,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addPreferedSoftwareSkillchips,
    required TResult Function(String selectedValue)
        removePreferedSoftwareSkillchips,
    required TResult Function() continueBtnPressed,
  }) {
    return roleTypeChanged(roleType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String roleType)? roleTypeChanged,
    TResult? Function(String language)? selectedLanguageChanged,
    TResult? Function(String location)? locationChanged,
    TResult? Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult? Function(String rateHour)? rateHourChanged,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult? Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult? Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult? Function()? continueBtnPressed,
  }) {
    return roleTypeChanged?.call(roleType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String roleType)? roleTypeChanged,
    TResult Function(String language)? selectedLanguageChanged,
    TResult Function(String location)? locationChanged,
    TResult Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult Function(String rateHour)? rateHourChanged,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult Function()? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (roleTypeChanged != null) {
      return roleTypeChanged(roleType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoleTypeChanged value) roleTypeChanged,
    required TResult Function(SelectedLanguageChanged value)
        selectedLanguageChanged,
    required TResult Function(LocationChanged value) locationChanged,
    required TResult Function(LocationUnitSelectionChanged value)
        locationUnitSelectionChanged,
    required TResult Function(RateHourChanged value) rateHourChanged,
    required TResult Function(AddRequiredSpecialitichips value)
        addRequiredSpecialitichips,
    required TResult Function(RemoveRequiredSpecialitichips value)
        removeRequiredSpecialitichips,
    required TResult Function(AddPreferedSoftwareSkillchips value)
        addPreferedSoftwareSkillchips,
    required TResult Function(RemovePreferedSoftwareSkillchips value)
        removePreferedSoftwareSkillchips,
    required TResult Function(ContinueBtnPressed value) continueBtnPressed,
  }) {
    return roleTypeChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoleTypeChanged value)? roleTypeChanged,
    TResult? Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult? Function(LocationChanged value)? locationChanged,
    TResult? Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult? Function(RateHourChanged value)? rateHourChanged,
    TResult? Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult? Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult? Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult? Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult? Function(ContinueBtnPressed value)? continueBtnPressed,
  }) {
    return roleTypeChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoleTypeChanged value)? roleTypeChanged,
    TResult Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult Function(LocationChanged value)? locationChanged,
    TResult Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult Function(RateHourChanged value)? rateHourChanged,
    TResult Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult Function(ContinueBtnPressed value)? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (roleTypeChanged != null) {
      return roleTypeChanged(this);
    }
    return orElse();
  }
}

abstract class RoleTypeChanged implements HealthcarePostEvent {
  const factory RoleTypeChanged(final String roleType) = _$RoleTypeChangedImpl;

  String get roleType;
  @JsonKey(ignore: true)
  _$$RoleTypeChangedImplCopyWith<_$RoleTypeChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectedLanguageChangedImplCopyWith<$Res> {
  factory _$$SelectedLanguageChangedImplCopyWith(
          _$SelectedLanguageChangedImpl value,
          $Res Function(_$SelectedLanguageChangedImpl) then) =
      __$$SelectedLanguageChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String language});
}

/// @nodoc
class __$$SelectedLanguageChangedImplCopyWithImpl<$Res>
    extends _$HealthcarePostEventCopyWithImpl<$Res,
        _$SelectedLanguageChangedImpl>
    implements _$$SelectedLanguageChangedImplCopyWith<$Res> {
  __$$SelectedLanguageChangedImplCopyWithImpl(
      _$SelectedLanguageChangedImpl _value,
      $Res Function(_$SelectedLanguageChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? language = null,
  }) {
    return _then(_$SelectedLanguageChangedImpl(
      null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SelectedLanguageChangedImpl implements SelectedLanguageChanged {
  const _$SelectedLanguageChangedImpl(this.language);

  @override
  final String language;

  @override
  String toString() {
    return 'HealthcarePostEvent.selectedLanguageChanged(language: $language)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedLanguageChangedImpl &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @override
  int get hashCode => Object.hash(runtimeType, language);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedLanguageChangedImplCopyWith<_$SelectedLanguageChangedImpl>
      get copyWith => __$$SelectedLanguageChangedImplCopyWithImpl<
          _$SelectedLanguageChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String roleType) roleTypeChanged,
    required TResult Function(String language) selectedLanguageChanged,
    required TResult Function(String location) locationChanged,
    required TResult Function(String selectedUnit) locationUnitSelectionChanged,
    required TResult Function(String rateHour) rateHourChanged,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addRequiredSpecialitichips,
    required TResult Function(String selectedValue)
        removeRequiredSpecialitichips,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addPreferedSoftwareSkillchips,
    required TResult Function(String selectedValue)
        removePreferedSoftwareSkillchips,
    required TResult Function() continueBtnPressed,
  }) {
    return selectedLanguageChanged(language);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String roleType)? roleTypeChanged,
    TResult? Function(String language)? selectedLanguageChanged,
    TResult? Function(String location)? locationChanged,
    TResult? Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult? Function(String rateHour)? rateHourChanged,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult? Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult? Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult? Function()? continueBtnPressed,
  }) {
    return selectedLanguageChanged?.call(language);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String roleType)? roleTypeChanged,
    TResult Function(String language)? selectedLanguageChanged,
    TResult Function(String location)? locationChanged,
    TResult Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult Function(String rateHour)? rateHourChanged,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult Function()? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (selectedLanguageChanged != null) {
      return selectedLanguageChanged(language);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoleTypeChanged value) roleTypeChanged,
    required TResult Function(SelectedLanguageChanged value)
        selectedLanguageChanged,
    required TResult Function(LocationChanged value) locationChanged,
    required TResult Function(LocationUnitSelectionChanged value)
        locationUnitSelectionChanged,
    required TResult Function(RateHourChanged value) rateHourChanged,
    required TResult Function(AddRequiredSpecialitichips value)
        addRequiredSpecialitichips,
    required TResult Function(RemoveRequiredSpecialitichips value)
        removeRequiredSpecialitichips,
    required TResult Function(AddPreferedSoftwareSkillchips value)
        addPreferedSoftwareSkillchips,
    required TResult Function(RemovePreferedSoftwareSkillchips value)
        removePreferedSoftwareSkillchips,
    required TResult Function(ContinueBtnPressed value) continueBtnPressed,
  }) {
    return selectedLanguageChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoleTypeChanged value)? roleTypeChanged,
    TResult? Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult? Function(LocationChanged value)? locationChanged,
    TResult? Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult? Function(RateHourChanged value)? rateHourChanged,
    TResult? Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult? Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult? Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult? Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult? Function(ContinueBtnPressed value)? continueBtnPressed,
  }) {
    return selectedLanguageChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoleTypeChanged value)? roleTypeChanged,
    TResult Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult Function(LocationChanged value)? locationChanged,
    TResult Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult Function(RateHourChanged value)? rateHourChanged,
    TResult Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult Function(ContinueBtnPressed value)? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (selectedLanguageChanged != null) {
      return selectedLanguageChanged(this);
    }
    return orElse();
  }
}

abstract class SelectedLanguageChanged implements HealthcarePostEvent {
  const factory SelectedLanguageChanged(final String language) =
      _$SelectedLanguageChangedImpl;

  String get language;
  @JsonKey(ignore: true)
  _$$SelectedLanguageChangedImplCopyWith<_$SelectedLanguageChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LocationChangedImplCopyWith<$Res> {
  factory _$$LocationChangedImplCopyWith(_$LocationChangedImpl value,
          $Res Function(_$LocationChangedImpl) then) =
      __$$LocationChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String location});
}

/// @nodoc
class __$$LocationChangedImplCopyWithImpl<$Res>
    extends _$HealthcarePostEventCopyWithImpl<$Res, _$LocationChangedImpl>
    implements _$$LocationChangedImplCopyWith<$Res> {
  __$$LocationChangedImplCopyWithImpl(
      _$LocationChangedImpl _value, $Res Function(_$LocationChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
  }) {
    return _then(_$LocationChangedImpl(
      null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LocationChangedImpl implements LocationChanged {
  const _$LocationChangedImpl(this.location);

  @override
  final String location;

  @override
  String toString() {
    return 'HealthcarePostEvent.locationChanged(location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationChangedImpl &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationChangedImplCopyWith<_$LocationChangedImpl> get copyWith =>
      __$$LocationChangedImplCopyWithImpl<_$LocationChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String roleType) roleTypeChanged,
    required TResult Function(String language) selectedLanguageChanged,
    required TResult Function(String location) locationChanged,
    required TResult Function(String selectedUnit) locationUnitSelectionChanged,
    required TResult Function(String rateHour) rateHourChanged,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addRequiredSpecialitichips,
    required TResult Function(String selectedValue)
        removeRequiredSpecialitichips,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addPreferedSoftwareSkillchips,
    required TResult Function(String selectedValue)
        removePreferedSoftwareSkillchips,
    required TResult Function() continueBtnPressed,
  }) {
    return locationChanged(location);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String roleType)? roleTypeChanged,
    TResult? Function(String language)? selectedLanguageChanged,
    TResult? Function(String location)? locationChanged,
    TResult? Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult? Function(String rateHour)? rateHourChanged,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult? Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult? Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult? Function()? continueBtnPressed,
  }) {
    return locationChanged?.call(location);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String roleType)? roleTypeChanged,
    TResult Function(String language)? selectedLanguageChanged,
    TResult Function(String location)? locationChanged,
    TResult Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult Function(String rateHour)? rateHourChanged,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult Function()? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (locationChanged != null) {
      return locationChanged(location);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoleTypeChanged value) roleTypeChanged,
    required TResult Function(SelectedLanguageChanged value)
        selectedLanguageChanged,
    required TResult Function(LocationChanged value) locationChanged,
    required TResult Function(LocationUnitSelectionChanged value)
        locationUnitSelectionChanged,
    required TResult Function(RateHourChanged value) rateHourChanged,
    required TResult Function(AddRequiredSpecialitichips value)
        addRequiredSpecialitichips,
    required TResult Function(RemoveRequiredSpecialitichips value)
        removeRequiredSpecialitichips,
    required TResult Function(AddPreferedSoftwareSkillchips value)
        addPreferedSoftwareSkillchips,
    required TResult Function(RemovePreferedSoftwareSkillchips value)
        removePreferedSoftwareSkillchips,
    required TResult Function(ContinueBtnPressed value) continueBtnPressed,
  }) {
    return locationChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoleTypeChanged value)? roleTypeChanged,
    TResult? Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult? Function(LocationChanged value)? locationChanged,
    TResult? Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult? Function(RateHourChanged value)? rateHourChanged,
    TResult? Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult? Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult? Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult? Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult? Function(ContinueBtnPressed value)? continueBtnPressed,
  }) {
    return locationChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoleTypeChanged value)? roleTypeChanged,
    TResult Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult Function(LocationChanged value)? locationChanged,
    TResult Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult Function(RateHourChanged value)? rateHourChanged,
    TResult Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult Function(ContinueBtnPressed value)? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (locationChanged != null) {
      return locationChanged(this);
    }
    return orElse();
  }
}

abstract class LocationChanged implements HealthcarePostEvent {
  const factory LocationChanged(final String location) = _$LocationChangedImpl;

  String get location;
  @JsonKey(ignore: true)
  _$$LocationChangedImplCopyWith<_$LocationChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LocationUnitSelectionChangedImplCopyWith<$Res> {
  factory _$$LocationUnitSelectionChangedImplCopyWith(
          _$LocationUnitSelectionChangedImpl value,
          $Res Function(_$LocationUnitSelectionChangedImpl) then) =
      __$$LocationUnitSelectionChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String selectedUnit});
}

/// @nodoc
class __$$LocationUnitSelectionChangedImplCopyWithImpl<$Res>
    extends _$HealthcarePostEventCopyWithImpl<$Res,
        _$LocationUnitSelectionChangedImpl>
    implements _$$LocationUnitSelectionChangedImplCopyWith<$Res> {
  __$$LocationUnitSelectionChangedImplCopyWithImpl(
      _$LocationUnitSelectionChangedImpl _value,
      $Res Function(_$LocationUnitSelectionChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedUnit = null,
  }) {
    return _then(_$LocationUnitSelectionChangedImpl(
      null == selectedUnit
          ? _value.selectedUnit
          : selectedUnit // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LocationUnitSelectionChangedImpl
    implements LocationUnitSelectionChanged {
  const _$LocationUnitSelectionChangedImpl(this.selectedUnit);

  @override
  final String selectedUnit;

  @override
  String toString() {
    return 'HealthcarePostEvent.locationUnitSelectionChanged(selectedUnit: $selectedUnit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationUnitSelectionChangedImpl &&
            (identical(other.selectedUnit, selectedUnit) ||
                other.selectedUnit == selectedUnit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedUnit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationUnitSelectionChangedImplCopyWith<
          _$LocationUnitSelectionChangedImpl>
      get copyWith => __$$LocationUnitSelectionChangedImplCopyWithImpl<
          _$LocationUnitSelectionChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String roleType) roleTypeChanged,
    required TResult Function(String language) selectedLanguageChanged,
    required TResult Function(String location) locationChanged,
    required TResult Function(String selectedUnit) locationUnitSelectionChanged,
    required TResult Function(String rateHour) rateHourChanged,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addRequiredSpecialitichips,
    required TResult Function(String selectedValue)
        removeRequiredSpecialitichips,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addPreferedSoftwareSkillchips,
    required TResult Function(String selectedValue)
        removePreferedSoftwareSkillchips,
    required TResult Function() continueBtnPressed,
  }) {
    return locationUnitSelectionChanged(selectedUnit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String roleType)? roleTypeChanged,
    TResult? Function(String language)? selectedLanguageChanged,
    TResult? Function(String location)? locationChanged,
    TResult? Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult? Function(String rateHour)? rateHourChanged,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult? Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult? Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult? Function()? continueBtnPressed,
  }) {
    return locationUnitSelectionChanged?.call(selectedUnit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String roleType)? roleTypeChanged,
    TResult Function(String language)? selectedLanguageChanged,
    TResult Function(String location)? locationChanged,
    TResult Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult Function(String rateHour)? rateHourChanged,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult Function()? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (locationUnitSelectionChanged != null) {
      return locationUnitSelectionChanged(selectedUnit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoleTypeChanged value) roleTypeChanged,
    required TResult Function(SelectedLanguageChanged value)
        selectedLanguageChanged,
    required TResult Function(LocationChanged value) locationChanged,
    required TResult Function(LocationUnitSelectionChanged value)
        locationUnitSelectionChanged,
    required TResult Function(RateHourChanged value) rateHourChanged,
    required TResult Function(AddRequiredSpecialitichips value)
        addRequiredSpecialitichips,
    required TResult Function(RemoveRequiredSpecialitichips value)
        removeRequiredSpecialitichips,
    required TResult Function(AddPreferedSoftwareSkillchips value)
        addPreferedSoftwareSkillchips,
    required TResult Function(RemovePreferedSoftwareSkillchips value)
        removePreferedSoftwareSkillchips,
    required TResult Function(ContinueBtnPressed value) continueBtnPressed,
  }) {
    return locationUnitSelectionChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoleTypeChanged value)? roleTypeChanged,
    TResult? Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult? Function(LocationChanged value)? locationChanged,
    TResult? Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult? Function(RateHourChanged value)? rateHourChanged,
    TResult? Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult? Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult? Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult? Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult? Function(ContinueBtnPressed value)? continueBtnPressed,
  }) {
    return locationUnitSelectionChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoleTypeChanged value)? roleTypeChanged,
    TResult Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult Function(LocationChanged value)? locationChanged,
    TResult Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult Function(RateHourChanged value)? rateHourChanged,
    TResult Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult Function(ContinueBtnPressed value)? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (locationUnitSelectionChanged != null) {
      return locationUnitSelectionChanged(this);
    }
    return orElse();
  }
}

abstract class LocationUnitSelectionChanged implements HealthcarePostEvent {
  const factory LocationUnitSelectionChanged(final String selectedUnit) =
      _$LocationUnitSelectionChangedImpl;

  String get selectedUnit;
  @JsonKey(ignore: true)
  _$$LocationUnitSelectionChangedImplCopyWith<
          _$LocationUnitSelectionChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RateHourChangedImplCopyWith<$Res> {
  factory _$$RateHourChangedImplCopyWith(_$RateHourChangedImpl value,
          $Res Function(_$RateHourChangedImpl) then) =
      __$$RateHourChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String rateHour});
}

/// @nodoc
class __$$RateHourChangedImplCopyWithImpl<$Res>
    extends _$HealthcarePostEventCopyWithImpl<$Res, _$RateHourChangedImpl>
    implements _$$RateHourChangedImplCopyWith<$Res> {
  __$$RateHourChangedImplCopyWithImpl(
      _$RateHourChangedImpl _value, $Res Function(_$RateHourChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rateHour = null,
  }) {
    return _then(_$RateHourChangedImpl(
      null == rateHour
          ? _value.rateHour
          : rateHour // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RateHourChangedImpl implements RateHourChanged {
  const _$RateHourChangedImpl(this.rateHour);

  @override
  final String rateHour;

  @override
  String toString() {
    return 'HealthcarePostEvent.rateHourChanged(rateHour: $rateHour)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RateHourChangedImpl &&
            (identical(other.rateHour, rateHour) ||
                other.rateHour == rateHour));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rateHour);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RateHourChangedImplCopyWith<_$RateHourChangedImpl> get copyWith =>
      __$$RateHourChangedImplCopyWithImpl<_$RateHourChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String roleType) roleTypeChanged,
    required TResult Function(String language) selectedLanguageChanged,
    required TResult Function(String location) locationChanged,
    required TResult Function(String selectedUnit) locationUnitSelectionChanged,
    required TResult Function(String rateHour) rateHourChanged,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addRequiredSpecialitichips,
    required TResult Function(String selectedValue)
        removeRequiredSpecialitichips,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addPreferedSoftwareSkillchips,
    required TResult Function(String selectedValue)
        removePreferedSoftwareSkillchips,
    required TResult Function() continueBtnPressed,
  }) {
    return rateHourChanged(rateHour);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String roleType)? roleTypeChanged,
    TResult? Function(String language)? selectedLanguageChanged,
    TResult? Function(String location)? locationChanged,
    TResult? Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult? Function(String rateHour)? rateHourChanged,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult? Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult? Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult? Function()? continueBtnPressed,
  }) {
    return rateHourChanged?.call(rateHour);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String roleType)? roleTypeChanged,
    TResult Function(String language)? selectedLanguageChanged,
    TResult Function(String location)? locationChanged,
    TResult Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult Function(String rateHour)? rateHourChanged,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult Function()? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (rateHourChanged != null) {
      return rateHourChanged(rateHour);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoleTypeChanged value) roleTypeChanged,
    required TResult Function(SelectedLanguageChanged value)
        selectedLanguageChanged,
    required TResult Function(LocationChanged value) locationChanged,
    required TResult Function(LocationUnitSelectionChanged value)
        locationUnitSelectionChanged,
    required TResult Function(RateHourChanged value) rateHourChanged,
    required TResult Function(AddRequiredSpecialitichips value)
        addRequiredSpecialitichips,
    required TResult Function(RemoveRequiredSpecialitichips value)
        removeRequiredSpecialitichips,
    required TResult Function(AddPreferedSoftwareSkillchips value)
        addPreferedSoftwareSkillchips,
    required TResult Function(RemovePreferedSoftwareSkillchips value)
        removePreferedSoftwareSkillchips,
    required TResult Function(ContinueBtnPressed value) continueBtnPressed,
  }) {
    return rateHourChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoleTypeChanged value)? roleTypeChanged,
    TResult? Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult? Function(LocationChanged value)? locationChanged,
    TResult? Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult? Function(RateHourChanged value)? rateHourChanged,
    TResult? Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult? Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult? Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult? Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult? Function(ContinueBtnPressed value)? continueBtnPressed,
  }) {
    return rateHourChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoleTypeChanged value)? roleTypeChanged,
    TResult Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult Function(LocationChanged value)? locationChanged,
    TResult Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult Function(RateHourChanged value)? rateHourChanged,
    TResult Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult Function(ContinueBtnPressed value)? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (rateHourChanged != null) {
      return rateHourChanged(this);
    }
    return orElse();
  }
}

abstract class RateHourChanged implements HealthcarePostEvent {
  const factory RateHourChanged(final String rateHour) = _$RateHourChangedImpl;

  String get rateHour;
  @JsonKey(ignore: true)
  _$$RateHourChangedImplCopyWith<_$RateHourChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddRequiredSpecialitichipsImplCopyWith<$Res> {
  factory _$$AddRequiredSpecialitichipsImplCopyWith(
          _$AddRequiredSpecialitichipsImpl value,
          $Res Function(_$AddRequiredSpecialitichipsImpl) then) =
      __$$AddRequiredSpecialitichipsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String selectedValue, bool? isOtherValue});
}

/// @nodoc
class __$$AddRequiredSpecialitichipsImplCopyWithImpl<$Res>
    extends _$HealthcarePostEventCopyWithImpl<$Res,
        _$AddRequiredSpecialitichipsImpl>
    implements _$$AddRequiredSpecialitichipsImplCopyWith<$Res> {
  __$$AddRequiredSpecialitichipsImplCopyWithImpl(
      _$AddRequiredSpecialitichipsImpl _value,
      $Res Function(_$AddRequiredSpecialitichipsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedValue = null,
    Object? isOtherValue = freezed,
  }) {
    return _then(_$AddRequiredSpecialitichipsImpl(
      null == selectedValue
          ? _value.selectedValue
          : selectedValue // ignore: cast_nullable_to_non_nullable
              as String,
      isOtherValue: freezed == isOtherValue
          ? _value.isOtherValue
          : isOtherValue // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$AddRequiredSpecialitichipsImpl implements AddRequiredSpecialitichips {
  const _$AddRequiredSpecialitichipsImpl(this.selectedValue,
      {this.isOtherValue});

  @override
  final String selectedValue;
  @override
  final bool? isOtherValue;

  @override
  String toString() {
    return 'HealthcarePostEvent.addRequiredSpecialitichips(selectedValue: $selectedValue, isOtherValue: $isOtherValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddRequiredSpecialitichipsImpl &&
            (identical(other.selectedValue, selectedValue) ||
                other.selectedValue == selectedValue) &&
            (identical(other.isOtherValue, isOtherValue) ||
                other.isOtherValue == isOtherValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedValue, isOtherValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddRequiredSpecialitichipsImplCopyWith<_$AddRequiredSpecialitichipsImpl>
      get copyWith => __$$AddRequiredSpecialitichipsImplCopyWithImpl<
          _$AddRequiredSpecialitichipsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String roleType) roleTypeChanged,
    required TResult Function(String language) selectedLanguageChanged,
    required TResult Function(String location) locationChanged,
    required TResult Function(String selectedUnit) locationUnitSelectionChanged,
    required TResult Function(String rateHour) rateHourChanged,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addRequiredSpecialitichips,
    required TResult Function(String selectedValue)
        removeRequiredSpecialitichips,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addPreferedSoftwareSkillchips,
    required TResult Function(String selectedValue)
        removePreferedSoftwareSkillchips,
    required TResult Function() continueBtnPressed,
  }) {
    return addRequiredSpecialitichips(selectedValue, isOtherValue);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String roleType)? roleTypeChanged,
    TResult? Function(String language)? selectedLanguageChanged,
    TResult? Function(String location)? locationChanged,
    TResult? Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult? Function(String rateHour)? rateHourChanged,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult? Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult? Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult? Function()? continueBtnPressed,
  }) {
    return addRequiredSpecialitichips?.call(selectedValue, isOtherValue);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String roleType)? roleTypeChanged,
    TResult Function(String language)? selectedLanguageChanged,
    TResult Function(String location)? locationChanged,
    TResult Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult Function(String rateHour)? rateHourChanged,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult Function()? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (addRequiredSpecialitichips != null) {
      return addRequiredSpecialitichips(selectedValue, isOtherValue);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoleTypeChanged value) roleTypeChanged,
    required TResult Function(SelectedLanguageChanged value)
        selectedLanguageChanged,
    required TResult Function(LocationChanged value) locationChanged,
    required TResult Function(LocationUnitSelectionChanged value)
        locationUnitSelectionChanged,
    required TResult Function(RateHourChanged value) rateHourChanged,
    required TResult Function(AddRequiredSpecialitichips value)
        addRequiredSpecialitichips,
    required TResult Function(RemoveRequiredSpecialitichips value)
        removeRequiredSpecialitichips,
    required TResult Function(AddPreferedSoftwareSkillchips value)
        addPreferedSoftwareSkillchips,
    required TResult Function(RemovePreferedSoftwareSkillchips value)
        removePreferedSoftwareSkillchips,
    required TResult Function(ContinueBtnPressed value) continueBtnPressed,
  }) {
    return addRequiredSpecialitichips(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoleTypeChanged value)? roleTypeChanged,
    TResult? Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult? Function(LocationChanged value)? locationChanged,
    TResult? Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult? Function(RateHourChanged value)? rateHourChanged,
    TResult? Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult? Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult? Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult? Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult? Function(ContinueBtnPressed value)? continueBtnPressed,
  }) {
    return addRequiredSpecialitichips?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoleTypeChanged value)? roleTypeChanged,
    TResult Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult Function(LocationChanged value)? locationChanged,
    TResult Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult Function(RateHourChanged value)? rateHourChanged,
    TResult Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult Function(ContinueBtnPressed value)? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (addRequiredSpecialitichips != null) {
      return addRequiredSpecialitichips(this);
    }
    return orElse();
  }
}

abstract class AddRequiredSpecialitichips implements HealthcarePostEvent {
  const factory AddRequiredSpecialitichips(final String selectedValue,
      {final bool? isOtherValue}) = _$AddRequiredSpecialitichipsImpl;

  String get selectedValue;
  bool? get isOtherValue;
  @JsonKey(ignore: true)
  _$$AddRequiredSpecialitichipsImplCopyWith<_$AddRequiredSpecialitichipsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveRequiredSpecialitichipsImplCopyWith<$Res> {
  factory _$$RemoveRequiredSpecialitichipsImplCopyWith(
          _$RemoveRequiredSpecialitichipsImpl value,
          $Res Function(_$RemoveRequiredSpecialitichipsImpl) then) =
      __$$RemoveRequiredSpecialitichipsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String selectedValue});
}

/// @nodoc
class __$$RemoveRequiredSpecialitichipsImplCopyWithImpl<$Res>
    extends _$HealthcarePostEventCopyWithImpl<$Res,
        _$RemoveRequiredSpecialitichipsImpl>
    implements _$$RemoveRequiredSpecialitichipsImplCopyWith<$Res> {
  __$$RemoveRequiredSpecialitichipsImplCopyWithImpl(
      _$RemoveRequiredSpecialitichipsImpl _value,
      $Res Function(_$RemoveRequiredSpecialitichipsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedValue = null,
  }) {
    return _then(_$RemoveRequiredSpecialitichipsImpl(
      null == selectedValue
          ? _value.selectedValue
          : selectedValue // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RemoveRequiredSpecialitichipsImpl
    implements RemoveRequiredSpecialitichips {
  const _$RemoveRequiredSpecialitichipsImpl(this.selectedValue);

  @override
  final String selectedValue;

  @override
  String toString() {
    return 'HealthcarePostEvent.removeRequiredSpecialitichips(selectedValue: $selectedValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveRequiredSpecialitichipsImpl &&
            (identical(other.selectedValue, selectedValue) ||
                other.selectedValue == selectedValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveRequiredSpecialitichipsImplCopyWith<
          _$RemoveRequiredSpecialitichipsImpl>
      get copyWith => __$$RemoveRequiredSpecialitichipsImplCopyWithImpl<
          _$RemoveRequiredSpecialitichipsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String roleType) roleTypeChanged,
    required TResult Function(String language) selectedLanguageChanged,
    required TResult Function(String location) locationChanged,
    required TResult Function(String selectedUnit) locationUnitSelectionChanged,
    required TResult Function(String rateHour) rateHourChanged,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addRequiredSpecialitichips,
    required TResult Function(String selectedValue)
        removeRequiredSpecialitichips,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addPreferedSoftwareSkillchips,
    required TResult Function(String selectedValue)
        removePreferedSoftwareSkillchips,
    required TResult Function() continueBtnPressed,
  }) {
    return removeRequiredSpecialitichips(selectedValue);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String roleType)? roleTypeChanged,
    TResult? Function(String language)? selectedLanguageChanged,
    TResult? Function(String location)? locationChanged,
    TResult? Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult? Function(String rateHour)? rateHourChanged,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult? Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult? Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult? Function()? continueBtnPressed,
  }) {
    return removeRequiredSpecialitichips?.call(selectedValue);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String roleType)? roleTypeChanged,
    TResult Function(String language)? selectedLanguageChanged,
    TResult Function(String location)? locationChanged,
    TResult Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult Function(String rateHour)? rateHourChanged,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult Function()? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (removeRequiredSpecialitichips != null) {
      return removeRequiredSpecialitichips(selectedValue);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoleTypeChanged value) roleTypeChanged,
    required TResult Function(SelectedLanguageChanged value)
        selectedLanguageChanged,
    required TResult Function(LocationChanged value) locationChanged,
    required TResult Function(LocationUnitSelectionChanged value)
        locationUnitSelectionChanged,
    required TResult Function(RateHourChanged value) rateHourChanged,
    required TResult Function(AddRequiredSpecialitichips value)
        addRequiredSpecialitichips,
    required TResult Function(RemoveRequiredSpecialitichips value)
        removeRequiredSpecialitichips,
    required TResult Function(AddPreferedSoftwareSkillchips value)
        addPreferedSoftwareSkillchips,
    required TResult Function(RemovePreferedSoftwareSkillchips value)
        removePreferedSoftwareSkillchips,
    required TResult Function(ContinueBtnPressed value) continueBtnPressed,
  }) {
    return removeRequiredSpecialitichips(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoleTypeChanged value)? roleTypeChanged,
    TResult? Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult? Function(LocationChanged value)? locationChanged,
    TResult? Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult? Function(RateHourChanged value)? rateHourChanged,
    TResult? Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult? Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult? Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult? Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult? Function(ContinueBtnPressed value)? continueBtnPressed,
  }) {
    return removeRequiredSpecialitichips?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoleTypeChanged value)? roleTypeChanged,
    TResult Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult Function(LocationChanged value)? locationChanged,
    TResult Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult Function(RateHourChanged value)? rateHourChanged,
    TResult Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult Function(ContinueBtnPressed value)? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (removeRequiredSpecialitichips != null) {
      return removeRequiredSpecialitichips(this);
    }
    return orElse();
  }
}

abstract class RemoveRequiredSpecialitichips implements HealthcarePostEvent {
  const factory RemoveRequiredSpecialitichips(final String selectedValue) =
      _$RemoveRequiredSpecialitichipsImpl;

  String get selectedValue;
  @JsonKey(ignore: true)
  _$$RemoveRequiredSpecialitichipsImplCopyWith<
          _$RemoveRequiredSpecialitichipsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddPreferedSoftwareSkillchipsImplCopyWith<$Res> {
  factory _$$AddPreferedSoftwareSkillchipsImplCopyWith(
          _$AddPreferedSoftwareSkillchipsImpl value,
          $Res Function(_$AddPreferedSoftwareSkillchipsImpl) then) =
      __$$AddPreferedSoftwareSkillchipsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String selectedValue, bool? isOtherValue});
}

/// @nodoc
class __$$AddPreferedSoftwareSkillchipsImplCopyWithImpl<$Res>
    extends _$HealthcarePostEventCopyWithImpl<$Res,
        _$AddPreferedSoftwareSkillchipsImpl>
    implements _$$AddPreferedSoftwareSkillchipsImplCopyWith<$Res> {
  __$$AddPreferedSoftwareSkillchipsImplCopyWithImpl(
      _$AddPreferedSoftwareSkillchipsImpl _value,
      $Res Function(_$AddPreferedSoftwareSkillchipsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedValue = null,
    Object? isOtherValue = freezed,
  }) {
    return _then(_$AddPreferedSoftwareSkillchipsImpl(
      null == selectedValue
          ? _value.selectedValue
          : selectedValue // ignore: cast_nullable_to_non_nullable
              as String,
      isOtherValue: freezed == isOtherValue
          ? _value.isOtherValue
          : isOtherValue // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$AddPreferedSoftwareSkillchipsImpl
    implements AddPreferedSoftwareSkillchips {
  const _$AddPreferedSoftwareSkillchipsImpl(this.selectedValue,
      {this.isOtherValue});

  @override
  final String selectedValue;
  @override
  final bool? isOtherValue;

  @override
  String toString() {
    return 'HealthcarePostEvent.addPreferedSoftwareSkillchips(selectedValue: $selectedValue, isOtherValue: $isOtherValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddPreferedSoftwareSkillchipsImpl &&
            (identical(other.selectedValue, selectedValue) ||
                other.selectedValue == selectedValue) &&
            (identical(other.isOtherValue, isOtherValue) ||
                other.isOtherValue == isOtherValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedValue, isOtherValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddPreferedSoftwareSkillchipsImplCopyWith<
          _$AddPreferedSoftwareSkillchipsImpl>
      get copyWith => __$$AddPreferedSoftwareSkillchipsImplCopyWithImpl<
          _$AddPreferedSoftwareSkillchipsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String roleType) roleTypeChanged,
    required TResult Function(String language) selectedLanguageChanged,
    required TResult Function(String location) locationChanged,
    required TResult Function(String selectedUnit) locationUnitSelectionChanged,
    required TResult Function(String rateHour) rateHourChanged,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addRequiredSpecialitichips,
    required TResult Function(String selectedValue)
        removeRequiredSpecialitichips,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addPreferedSoftwareSkillchips,
    required TResult Function(String selectedValue)
        removePreferedSoftwareSkillchips,
    required TResult Function() continueBtnPressed,
  }) {
    return addPreferedSoftwareSkillchips(selectedValue, isOtherValue);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String roleType)? roleTypeChanged,
    TResult? Function(String language)? selectedLanguageChanged,
    TResult? Function(String location)? locationChanged,
    TResult? Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult? Function(String rateHour)? rateHourChanged,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult? Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult? Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult? Function()? continueBtnPressed,
  }) {
    return addPreferedSoftwareSkillchips?.call(selectedValue, isOtherValue);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String roleType)? roleTypeChanged,
    TResult Function(String language)? selectedLanguageChanged,
    TResult Function(String location)? locationChanged,
    TResult Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult Function(String rateHour)? rateHourChanged,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult Function()? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (addPreferedSoftwareSkillchips != null) {
      return addPreferedSoftwareSkillchips(selectedValue, isOtherValue);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoleTypeChanged value) roleTypeChanged,
    required TResult Function(SelectedLanguageChanged value)
        selectedLanguageChanged,
    required TResult Function(LocationChanged value) locationChanged,
    required TResult Function(LocationUnitSelectionChanged value)
        locationUnitSelectionChanged,
    required TResult Function(RateHourChanged value) rateHourChanged,
    required TResult Function(AddRequiredSpecialitichips value)
        addRequiredSpecialitichips,
    required TResult Function(RemoveRequiredSpecialitichips value)
        removeRequiredSpecialitichips,
    required TResult Function(AddPreferedSoftwareSkillchips value)
        addPreferedSoftwareSkillchips,
    required TResult Function(RemovePreferedSoftwareSkillchips value)
        removePreferedSoftwareSkillchips,
    required TResult Function(ContinueBtnPressed value) continueBtnPressed,
  }) {
    return addPreferedSoftwareSkillchips(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoleTypeChanged value)? roleTypeChanged,
    TResult? Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult? Function(LocationChanged value)? locationChanged,
    TResult? Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult? Function(RateHourChanged value)? rateHourChanged,
    TResult? Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult? Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult? Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult? Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult? Function(ContinueBtnPressed value)? continueBtnPressed,
  }) {
    return addPreferedSoftwareSkillchips?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoleTypeChanged value)? roleTypeChanged,
    TResult Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult Function(LocationChanged value)? locationChanged,
    TResult Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult Function(RateHourChanged value)? rateHourChanged,
    TResult Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult Function(ContinueBtnPressed value)? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (addPreferedSoftwareSkillchips != null) {
      return addPreferedSoftwareSkillchips(this);
    }
    return orElse();
  }
}

abstract class AddPreferedSoftwareSkillchips implements HealthcarePostEvent {
  const factory AddPreferedSoftwareSkillchips(final String selectedValue,
      {final bool? isOtherValue}) = _$AddPreferedSoftwareSkillchipsImpl;

  String get selectedValue;
  bool? get isOtherValue;
  @JsonKey(ignore: true)
  _$$AddPreferedSoftwareSkillchipsImplCopyWith<
          _$AddPreferedSoftwareSkillchipsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemovePreferedSoftwareSkillchipsImplCopyWith<$Res> {
  factory _$$RemovePreferedSoftwareSkillchipsImplCopyWith(
          _$RemovePreferedSoftwareSkillchipsImpl value,
          $Res Function(_$RemovePreferedSoftwareSkillchipsImpl) then) =
      __$$RemovePreferedSoftwareSkillchipsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String selectedValue});
}

/// @nodoc
class __$$RemovePreferedSoftwareSkillchipsImplCopyWithImpl<$Res>
    extends _$HealthcarePostEventCopyWithImpl<$Res,
        _$RemovePreferedSoftwareSkillchipsImpl>
    implements _$$RemovePreferedSoftwareSkillchipsImplCopyWith<$Res> {
  __$$RemovePreferedSoftwareSkillchipsImplCopyWithImpl(
      _$RemovePreferedSoftwareSkillchipsImpl _value,
      $Res Function(_$RemovePreferedSoftwareSkillchipsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedValue = null,
  }) {
    return _then(_$RemovePreferedSoftwareSkillchipsImpl(
      null == selectedValue
          ? _value.selectedValue
          : selectedValue // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RemovePreferedSoftwareSkillchipsImpl
    implements RemovePreferedSoftwareSkillchips {
  const _$RemovePreferedSoftwareSkillchipsImpl(this.selectedValue);

  @override
  final String selectedValue;

  @override
  String toString() {
    return 'HealthcarePostEvent.removePreferedSoftwareSkillchips(selectedValue: $selectedValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemovePreferedSoftwareSkillchipsImpl &&
            (identical(other.selectedValue, selectedValue) ||
                other.selectedValue == selectedValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemovePreferedSoftwareSkillchipsImplCopyWith<
          _$RemovePreferedSoftwareSkillchipsImpl>
      get copyWith => __$$RemovePreferedSoftwareSkillchipsImplCopyWithImpl<
          _$RemovePreferedSoftwareSkillchipsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String roleType) roleTypeChanged,
    required TResult Function(String language) selectedLanguageChanged,
    required TResult Function(String location) locationChanged,
    required TResult Function(String selectedUnit) locationUnitSelectionChanged,
    required TResult Function(String rateHour) rateHourChanged,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addRequiredSpecialitichips,
    required TResult Function(String selectedValue)
        removeRequiredSpecialitichips,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addPreferedSoftwareSkillchips,
    required TResult Function(String selectedValue)
        removePreferedSoftwareSkillchips,
    required TResult Function() continueBtnPressed,
  }) {
    return removePreferedSoftwareSkillchips(selectedValue);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String roleType)? roleTypeChanged,
    TResult? Function(String language)? selectedLanguageChanged,
    TResult? Function(String location)? locationChanged,
    TResult? Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult? Function(String rateHour)? rateHourChanged,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult? Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult? Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult? Function()? continueBtnPressed,
  }) {
    return removePreferedSoftwareSkillchips?.call(selectedValue);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String roleType)? roleTypeChanged,
    TResult Function(String language)? selectedLanguageChanged,
    TResult Function(String location)? locationChanged,
    TResult Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult Function(String rateHour)? rateHourChanged,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult Function()? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (removePreferedSoftwareSkillchips != null) {
      return removePreferedSoftwareSkillchips(selectedValue);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoleTypeChanged value) roleTypeChanged,
    required TResult Function(SelectedLanguageChanged value)
        selectedLanguageChanged,
    required TResult Function(LocationChanged value) locationChanged,
    required TResult Function(LocationUnitSelectionChanged value)
        locationUnitSelectionChanged,
    required TResult Function(RateHourChanged value) rateHourChanged,
    required TResult Function(AddRequiredSpecialitichips value)
        addRequiredSpecialitichips,
    required TResult Function(RemoveRequiredSpecialitichips value)
        removeRequiredSpecialitichips,
    required TResult Function(AddPreferedSoftwareSkillchips value)
        addPreferedSoftwareSkillchips,
    required TResult Function(RemovePreferedSoftwareSkillchips value)
        removePreferedSoftwareSkillchips,
    required TResult Function(ContinueBtnPressed value) continueBtnPressed,
  }) {
    return removePreferedSoftwareSkillchips(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoleTypeChanged value)? roleTypeChanged,
    TResult? Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult? Function(LocationChanged value)? locationChanged,
    TResult? Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult? Function(RateHourChanged value)? rateHourChanged,
    TResult? Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult? Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult? Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult? Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult? Function(ContinueBtnPressed value)? continueBtnPressed,
  }) {
    return removePreferedSoftwareSkillchips?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoleTypeChanged value)? roleTypeChanged,
    TResult Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult Function(LocationChanged value)? locationChanged,
    TResult Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult Function(RateHourChanged value)? rateHourChanged,
    TResult Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult Function(ContinueBtnPressed value)? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (removePreferedSoftwareSkillchips != null) {
      return removePreferedSoftwareSkillchips(this);
    }
    return orElse();
  }
}

abstract class RemovePreferedSoftwareSkillchips implements HealthcarePostEvent {
  const factory RemovePreferedSoftwareSkillchips(final String selectedValue) =
      _$RemovePreferedSoftwareSkillchipsImpl;

  String get selectedValue;
  @JsonKey(ignore: true)
  _$$RemovePreferedSoftwareSkillchipsImplCopyWith<
          _$RemovePreferedSoftwareSkillchipsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContinueBtnPressedImplCopyWith<$Res> {
  factory _$$ContinueBtnPressedImplCopyWith(_$ContinueBtnPressedImpl value,
          $Res Function(_$ContinueBtnPressedImpl) then) =
      __$$ContinueBtnPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ContinueBtnPressedImplCopyWithImpl<$Res>
    extends _$HealthcarePostEventCopyWithImpl<$Res, _$ContinueBtnPressedImpl>
    implements _$$ContinueBtnPressedImplCopyWith<$Res> {
  __$$ContinueBtnPressedImplCopyWithImpl(_$ContinueBtnPressedImpl _value,
      $Res Function(_$ContinueBtnPressedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ContinueBtnPressedImpl implements ContinueBtnPressed {
  const _$ContinueBtnPressedImpl();

  @override
  String toString() {
    return 'HealthcarePostEvent.continueBtnPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ContinueBtnPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String roleType) roleTypeChanged,
    required TResult Function(String language) selectedLanguageChanged,
    required TResult Function(String location) locationChanged,
    required TResult Function(String selectedUnit) locationUnitSelectionChanged,
    required TResult Function(String rateHour) rateHourChanged,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addRequiredSpecialitichips,
    required TResult Function(String selectedValue)
        removeRequiredSpecialitichips,
    required TResult Function(String selectedValue, bool? isOtherValue)
        addPreferedSoftwareSkillchips,
    required TResult Function(String selectedValue)
        removePreferedSoftwareSkillchips,
    required TResult Function() continueBtnPressed,
  }) {
    return continueBtnPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String roleType)? roleTypeChanged,
    TResult? Function(String language)? selectedLanguageChanged,
    TResult? Function(String location)? locationChanged,
    TResult? Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult? Function(String rateHour)? rateHourChanged,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult? Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult? Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult? Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult? Function()? continueBtnPressed,
  }) {
    return continueBtnPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String roleType)? roleTypeChanged,
    TResult Function(String language)? selectedLanguageChanged,
    TResult Function(String location)? locationChanged,
    TResult Function(String selectedUnit)? locationUnitSelectionChanged,
    TResult Function(String rateHour)? rateHourChanged,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addRequiredSpecialitichips,
    TResult Function(String selectedValue)? removeRequiredSpecialitichips,
    TResult Function(String selectedValue, bool? isOtherValue)?
        addPreferedSoftwareSkillchips,
    TResult Function(String selectedValue)? removePreferedSoftwareSkillchips,
    TResult Function()? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (continueBtnPressed != null) {
      return continueBtnPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoleTypeChanged value) roleTypeChanged,
    required TResult Function(SelectedLanguageChanged value)
        selectedLanguageChanged,
    required TResult Function(LocationChanged value) locationChanged,
    required TResult Function(LocationUnitSelectionChanged value)
        locationUnitSelectionChanged,
    required TResult Function(RateHourChanged value) rateHourChanged,
    required TResult Function(AddRequiredSpecialitichips value)
        addRequiredSpecialitichips,
    required TResult Function(RemoveRequiredSpecialitichips value)
        removeRequiredSpecialitichips,
    required TResult Function(AddPreferedSoftwareSkillchips value)
        addPreferedSoftwareSkillchips,
    required TResult Function(RemovePreferedSoftwareSkillchips value)
        removePreferedSoftwareSkillchips,
    required TResult Function(ContinueBtnPressed value) continueBtnPressed,
  }) {
    return continueBtnPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoleTypeChanged value)? roleTypeChanged,
    TResult? Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult? Function(LocationChanged value)? locationChanged,
    TResult? Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult? Function(RateHourChanged value)? rateHourChanged,
    TResult? Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult? Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult? Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult? Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult? Function(ContinueBtnPressed value)? continueBtnPressed,
  }) {
    return continueBtnPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoleTypeChanged value)? roleTypeChanged,
    TResult Function(SelectedLanguageChanged value)? selectedLanguageChanged,
    TResult Function(LocationChanged value)? locationChanged,
    TResult Function(LocationUnitSelectionChanged value)?
        locationUnitSelectionChanged,
    TResult Function(RateHourChanged value)? rateHourChanged,
    TResult Function(AddRequiredSpecialitichips value)?
        addRequiredSpecialitichips,
    TResult Function(RemoveRequiredSpecialitichips value)?
        removeRequiredSpecialitichips,
    TResult Function(AddPreferedSoftwareSkillchips value)?
        addPreferedSoftwareSkillchips,
    TResult Function(RemovePreferedSoftwareSkillchips value)?
        removePreferedSoftwareSkillchips,
    TResult Function(ContinueBtnPressed value)? continueBtnPressed,
    required TResult orElse(),
  }) {
    if (continueBtnPressed != null) {
      return continueBtnPressed(this);
    }
    return orElse();
  }
}

abstract class ContinueBtnPressed implements HealthcarePostEvent {
  const factory ContinueBtnPressed() = _$ContinueBtnPressedImpl;
}

/// @nodoc
mixin _$HealthcarePostState {
  InputEmptyOrNot get location => throw _privateConstructorUsedError;
  InputEmptyOrNot get rateHour => throw _privateConstructorUsedError;
  InputEmptyOrNot get roleType => throw _privateConstructorUsedError;
  InputEmptyOrNot get selectedLanguage => throw _privateConstructorUsedError;
  String get requiredSpecialityChip => throw _privateConstructorUsedError;
  String get selectedLocationUnit => throw _privateConstructorUsedError;
  List<String> get requiredSpecialityChipList =>
      throw _privateConstructorUsedError;

  ///
  String get requiredSoftwareSkillChip => throw _privateConstructorUsedError;
  List<String> get requiredSoftwareSkillChipList =>
      throw _privateConstructorUsedError;

  ///
  bool get isSubmitting => throw _privateConstructorUsedError;
  bool get showErrorMessages => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HealthcarePostStateCopyWith<HealthcarePostState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthcarePostStateCopyWith<$Res> {
  factory $HealthcarePostStateCopyWith(
          HealthcarePostState value, $Res Function(HealthcarePostState) then) =
      _$HealthcarePostStateCopyWithImpl<$Res, HealthcarePostState>;
  @useResult
  $Res call(
      {InputEmptyOrNot location,
      InputEmptyOrNot rateHour,
      InputEmptyOrNot roleType,
      InputEmptyOrNot selectedLanguage,
      String requiredSpecialityChip,
      String selectedLocationUnit,
      List<String> requiredSpecialityChipList,
      String requiredSoftwareSkillChip,
      List<String> requiredSoftwareSkillChipList,
      bool isSubmitting,
      bool showErrorMessages,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption});
}

/// @nodoc
class _$HealthcarePostStateCopyWithImpl<$Res, $Val extends HealthcarePostState>
    implements $HealthcarePostStateCopyWith<$Res> {
  _$HealthcarePostStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? rateHour = null,
    Object? roleType = null,
    Object? selectedLanguage = null,
    Object? requiredSpecialityChip = null,
    Object? selectedLocationUnit = null,
    Object? requiredSpecialityChipList = null,
    Object? requiredSoftwareSkillChip = null,
    Object? requiredSoftwareSkillChipList = null,
    Object? isSubmitting = null,
    Object? showErrorMessages = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_value.copyWith(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      rateHour: null == rateHour
          ? _value.rateHour
          : rateHour // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      roleType: null == roleType
          ? _value.roleType
          : roleType // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      selectedLanguage: null == selectedLanguage
          ? _value.selectedLanguage
          : selectedLanguage // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      requiredSpecialityChip: null == requiredSpecialityChip
          ? _value.requiredSpecialityChip
          : requiredSpecialityChip // ignore: cast_nullable_to_non_nullable
              as String,
      selectedLocationUnit: null == selectedLocationUnit
          ? _value.selectedLocationUnit
          : selectedLocationUnit // ignore: cast_nullable_to_non_nullable
              as String,
      requiredSpecialityChipList: null == requiredSpecialityChipList
          ? _value.requiredSpecialityChipList
          : requiredSpecialityChipList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      requiredSoftwareSkillChip: null == requiredSoftwareSkillChip
          ? _value.requiredSoftwareSkillChip
          : requiredSoftwareSkillChip // ignore: cast_nullable_to_non_nullable
              as String,
      requiredSoftwareSkillChipList: null == requiredSoftwareSkillChipList
          ? _value.requiredSoftwareSkillChipList
          : requiredSoftwareSkillChipList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthcarePostStateImplCopyWith<$Res>
    implements $HealthcarePostStateCopyWith<$Res> {
  factory _$$HealthcarePostStateImplCopyWith(_$HealthcarePostStateImpl value,
          $Res Function(_$HealthcarePostStateImpl) then) =
      __$$HealthcarePostStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {InputEmptyOrNot location,
      InputEmptyOrNot rateHour,
      InputEmptyOrNot roleType,
      InputEmptyOrNot selectedLanguage,
      String requiredSpecialityChip,
      String selectedLocationUnit,
      List<String> requiredSpecialityChipList,
      String requiredSoftwareSkillChip,
      List<String> requiredSoftwareSkillChipList,
      bool isSubmitting,
      bool showErrorMessages,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption});
}

/// @nodoc
class __$$HealthcarePostStateImplCopyWithImpl<$Res>
    extends _$HealthcarePostStateCopyWithImpl<$Res, _$HealthcarePostStateImpl>
    implements _$$HealthcarePostStateImplCopyWith<$Res> {
  __$$HealthcarePostStateImplCopyWithImpl(_$HealthcarePostStateImpl _value,
      $Res Function(_$HealthcarePostStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? rateHour = null,
    Object? roleType = null,
    Object? selectedLanguage = null,
    Object? requiredSpecialityChip = null,
    Object? selectedLocationUnit = null,
    Object? requiredSpecialityChipList = null,
    Object? requiredSoftwareSkillChip = null,
    Object? requiredSoftwareSkillChipList = null,
    Object? isSubmitting = null,
    Object? showErrorMessages = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_$HealthcarePostStateImpl(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      rateHour: null == rateHour
          ? _value.rateHour
          : rateHour // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      roleType: null == roleType
          ? _value.roleType
          : roleType // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      selectedLanguage: null == selectedLanguage
          ? _value.selectedLanguage
          : selectedLanguage // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      requiredSpecialityChip: null == requiredSpecialityChip
          ? _value.requiredSpecialityChip
          : requiredSpecialityChip // ignore: cast_nullable_to_non_nullable
              as String,
      selectedLocationUnit: null == selectedLocationUnit
          ? _value.selectedLocationUnit
          : selectedLocationUnit // ignore: cast_nullable_to_non_nullable
              as String,
      requiredSpecialityChipList: null == requiredSpecialityChipList
          ? _value._requiredSpecialityChipList
          : requiredSpecialityChipList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      requiredSoftwareSkillChip: null == requiredSoftwareSkillChip
          ? _value.requiredSoftwareSkillChip
          : requiredSoftwareSkillChip // ignore: cast_nullable_to_non_nullable
              as String,
      requiredSoftwareSkillChipList: null == requiredSoftwareSkillChipList
          ? _value._requiredSoftwareSkillChipList
          : requiredSoftwareSkillChipList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
    ));
  }
}

/// @nodoc

class _$HealthcarePostStateImpl implements _HealthcarePostState {
  const _$HealthcarePostStateImpl(
      {required this.location,
      required this.rateHour,
      required this.roleType,
      required this.selectedLanguage,
      required this.requiredSpecialityChip,
      required this.selectedLocationUnit,
      required final List<String> requiredSpecialityChipList,
      required this.requiredSoftwareSkillChip,
      required final List<String> requiredSoftwareSkillChipList,
      required this.isSubmitting,
      required this.showErrorMessages,
      required this.authFailureOrSuccessOption})
      : _requiredSpecialityChipList = requiredSpecialityChipList,
        _requiredSoftwareSkillChipList = requiredSoftwareSkillChipList;

  @override
  final InputEmptyOrNot location;
  @override
  final InputEmptyOrNot rateHour;
  @override
  final InputEmptyOrNot roleType;
  @override
  final InputEmptyOrNot selectedLanguage;
  @override
  final String requiredSpecialityChip;
  @override
  final String selectedLocationUnit;
  final List<String> _requiredSpecialityChipList;
  @override
  List<String> get requiredSpecialityChipList {
    if (_requiredSpecialityChipList is EqualUnmodifiableListView)
      return _requiredSpecialityChipList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredSpecialityChipList);
  }

  ///
  @override
  final String requiredSoftwareSkillChip;
  final List<String> _requiredSoftwareSkillChipList;
  @override
  List<String> get requiredSoftwareSkillChipList {
    if (_requiredSoftwareSkillChipList is EqualUnmodifiableListView)
      return _requiredSoftwareSkillChipList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredSoftwareSkillChipList);
  }

  ///
  @override
  final bool isSubmitting;
  @override
  final bool showErrorMessages;
  @override
  final Option<Either<AuthFailure, String>> authFailureOrSuccessOption;

  @override
  String toString() {
    return 'HealthcarePostState(location: $location, rateHour: $rateHour, roleType: $roleType, selectedLanguage: $selectedLanguage, requiredSpecialityChip: $requiredSpecialityChip, selectedLocationUnit: $selectedLocationUnit, requiredSpecialityChipList: $requiredSpecialityChipList, requiredSoftwareSkillChip: $requiredSoftwareSkillChip, requiredSoftwareSkillChipList: $requiredSoftwareSkillChipList, isSubmitting: $isSubmitting, showErrorMessages: $showErrorMessages, authFailureOrSuccessOption: $authFailureOrSuccessOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthcarePostStateImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.rateHour, rateHour) ||
                other.rateHour == rateHour) &&
            (identical(other.roleType, roleType) ||
                other.roleType == roleType) &&
            (identical(other.selectedLanguage, selectedLanguage) ||
                other.selectedLanguage == selectedLanguage) &&
            (identical(other.requiredSpecialityChip, requiredSpecialityChip) ||
                other.requiredSpecialityChip == requiredSpecialityChip) &&
            (identical(other.selectedLocationUnit, selectedLocationUnit) ||
                other.selectedLocationUnit == selectedLocationUnit) &&
            const DeepCollectionEquality().equals(
                other._requiredSpecialityChipList,
                _requiredSpecialityChipList) &&
            (identical(other.requiredSoftwareSkillChip,
                    requiredSoftwareSkillChip) ||
                other.requiredSoftwareSkillChip == requiredSoftwareSkillChip) &&
            const DeepCollectionEquality().equals(
                other._requiredSoftwareSkillChipList,
                _requiredSoftwareSkillChipList) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                other.showErrorMessages == showErrorMessages) &&
            (identical(other.authFailureOrSuccessOption,
                    authFailureOrSuccessOption) ||
                other.authFailureOrSuccessOption ==
                    authFailureOrSuccessOption));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      location,
      rateHour,
      roleType,
      selectedLanguage,
      requiredSpecialityChip,
      selectedLocationUnit,
      const DeepCollectionEquality().hash(_requiredSpecialityChipList),
      requiredSoftwareSkillChip,
      const DeepCollectionEquality().hash(_requiredSoftwareSkillChipList),
      isSubmitting,
      showErrorMessages,
      authFailureOrSuccessOption);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthcarePostStateImplCopyWith<_$HealthcarePostStateImpl> get copyWith =>
      __$$HealthcarePostStateImplCopyWithImpl<_$HealthcarePostStateImpl>(
          this, _$identity);
}

abstract class _HealthcarePostState implements HealthcarePostState {
  const factory _HealthcarePostState(
      {required final InputEmptyOrNot location,
      required final InputEmptyOrNot rateHour,
      required final InputEmptyOrNot roleType,
      required final InputEmptyOrNot selectedLanguage,
      required final String requiredSpecialityChip,
      required final String selectedLocationUnit,
      required final List<String> requiredSpecialityChipList,
      required final String requiredSoftwareSkillChip,
      required final List<String> requiredSoftwareSkillChipList,
      required final bool isSubmitting,
      required final bool showErrorMessages,
      required final Option<Either<AuthFailure, String>>
          authFailureOrSuccessOption}) = _$HealthcarePostStateImpl;

  @override
  InputEmptyOrNot get location;
  @override
  InputEmptyOrNot get rateHour;
  @override
  InputEmptyOrNot get roleType;
  @override
  InputEmptyOrNot get selectedLanguage;
  @override
  String get requiredSpecialityChip;
  @override
  String get selectedLocationUnit;
  @override
  List<String> get requiredSpecialityChipList;
  @override

  ///
  String get requiredSoftwareSkillChip;
  @override
  List<String> get requiredSoftwareSkillChipList;
  @override

  ///
  bool get isSubmitting;
  @override
  bool get showErrorMessages;
  @override
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption;
  @override
  @JsonKey(ignore: true)
  _$$HealthcarePostStateImplCopyWith<_$HealthcarePostStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
