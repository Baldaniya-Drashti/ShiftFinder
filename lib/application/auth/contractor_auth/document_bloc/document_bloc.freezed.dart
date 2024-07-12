// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DocumentEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) nextPage,
    required TResult Function(String govermentDoc) selectGovermentDoc,
    required TResult Function(String govermentDoc) deleteGovermentDoc,
    required TResult Function() govermentDocSubmit,
    required TResult Function(String covidDoc) selectCovidVaccinationDoc,
    required TResult Function(String covidDoc) deleteCovidDoc,
    required TResult Function() covidDocSubmit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? nextPage,
    TResult? Function(String govermentDoc)? selectGovermentDoc,
    TResult? Function(String govermentDoc)? deleteGovermentDoc,
    TResult? Function()? govermentDocSubmit,
    TResult? Function(String covidDoc)? selectCovidVaccinationDoc,
    TResult? Function(String covidDoc)? deleteCovidDoc,
    TResult? Function()? covidDocSubmit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? nextPage,
    TResult Function(String govermentDoc)? selectGovermentDoc,
    TResult Function(String govermentDoc)? deleteGovermentDoc,
    TResult Function()? govermentDocSubmit,
    TResult Function(String covidDoc)? selectCovidVaccinationDoc,
    TResult Function(String covidDoc)? deleteCovidDoc,
    TResult Function()? covidDocSubmit,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NextPage value) nextPage,
    required TResult Function(_SelectGovermentDoc value) selectGovermentDoc,
    required TResult Function(_DeleteGovermentDoc value) deleteGovermentDoc,
    required TResult Function(_GovermentDocSubmit value) govermentDocSubmit,
    required TResult Function(_SelectCovidVaccinationDoc value)
        selectCovidVaccinationDoc,
    required TResult Function(_DeleteCovidDoc value) deleteCovidDoc,
    required TResult Function(_CovidDocSubmit value) covidDocSubmit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NextPage value)? nextPage,
    TResult? Function(_SelectGovermentDoc value)? selectGovermentDoc,
    TResult? Function(_DeleteGovermentDoc value)? deleteGovermentDoc,
    TResult? Function(_GovermentDocSubmit value)? govermentDocSubmit,
    TResult? Function(_SelectCovidVaccinationDoc value)?
        selectCovidVaccinationDoc,
    TResult? Function(_DeleteCovidDoc value)? deleteCovidDoc,
    TResult? Function(_CovidDocSubmit value)? covidDocSubmit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NextPage value)? nextPage,
    TResult Function(_SelectGovermentDoc value)? selectGovermentDoc,
    TResult Function(_DeleteGovermentDoc value)? deleteGovermentDoc,
    TResult Function(_GovermentDocSubmit value)? govermentDocSubmit,
    TResult Function(_SelectCovidVaccinationDoc value)?
        selectCovidVaccinationDoc,
    TResult Function(_DeleteCovidDoc value)? deleteCovidDoc,
    TResult Function(_CovidDocSubmit value)? covidDocSubmit,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentEventCopyWith<$Res> {
  factory $DocumentEventCopyWith(
          DocumentEvent value, $Res Function(DocumentEvent) then) =
      _$DocumentEventCopyWithImpl<$Res, DocumentEvent>;
}

/// @nodoc
class _$DocumentEventCopyWithImpl<$Res, $Val extends DocumentEvent>
    implements $DocumentEventCopyWith<$Res> {
  _$DocumentEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$NextPageImplCopyWith<$Res> {
  factory _$$NextPageImplCopyWith(
          _$NextPageImpl value, $Res Function(_$NextPageImpl) then) =
      __$$NextPageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int page});
}

/// @nodoc
class __$$NextPageImplCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$NextPageImpl>
    implements _$$NextPageImplCopyWith<$Res> {
  __$$NextPageImplCopyWithImpl(
      _$NextPageImpl _value, $Res Function(_$NextPageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
  }) {
    return _then(_$NextPageImpl(
      null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$NextPageImpl implements _NextPage {
  const _$NextPageImpl(this.page);

  @override
  final int page;

  @override
  String toString() {
    return 'DocumentEvent.nextPage(page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NextPageImpl &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(runtimeType, page);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NextPageImplCopyWith<_$NextPageImpl> get copyWith =>
      __$$NextPageImplCopyWithImpl<_$NextPageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) nextPage,
    required TResult Function(String govermentDoc) selectGovermentDoc,
    required TResult Function(String govermentDoc) deleteGovermentDoc,
    required TResult Function() govermentDocSubmit,
    required TResult Function(String covidDoc) selectCovidVaccinationDoc,
    required TResult Function(String covidDoc) deleteCovidDoc,
    required TResult Function() covidDocSubmit,
  }) {
    return nextPage(page);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? nextPage,
    TResult? Function(String govermentDoc)? selectGovermentDoc,
    TResult? Function(String govermentDoc)? deleteGovermentDoc,
    TResult? Function()? govermentDocSubmit,
    TResult? Function(String covidDoc)? selectCovidVaccinationDoc,
    TResult? Function(String covidDoc)? deleteCovidDoc,
    TResult? Function()? covidDocSubmit,
  }) {
    return nextPage?.call(page);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? nextPage,
    TResult Function(String govermentDoc)? selectGovermentDoc,
    TResult Function(String govermentDoc)? deleteGovermentDoc,
    TResult Function()? govermentDocSubmit,
    TResult Function(String covidDoc)? selectCovidVaccinationDoc,
    TResult Function(String covidDoc)? deleteCovidDoc,
    TResult Function()? covidDocSubmit,
    required TResult orElse(),
  }) {
    if (nextPage != null) {
      return nextPage(page);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NextPage value) nextPage,
    required TResult Function(_SelectGovermentDoc value) selectGovermentDoc,
    required TResult Function(_DeleteGovermentDoc value) deleteGovermentDoc,
    required TResult Function(_GovermentDocSubmit value) govermentDocSubmit,
    required TResult Function(_SelectCovidVaccinationDoc value)
        selectCovidVaccinationDoc,
    required TResult Function(_DeleteCovidDoc value) deleteCovidDoc,
    required TResult Function(_CovidDocSubmit value) covidDocSubmit,
  }) {
    return nextPage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NextPage value)? nextPage,
    TResult? Function(_SelectGovermentDoc value)? selectGovermentDoc,
    TResult? Function(_DeleteGovermentDoc value)? deleteGovermentDoc,
    TResult? Function(_GovermentDocSubmit value)? govermentDocSubmit,
    TResult? Function(_SelectCovidVaccinationDoc value)?
        selectCovidVaccinationDoc,
    TResult? Function(_DeleteCovidDoc value)? deleteCovidDoc,
    TResult? Function(_CovidDocSubmit value)? covidDocSubmit,
  }) {
    return nextPage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NextPage value)? nextPage,
    TResult Function(_SelectGovermentDoc value)? selectGovermentDoc,
    TResult Function(_DeleteGovermentDoc value)? deleteGovermentDoc,
    TResult Function(_GovermentDocSubmit value)? govermentDocSubmit,
    TResult Function(_SelectCovidVaccinationDoc value)?
        selectCovidVaccinationDoc,
    TResult Function(_DeleteCovidDoc value)? deleteCovidDoc,
    TResult Function(_CovidDocSubmit value)? covidDocSubmit,
    required TResult orElse(),
  }) {
    if (nextPage != null) {
      return nextPage(this);
    }
    return orElse();
  }
}

abstract class _NextPage implements DocumentEvent {
  const factory _NextPage(final int page) = _$NextPageImpl;

  int get page;
  @JsonKey(ignore: true)
  _$$NextPageImplCopyWith<_$NextPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectGovermentDocImplCopyWith<$Res> {
  factory _$$SelectGovermentDocImplCopyWith(_$SelectGovermentDocImpl value,
          $Res Function(_$SelectGovermentDocImpl) then) =
      __$$SelectGovermentDocImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String govermentDoc});
}

/// @nodoc
class __$$SelectGovermentDocImplCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$SelectGovermentDocImpl>
    implements _$$SelectGovermentDocImplCopyWith<$Res> {
  __$$SelectGovermentDocImplCopyWithImpl(_$SelectGovermentDocImpl _value,
      $Res Function(_$SelectGovermentDocImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? govermentDoc = null,
  }) {
    return _then(_$SelectGovermentDocImpl(
      null == govermentDoc
          ? _value.govermentDoc
          : govermentDoc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SelectGovermentDocImpl implements _SelectGovermentDoc {
  const _$SelectGovermentDocImpl(this.govermentDoc);

  @override
  final String govermentDoc;

  @override
  String toString() {
    return 'DocumentEvent.selectGovermentDoc(govermentDoc: $govermentDoc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectGovermentDocImpl &&
            (identical(other.govermentDoc, govermentDoc) ||
                other.govermentDoc == govermentDoc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, govermentDoc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectGovermentDocImplCopyWith<_$SelectGovermentDocImpl> get copyWith =>
      __$$SelectGovermentDocImplCopyWithImpl<_$SelectGovermentDocImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) nextPage,
    required TResult Function(String govermentDoc) selectGovermentDoc,
    required TResult Function(String govermentDoc) deleteGovermentDoc,
    required TResult Function() govermentDocSubmit,
    required TResult Function(String covidDoc) selectCovidVaccinationDoc,
    required TResult Function(String covidDoc) deleteCovidDoc,
    required TResult Function() covidDocSubmit,
  }) {
    return selectGovermentDoc(govermentDoc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? nextPage,
    TResult? Function(String govermentDoc)? selectGovermentDoc,
    TResult? Function(String govermentDoc)? deleteGovermentDoc,
    TResult? Function()? govermentDocSubmit,
    TResult? Function(String covidDoc)? selectCovidVaccinationDoc,
    TResult? Function(String covidDoc)? deleteCovidDoc,
    TResult? Function()? covidDocSubmit,
  }) {
    return selectGovermentDoc?.call(govermentDoc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? nextPage,
    TResult Function(String govermentDoc)? selectGovermentDoc,
    TResult Function(String govermentDoc)? deleteGovermentDoc,
    TResult Function()? govermentDocSubmit,
    TResult Function(String covidDoc)? selectCovidVaccinationDoc,
    TResult Function(String covidDoc)? deleteCovidDoc,
    TResult Function()? covidDocSubmit,
    required TResult orElse(),
  }) {
    if (selectGovermentDoc != null) {
      return selectGovermentDoc(govermentDoc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NextPage value) nextPage,
    required TResult Function(_SelectGovermentDoc value) selectGovermentDoc,
    required TResult Function(_DeleteGovermentDoc value) deleteGovermentDoc,
    required TResult Function(_GovermentDocSubmit value) govermentDocSubmit,
    required TResult Function(_SelectCovidVaccinationDoc value)
        selectCovidVaccinationDoc,
    required TResult Function(_DeleteCovidDoc value) deleteCovidDoc,
    required TResult Function(_CovidDocSubmit value) covidDocSubmit,
  }) {
    return selectGovermentDoc(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NextPage value)? nextPage,
    TResult? Function(_SelectGovermentDoc value)? selectGovermentDoc,
    TResult? Function(_DeleteGovermentDoc value)? deleteGovermentDoc,
    TResult? Function(_GovermentDocSubmit value)? govermentDocSubmit,
    TResult? Function(_SelectCovidVaccinationDoc value)?
        selectCovidVaccinationDoc,
    TResult? Function(_DeleteCovidDoc value)? deleteCovidDoc,
    TResult? Function(_CovidDocSubmit value)? covidDocSubmit,
  }) {
    return selectGovermentDoc?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NextPage value)? nextPage,
    TResult Function(_SelectGovermentDoc value)? selectGovermentDoc,
    TResult Function(_DeleteGovermentDoc value)? deleteGovermentDoc,
    TResult Function(_GovermentDocSubmit value)? govermentDocSubmit,
    TResult Function(_SelectCovidVaccinationDoc value)?
        selectCovidVaccinationDoc,
    TResult Function(_DeleteCovidDoc value)? deleteCovidDoc,
    TResult Function(_CovidDocSubmit value)? covidDocSubmit,
    required TResult orElse(),
  }) {
    if (selectGovermentDoc != null) {
      return selectGovermentDoc(this);
    }
    return orElse();
  }
}

abstract class _SelectGovermentDoc implements DocumentEvent {
  const factory _SelectGovermentDoc(final String govermentDoc) =
      _$SelectGovermentDocImpl;

  String get govermentDoc;
  @JsonKey(ignore: true)
  _$$SelectGovermentDocImplCopyWith<_$SelectGovermentDocImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteGovermentDocImplCopyWith<$Res> {
  factory _$$DeleteGovermentDocImplCopyWith(_$DeleteGovermentDocImpl value,
          $Res Function(_$DeleteGovermentDocImpl) then) =
      __$$DeleteGovermentDocImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String govermentDoc});
}

/// @nodoc
class __$$DeleteGovermentDocImplCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$DeleteGovermentDocImpl>
    implements _$$DeleteGovermentDocImplCopyWith<$Res> {
  __$$DeleteGovermentDocImplCopyWithImpl(_$DeleteGovermentDocImpl _value,
      $Res Function(_$DeleteGovermentDocImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? govermentDoc = null,
  }) {
    return _then(_$DeleteGovermentDocImpl(
      null == govermentDoc
          ? _value.govermentDoc
          : govermentDoc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteGovermentDocImpl implements _DeleteGovermentDoc {
  const _$DeleteGovermentDocImpl(this.govermentDoc);

  @override
  final String govermentDoc;

  @override
  String toString() {
    return 'DocumentEvent.deleteGovermentDoc(govermentDoc: $govermentDoc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteGovermentDocImpl &&
            (identical(other.govermentDoc, govermentDoc) ||
                other.govermentDoc == govermentDoc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, govermentDoc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteGovermentDocImplCopyWith<_$DeleteGovermentDocImpl> get copyWith =>
      __$$DeleteGovermentDocImplCopyWithImpl<_$DeleteGovermentDocImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) nextPage,
    required TResult Function(String govermentDoc) selectGovermentDoc,
    required TResult Function(String govermentDoc) deleteGovermentDoc,
    required TResult Function() govermentDocSubmit,
    required TResult Function(String covidDoc) selectCovidVaccinationDoc,
    required TResult Function(String covidDoc) deleteCovidDoc,
    required TResult Function() covidDocSubmit,
  }) {
    return deleteGovermentDoc(govermentDoc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? nextPage,
    TResult? Function(String govermentDoc)? selectGovermentDoc,
    TResult? Function(String govermentDoc)? deleteGovermentDoc,
    TResult? Function()? govermentDocSubmit,
    TResult? Function(String covidDoc)? selectCovidVaccinationDoc,
    TResult? Function(String covidDoc)? deleteCovidDoc,
    TResult? Function()? covidDocSubmit,
  }) {
    return deleteGovermentDoc?.call(govermentDoc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? nextPage,
    TResult Function(String govermentDoc)? selectGovermentDoc,
    TResult Function(String govermentDoc)? deleteGovermentDoc,
    TResult Function()? govermentDocSubmit,
    TResult Function(String covidDoc)? selectCovidVaccinationDoc,
    TResult Function(String covidDoc)? deleteCovidDoc,
    TResult Function()? covidDocSubmit,
    required TResult orElse(),
  }) {
    if (deleteGovermentDoc != null) {
      return deleteGovermentDoc(govermentDoc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NextPage value) nextPage,
    required TResult Function(_SelectGovermentDoc value) selectGovermentDoc,
    required TResult Function(_DeleteGovermentDoc value) deleteGovermentDoc,
    required TResult Function(_GovermentDocSubmit value) govermentDocSubmit,
    required TResult Function(_SelectCovidVaccinationDoc value)
        selectCovidVaccinationDoc,
    required TResult Function(_DeleteCovidDoc value) deleteCovidDoc,
    required TResult Function(_CovidDocSubmit value) covidDocSubmit,
  }) {
    return deleteGovermentDoc(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NextPage value)? nextPage,
    TResult? Function(_SelectGovermentDoc value)? selectGovermentDoc,
    TResult? Function(_DeleteGovermentDoc value)? deleteGovermentDoc,
    TResult? Function(_GovermentDocSubmit value)? govermentDocSubmit,
    TResult? Function(_SelectCovidVaccinationDoc value)?
        selectCovidVaccinationDoc,
    TResult? Function(_DeleteCovidDoc value)? deleteCovidDoc,
    TResult? Function(_CovidDocSubmit value)? covidDocSubmit,
  }) {
    return deleteGovermentDoc?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NextPage value)? nextPage,
    TResult Function(_SelectGovermentDoc value)? selectGovermentDoc,
    TResult Function(_DeleteGovermentDoc value)? deleteGovermentDoc,
    TResult Function(_GovermentDocSubmit value)? govermentDocSubmit,
    TResult Function(_SelectCovidVaccinationDoc value)?
        selectCovidVaccinationDoc,
    TResult Function(_DeleteCovidDoc value)? deleteCovidDoc,
    TResult Function(_CovidDocSubmit value)? covidDocSubmit,
    required TResult orElse(),
  }) {
    if (deleteGovermentDoc != null) {
      return deleteGovermentDoc(this);
    }
    return orElse();
  }
}

abstract class _DeleteGovermentDoc implements DocumentEvent {
  const factory _DeleteGovermentDoc(final String govermentDoc) =
      _$DeleteGovermentDocImpl;

  String get govermentDoc;
  @JsonKey(ignore: true)
  _$$DeleteGovermentDocImplCopyWith<_$DeleteGovermentDocImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GovermentDocSubmitImplCopyWith<$Res> {
  factory _$$GovermentDocSubmitImplCopyWith(_$GovermentDocSubmitImpl value,
          $Res Function(_$GovermentDocSubmitImpl) then) =
      __$$GovermentDocSubmitImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GovermentDocSubmitImplCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$GovermentDocSubmitImpl>
    implements _$$GovermentDocSubmitImplCopyWith<$Res> {
  __$$GovermentDocSubmitImplCopyWithImpl(_$GovermentDocSubmitImpl _value,
      $Res Function(_$GovermentDocSubmitImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GovermentDocSubmitImpl implements _GovermentDocSubmit {
  const _$GovermentDocSubmitImpl();

  @override
  String toString() {
    return 'DocumentEvent.govermentDocSubmit()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GovermentDocSubmitImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) nextPage,
    required TResult Function(String govermentDoc) selectGovermentDoc,
    required TResult Function(String govermentDoc) deleteGovermentDoc,
    required TResult Function() govermentDocSubmit,
    required TResult Function(String covidDoc) selectCovidVaccinationDoc,
    required TResult Function(String covidDoc) deleteCovidDoc,
    required TResult Function() covidDocSubmit,
  }) {
    return govermentDocSubmit();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? nextPage,
    TResult? Function(String govermentDoc)? selectGovermentDoc,
    TResult? Function(String govermentDoc)? deleteGovermentDoc,
    TResult? Function()? govermentDocSubmit,
    TResult? Function(String covidDoc)? selectCovidVaccinationDoc,
    TResult? Function(String covidDoc)? deleteCovidDoc,
    TResult? Function()? covidDocSubmit,
  }) {
    return govermentDocSubmit?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? nextPage,
    TResult Function(String govermentDoc)? selectGovermentDoc,
    TResult Function(String govermentDoc)? deleteGovermentDoc,
    TResult Function()? govermentDocSubmit,
    TResult Function(String covidDoc)? selectCovidVaccinationDoc,
    TResult Function(String covidDoc)? deleteCovidDoc,
    TResult Function()? covidDocSubmit,
    required TResult orElse(),
  }) {
    if (govermentDocSubmit != null) {
      return govermentDocSubmit();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NextPage value) nextPage,
    required TResult Function(_SelectGovermentDoc value) selectGovermentDoc,
    required TResult Function(_DeleteGovermentDoc value) deleteGovermentDoc,
    required TResult Function(_GovermentDocSubmit value) govermentDocSubmit,
    required TResult Function(_SelectCovidVaccinationDoc value)
        selectCovidVaccinationDoc,
    required TResult Function(_DeleteCovidDoc value) deleteCovidDoc,
    required TResult Function(_CovidDocSubmit value) covidDocSubmit,
  }) {
    return govermentDocSubmit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NextPage value)? nextPage,
    TResult? Function(_SelectGovermentDoc value)? selectGovermentDoc,
    TResult? Function(_DeleteGovermentDoc value)? deleteGovermentDoc,
    TResult? Function(_GovermentDocSubmit value)? govermentDocSubmit,
    TResult? Function(_SelectCovidVaccinationDoc value)?
        selectCovidVaccinationDoc,
    TResult? Function(_DeleteCovidDoc value)? deleteCovidDoc,
    TResult? Function(_CovidDocSubmit value)? covidDocSubmit,
  }) {
    return govermentDocSubmit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NextPage value)? nextPage,
    TResult Function(_SelectGovermentDoc value)? selectGovermentDoc,
    TResult Function(_DeleteGovermentDoc value)? deleteGovermentDoc,
    TResult Function(_GovermentDocSubmit value)? govermentDocSubmit,
    TResult Function(_SelectCovidVaccinationDoc value)?
        selectCovidVaccinationDoc,
    TResult Function(_DeleteCovidDoc value)? deleteCovidDoc,
    TResult Function(_CovidDocSubmit value)? covidDocSubmit,
    required TResult orElse(),
  }) {
    if (govermentDocSubmit != null) {
      return govermentDocSubmit(this);
    }
    return orElse();
  }
}

abstract class _GovermentDocSubmit implements DocumentEvent {
  const factory _GovermentDocSubmit() = _$GovermentDocSubmitImpl;
}

/// @nodoc
abstract class _$$SelectCovidVaccinationDocImplCopyWith<$Res> {
  factory _$$SelectCovidVaccinationDocImplCopyWith(
          _$SelectCovidVaccinationDocImpl value,
          $Res Function(_$SelectCovidVaccinationDocImpl) then) =
      __$$SelectCovidVaccinationDocImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String covidDoc});
}

/// @nodoc
class __$$SelectCovidVaccinationDocImplCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$SelectCovidVaccinationDocImpl>
    implements _$$SelectCovidVaccinationDocImplCopyWith<$Res> {
  __$$SelectCovidVaccinationDocImplCopyWithImpl(
      _$SelectCovidVaccinationDocImpl _value,
      $Res Function(_$SelectCovidVaccinationDocImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? covidDoc = null,
  }) {
    return _then(_$SelectCovidVaccinationDocImpl(
      null == covidDoc
          ? _value.covidDoc
          : covidDoc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SelectCovidVaccinationDocImpl implements _SelectCovidVaccinationDoc {
  const _$SelectCovidVaccinationDocImpl(this.covidDoc);

  @override
  final String covidDoc;

  @override
  String toString() {
    return 'DocumentEvent.selectCovidVaccinationDoc(covidDoc: $covidDoc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectCovidVaccinationDocImpl &&
            (identical(other.covidDoc, covidDoc) ||
                other.covidDoc == covidDoc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, covidDoc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectCovidVaccinationDocImplCopyWith<_$SelectCovidVaccinationDocImpl>
      get copyWith => __$$SelectCovidVaccinationDocImplCopyWithImpl<
          _$SelectCovidVaccinationDocImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) nextPage,
    required TResult Function(String govermentDoc) selectGovermentDoc,
    required TResult Function(String govermentDoc) deleteGovermentDoc,
    required TResult Function() govermentDocSubmit,
    required TResult Function(String covidDoc) selectCovidVaccinationDoc,
    required TResult Function(String covidDoc) deleteCovidDoc,
    required TResult Function() covidDocSubmit,
  }) {
    return selectCovidVaccinationDoc(covidDoc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? nextPage,
    TResult? Function(String govermentDoc)? selectGovermentDoc,
    TResult? Function(String govermentDoc)? deleteGovermentDoc,
    TResult? Function()? govermentDocSubmit,
    TResult? Function(String covidDoc)? selectCovidVaccinationDoc,
    TResult? Function(String covidDoc)? deleteCovidDoc,
    TResult? Function()? covidDocSubmit,
  }) {
    return selectCovidVaccinationDoc?.call(covidDoc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? nextPage,
    TResult Function(String govermentDoc)? selectGovermentDoc,
    TResult Function(String govermentDoc)? deleteGovermentDoc,
    TResult Function()? govermentDocSubmit,
    TResult Function(String covidDoc)? selectCovidVaccinationDoc,
    TResult Function(String covidDoc)? deleteCovidDoc,
    TResult Function()? covidDocSubmit,
    required TResult orElse(),
  }) {
    if (selectCovidVaccinationDoc != null) {
      return selectCovidVaccinationDoc(covidDoc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NextPage value) nextPage,
    required TResult Function(_SelectGovermentDoc value) selectGovermentDoc,
    required TResult Function(_DeleteGovermentDoc value) deleteGovermentDoc,
    required TResult Function(_GovermentDocSubmit value) govermentDocSubmit,
    required TResult Function(_SelectCovidVaccinationDoc value)
        selectCovidVaccinationDoc,
    required TResult Function(_DeleteCovidDoc value) deleteCovidDoc,
    required TResult Function(_CovidDocSubmit value) covidDocSubmit,
  }) {
    return selectCovidVaccinationDoc(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NextPage value)? nextPage,
    TResult? Function(_SelectGovermentDoc value)? selectGovermentDoc,
    TResult? Function(_DeleteGovermentDoc value)? deleteGovermentDoc,
    TResult? Function(_GovermentDocSubmit value)? govermentDocSubmit,
    TResult? Function(_SelectCovidVaccinationDoc value)?
        selectCovidVaccinationDoc,
    TResult? Function(_DeleteCovidDoc value)? deleteCovidDoc,
    TResult? Function(_CovidDocSubmit value)? covidDocSubmit,
  }) {
    return selectCovidVaccinationDoc?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NextPage value)? nextPage,
    TResult Function(_SelectGovermentDoc value)? selectGovermentDoc,
    TResult Function(_DeleteGovermentDoc value)? deleteGovermentDoc,
    TResult Function(_GovermentDocSubmit value)? govermentDocSubmit,
    TResult Function(_SelectCovidVaccinationDoc value)?
        selectCovidVaccinationDoc,
    TResult Function(_DeleteCovidDoc value)? deleteCovidDoc,
    TResult Function(_CovidDocSubmit value)? covidDocSubmit,
    required TResult orElse(),
  }) {
    if (selectCovidVaccinationDoc != null) {
      return selectCovidVaccinationDoc(this);
    }
    return orElse();
  }
}

abstract class _SelectCovidVaccinationDoc implements DocumentEvent {
  const factory _SelectCovidVaccinationDoc(final String covidDoc) =
      _$SelectCovidVaccinationDocImpl;

  String get covidDoc;
  @JsonKey(ignore: true)
  _$$SelectCovidVaccinationDocImplCopyWith<_$SelectCovidVaccinationDocImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteCovidDocImplCopyWith<$Res> {
  factory _$$DeleteCovidDocImplCopyWith(_$DeleteCovidDocImpl value,
          $Res Function(_$DeleteCovidDocImpl) then) =
      __$$DeleteCovidDocImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String covidDoc});
}

/// @nodoc
class __$$DeleteCovidDocImplCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$DeleteCovidDocImpl>
    implements _$$DeleteCovidDocImplCopyWith<$Res> {
  __$$DeleteCovidDocImplCopyWithImpl(
      _$DeleteCovidDocImpl _value, $Res Function(_$DeleteCovidDocImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? covidDoc = null,
  }) {
    return _then(_$DeleteCovidDocImpl(
      null == covidDoc
          ? _value.covidDoc
          : covidDoc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteCovidDocImpl implements _DeleteCovidDoc {
  const _$DeleteCovidDocImpl(this.covidDoc);

  @override
  final String covidDoc;

  @override
  String toString() {
    return 'DocumentEvent.deleteCovidDoc(covidDoc: $covidDoc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCovidDocImpl &&
            (identical(other.covidDoc, covidDoc) ||
                other.covidDoc == covidDoc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, covidDoc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteCovidDocImplCopyWith<_$DeleteCovidDocImpl> get copyWith =>
      __$$DeleteCovidDocImplCopyWithImpl<_$DeleteCovidDocImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) nextPage,
    required TResult Function(String govermentDoc) selectGovermentDoc,
    required TResult Function(String govermentDoc) deleteGovermentDoc,
    required TResult Function() govermentDocSubmit,
    required TResult Function(String covidDoc) selectCovidVaccinationDoc,
    required TResult Function(String covidDoc) deleteCovidDoc,
    required TResult Function() covidDocSubmit,
  }) {
    return deleteCovidDoc(covidDoc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? nextPage,
    TResult? Function(String govermentDoc)? selectGovermentDoc,
    TResult? Function(String govermentDoc)? deleteGovermentDoc,
    TResult? Function()? govermentDocSubmit,
    TResult? Function(String covidDoc)? selectCovidVaccinationDoc,
    TResult? Function(String covidDoc)? deleteCovidDoc,
    TResult? Function()? covidDocSubmit,
  }) {
    return deleteCovidDoc?.call(covidDoc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? nextPage,
    TResult Function(String govermentDoc)? selectGovermentDoc,
    TResult Function(String govermentDoc)? deleteGovermentDoc,
    TResult Function()? govermentDocSubmit,
    TResult Function(String covidDoc)? selectCovidVaccinationDoc,
    TResult Function(String covidDoc)? deleteCovidDoc,
    TResult Function()? covidDocSubmit,
    required TResult orElse(),
  }) {
    if (deleteCovidDoc != null) {
      return deleteCovidDoc(covidDoc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NextPage value) nextPage,
    required TResult Function(_SelectGovermentDoc value) selectGovermentDoc,
    required TResult Function(_DeleteGovermentDoc value) deleteGovermentDoc,
    required TResult Function(_GovermentDocSubmit value) govermentDocSubmit,
    required TResult Function(_SelectCovidVaccinationDoc value)
        selectCovidVaccinationDoc,
    required TResult Function(_DeleteCovidDoc value) deleteCovidDoc,
    required TResult Function(_CovidDocSubmit value) covidDocSubmit,
  }) {
    return deleteCovidDoc(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NextPage value)? nextPage,
    TResult? Function(_SelectGovermentDoc value)? selectGovermentDoc,
    TResult? Function(_DeleteGovermentDoc value)? deleteGovermentDoc,
    TResult? Function(_GovermentDocSubmit value)? govermentDocSubmit,
    TResult? Function(_SelectCovidVaccinationDoc value)?
        selectCovidVaccinationDoc,
    TResult? Function(_DeleteCovidDoc value)? deleteCovidDoc,
    TResult? Function(_CovidDocSubmit value)? covidDocSubmit,
  }) {
    return deleteCovidDoc?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NextPage value)? nextPage,
    TResult Function(_SelectGovermentDoc value)? selectGovermentDoc,
    TResult Function(_DeleteGovermentDoc value)? deleteGovermentDoc,
    TResult Function(_GovermentDocSubmit value)? govermentDocSubmit,
    TResult Function(_SelectCovidVaccinationDoc value)?
        selectCovidVaccinationDoc,
    TResult Function(_DeleteCovidDoc value)? deleteCovidDoc,
    TResult Function(_CovidDocSubmit value)? covidDocSubmit,
    required TResult orElse(),
  }) {
    if (deleteCovidDoc != null) {
      return deleteCovidDoc(this);
    }
    return orElse();
  }
}

abstract class _DeleteCovidDoc implements DocumentEvent {
  const factory _DeleteCovidDoc(final String covidDoc) = _$DeleteCovidDocImpl;

  String get covidDoc;
  @JsonKey(ignore: true)
  _$$DeleteCovidDocImplCopyWith<_$DeleteCovidDocImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CovidDocSubmitImplCopyWith<$Res> {
  factory _$$CovidDocSubmitImplCopyWith(_$CovidDocSubmitImpl value,
          $Res Function(_$CovidDocSubmitImpl) then) =
      __$$CovidDocSubmitImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CovidDocSubmitImplCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$CovidDocSubmitImpl>
    implements _$$CovidDocSubmitImplCopyWith<$Res> {
  __$$CovidDocSubmitImplCopyWithImpl(
      _$CovidDocSubmitImpl _value, $Res Function(_$CovidDocSubmitImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CovidDocSubmitImpl implements _CovidDocSubmit {
  const _$CovidDocSubmitImpl();

  @override
  String toString() {
    return 'DocumentEvent.covidDocSubmit()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CovidDocSubmitImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) nextPage,
    required TResult Function(String govermentDoc) selectGovermentDoc,
    required TResult Function(String govermentDoc) deleteGovermentDoc,
    required TResult Function() govermentDocSubmit,
    required TResult Function(String covidDoc) selectCovidVaccinationDoc,
    required TResult Function(String covidDoc) deleteCovidDoc,
    required TResult Function() covidDocSubmit,
  }) {
    return covidDocSubmit();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? nextPage,
    TResult? Function(String govermentDoc)? selectGovermentDoc,
    TResult? Function(String govermentDoc)? deleteGovermentDoc,
    TResult? Function()? govermentDocSubmit,
    TResult? Function(String covidDoc)? selectCovidVaccinationDoc,
    TResult? Function(String covidDoc)? deleteCovidDoc,
    TResult? Function()? covidDocSubmit,
  }) {
    return covidDocSubmit?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? nextPage,
    TResult Function(String govermentDoc)? selectGovermentDoc,
    TResult Function(String govermentDoc)? deleteGovermentDoc,
    TResult Function()? govermentDocSubmit,
    TResult Function(String covidDoc)? selectCovidVaccinationDoc,
    TResult Function(String covidDoc)? deleteCovidDoc,
    TResult Function()? covidDocSubmit,
    required TResult orElse(),
  }) {
    if (covidDocSubmit != null) {
      return covidDocSubmit();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NextPage value) nextPage,
    required TResult Function(_SelectGovermentDoc value) selectGovermentDoc,
    required TResult Function(_DeleteGovermentDoc value) deleteGovermentDoc,
    required TResult Function(_GovermentDocSubmit value) govermentDocSubmit,
    required TResult Function(_SelectCovidVaccinationDoc value)
        selectCovidVaccinationDoc,
    required TResult Function(_DeleteCovidDoc value) deleteCovidDoc,
    required TResult Function(_CovidDocSubmit value) covidDocSubmit,
  }) {
    return covidDocSubmit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NextPage value)? nextPage,
    TResult? Function(_SelectGovermentDoc value)? selectGovermentDoc,
    TResult? Function(_DeleteGovermentDoc value)? deleteGovermentDoc,
    TResult? Function(_GovermentDocSubmit value)? govermentDocSubmit,
    TResult? Function(_SelectCovidVaccinationDoc value)?
        selectCovidVaccinationDoc,
    TResult? Function(_DeleteCovidDoc value)? deleteCovidDoc,
    TResult? Function(_CovidDocSubmit value)? covidDocSubmit,
  }) {
    return covidDocSubmit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NextPage value)? nextPage,
    TResult Function(_SelectGovermentDoc value)? selectGovermentDoc,
    TResult Function(_DeleteGovermentDoc value)? deleteGovermentDoc,
    TResult Function(_GovermentDocSubmit value)? govermentDocSubmit,
    TResult Function(_SelectCovidVaccinationDoc value)?
        selectCovidVaccinationDoc,
    TResult Function(_DeleteCovidDoc value)? deleteCovidDoc,
    TResult Function(_CovidDocSubmit value)? covidDocSubmit,
    required TResult orElse(),
  }) {
    if (covidDocSubmit != null) {
      return covidDocSubmit(this);
    }
    return orElse();
  }
}

abstract class _CovidDocSubmit implements DocumentEvent {
  const factory _CovidDocSubmit() = _$CovidDocSubmitImpl;
}

/// @nodoc
mixin _$DocumentState {
  int get currentPage => throw _privateConstructorUsedError;

  /// FOR GOVERNMENT DOCUMENT
  InputEmptyOrNot get govermentDoc => throw _privateConstructorUsedError;
  bool get showGovernmentIdErrorMessages => throw _privateConstructorUsedError;
  bool get isGovermentDocSubmitting => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, String>>
      get governmentDocAuthFailureOrSuccessOption =>
          throw _privateConstructorUsedError;

  /// FOR COVID DOCUMENT
  InputEmptyOrNot get covidVaccinationDoc => throw _privateConstructorUsedError;
  bool get showCovidErrorMessages => throw _privateConstructorUsedError;
  bool get isCovidDocSubmitting => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, String>> get coviDocAuthFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  /// SUBMIT
  bool get isSubmitting => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DocumentStateCopyWith<DocumentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentStateCopyWith<$Res> {
  factory $DocumentStateCopyWith(
          DocumentState value, $Res Function(DocumentState) then) =
      _$DocumentStateCopyWithImpl<$Res, DocumentState>;
  @useResult
  $Res call(
      {int currentPage,
      InputEmptyOrNot govermentDoc,
      bool showGovernmentIdErrorMessages,
      bool isGovermentDocSubmitting,
      Option<Either<AuthFailure, String>>
          governmentDocAuthFailureOrSuccessOption,
      InputEmptyOrNot covidVaccinationDoc,
      bool showCovidErrorMessages,
      bool isCovidDocSubmitting,
      Option<Either<AuthFailure, String>> coviDocAuthFailureOrSuccessOption,
      bool isSubmitting,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption});
}

/// @nodoc
class _$DocumentStateCopyWithImpl<$Res, $Val extends DocumentState>
    implements $DocumentStateCopyWith<$Res> {
  _$DocumentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? govermentDoc = null,
    Object? showGovernmentIdErrorMessages = null,
    Object? isGovermentDocSubmitting = null,
    Object? governmentDocAuthFailureOrSuccessOption = null,
    Object? covidVaccinationDoc = null,
    Object? showCovidErrorMessages = null,
    Object? isCovidDocSubmitting = null,
    Object? coviDocAuthFailureOrSuccessOption = null,
    Object? isSubmitting = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_value.copyWith(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      govermentDoc: null == govermentDoc
          ? _value.govermentDoc
          : govermentDoc // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      showGovernmentIdErrorMessages: null == showGovernmentIdErrorMessages
          ? _value.showGovernmentIdErrorMessages
          : showGovernmentIdErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isGovermentDocSubmitting: null == isGovermentDocSubmitting
          ? _value.isGovermentDocSubmitting
          : isGovermentDocSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      governmentDocAuthFailureOrSuccessOption: null ==
              governmentDocAuthFailureOrSuccessOption
          ? _value.governmentDocAuthFailureOrSuccessOption
          : governmentDocAuthFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
      covidVaccinationDoc: null == covidVaccinationDoc
          ? _value.covidVaccinationDoc
          : covidVaccinationDoc // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      showCovidErrorMessages: null == showCovidErrorMessages
          ? _value.showCovidErrorMessages
          : showCovidErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isCovidDocSubmitting: null == isCovidDocSubmitting
          ? _value.isCovidDocSubmitting
          : isCovidDocSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      coviDocAuthFailureOrSuccessOption: null ==
              coviDocAuthFailureOrSuccessOption
          ? _value.coviDocAuthFailureOrSuccessOption
          : coviDocAuthFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentStateImplCopyWith<$Res>
    implements $DocumentStateCopyWith<$Res> {
  factory _$$DocumentStateImplCopyWith(
          _$DocumentStateImpl value, $Res Function(_$DocumentStateImpl) then) =
      __$$DocumentStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentPage,
      InputEmptyOrNot govermentDoc,
      bool showGovernmentIdErrorMessages,
      bool isGovermentDocSubmitting,
      Option<Either<AuthFailure, String>>
          governmentDocAuthFailureOrSuccessOption,
      InputEmptyOrNot covidVaccinationDoc,
      bool showCovidErrorMessages,
      bool isCovidDocSubmitting,
      Option<Either<AuthFailure, String>> coviDocAuthFailureOrSuccessOption,
      bool isSubmitting,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption});
}

/// @nodoc
class __$$DocumentStateImplCopyWithImpl<$Res>
    extends _$DocumentStateCopyWithImpl<$Res, _$DocumentStateImpl>
    implements _$$DocumentStateImplCopyWith<$Res> {
  __$$DocumentStateImplCopyWithImpl(
      _$DocumentStateImpl _value, $Res Function(_$DocumentStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? govermentDoc = null,
    Object? showGovernmentIdErrorMessages = null,
    Object? isGovermentDocSubmitting = null,
    Object? governmentDocAuthFailureOrSuccessOption = null,
    Object? covidVaccinationDoc = null,
    Object? showCovidErrorMessages = null,
    Object? isCovidDocSubmitting = null,
    Object? coviDocAuthFailureOrSuccessOption = null,
    Object? isSubmitting = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_$DocumentStateImpl(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      govermentDoc: null == govermentDoc
          ? _value.govermentDoc
          : govermentDoc // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      showGovernmentIdErrorMessages: null == showGovernmentIdErrorMessages
          ? _value.showGovernmentIdErrorMessages
          : showGovernmentIdErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isGovermentDocSubmitting: null == isGovermentDocSubmitting
          ? _value.isGovermentDocSubmitting
          : isGovermentDocSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      governmentDocAuthFailureOrSuccessOption: null ==
              governmentDocAuthFailureOrSuccessOption
          ? _value.governmentDocAuthFailureOrSuccessOption
          : governmentDocAuthFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
      covidVaccinationDoc: null == covidVaccinationDoc
          ? _value.covidVaccinationDoc
          : covidVaccinationDoc // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      showCovidErrorMessages: null == showCovidErrorMessages
          ? _value.showCovidErrorMessages
          : showCovidErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isCovidDocSubmitting: null == isCovidDocSubmitting
          ? _value.isCovidDocSubmitting
          : isCovidDocSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      coviDocAuthFailureOrSuccessOption: null ==
              coviDocAuthFailureOrSuccessOption
          ? _value.coviDocAuthFailureOrSuccessOption
          : coviDocAuthFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
    ));
  }
}

/// @nodoc

class _$DocumentStateImpl implements _DocumentState {
  const _$DocumentStateImpl(
      {required this.currentPage,
      required this.govermentDoc,
      required this.showGovernmentIdErrorMessages,
      required this.isGovermentDocSubmitting,
      required this.governmentDocAuthFailureOrSuccessOption,
      required this.covidVaccinationDoc,
      required this.showCovidErrorMessages,
      required this.isCovidDocSubmitting,
      required this.coviDocAuthFailureOrSuccessOption,
      required this.isSubmitting,
      required this.authFailureOrSuccessOption});

  @override
  final int currentPage;

  /// FOR GOVERNMENT DOCUMENT
  @override
  final InputEmptyOrNot govermentDoc;
  @override
  final bool showGovernmentIdErrorMessages;
  @override
  final bool isGovermentDocSubmitting;
  @override
  final Option<Either<AuthFailure, String>>
      governmentDocAuthFailureOrSuccessOption;

  /// FOR COVID DOCUMENT
  @override
  final InputEmptyOrNot covidVaccinationDoc;
  @override
  final bool showCovidErrorMessages;
  @override
  final bool isCovidDocSubmitting;
  @override
  final Option<Either<AuthFailure, String>> coviDocAuthFailureOrSuccessOption;

  /// SUBMIT
  @override
  final bool isSubmitting;
  @override
  final Option<Either<AuthFailure, String>> authFailureOrSuccessOption;

  @override
  String toString() {
    return 'DocumentState(currentPage: $currentPage, govermentDoc: $govermentDoc, showGovernmentIdErrorMessages: $showGovernmentIdErrorMessages, isGovermentDocSubmitting: $isGovermentDocSubmitting, governmentDocAuthFailureOrSuccessOption: $governmentDocAuthFailureOrSuccessOption, covidVaccinationDoc: $covidVaccinationDoc, showCovidErrorMessages: $showCovidErrorMessages, isCovidDocSubmitting: $isCovidDocSubmitting, coviDocAuthFailureOrSuccessOption: $coviDocAuthFailureOrSuccessOption, isSubmitting: $isSubmitting, authFailureOrSuccessOption: $authFailureOrSuccessOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentStateImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.govermentDoc, govermentDoc) ||
                other.govermentDoc == govermentDoc) &&
            (identical(other.showGovernmentIdErrorMessages,
                    showGovernmentIdErrorMessages) ||
                other.showGovernmentIdErrorMessages ==
                    showGovernmentIdErrorMessages) &&
            (identical(other.isGovermentDocSubmitting, isGovermentDocSubmitting) ||
                other.isGovermentDocSubmitting == isGovermentDocSubmitting) &&
            (identical(other.governmentDocAuthFailureOrSuccessOption,
                    governmentDocAuthFailureOrSuccessOption) ||
                other.governmentDocAuthFailureOrSuccessOption ==
                    governmentDocAuthFailureOrSuccessOption) &&
            (identical(other.covidVaccinationDoc, covidVaccinationDoc) ||
                other.covidVaccinationDoc == covidVaccinationDoc) &&
            (identical(other.showCovidErrorMessages, showCovidErrorMessages) ||
                other.showCovidErrorMessages == showCovidErrorMessages) &&
            (identical(other.isCovidDocSubmitting, isCovidDocSubmitting) ||
                other.isCovidDocSubmitting == isCovidDocSubmitting) &&
            (identical(other.coviDocAuthFailureOrSuccessOption,
                    coviDocAuthFailureOrSuccessOption) ||
                other.coviDocAuthFailureOrSuccessOption ==
                    coviDocAuthFailureOrSuccessOption) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.authFailureOrSuccessOption,
                    authFailureOrSuccessOption) ||
                other.authFailureOrSuccessOption == authFailureOrSuccessOption));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentPage,
      govermentDoc,
      showGovernmentIdErrorMessages,
      isGovermentDocSubmitting,
      governmentDocAuthFailureOrSuccessOption,
      covidVaccinationDoc,
      showCovidErrorMessages,
      isCovidDocSubmitting,
      coviDocAuthFailureOrSuccessOption,
      isSubmitting,
      authFailureOrSuccessOption);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentStateImplCopyWith<_$DocumentStateImpl> get copyWith =>
      __$$DocumentStateImplCopyWithImpl<_$DocumentStateImpl>(this, _$identity);
}

abstract class _DocumentState implements DocumentState {
  const factory _DocumentState(
      {required final int currentPage,
      required final InputEmptyOrNot govermentDoc,
      required final bool showGovernmentIdErrorMessages,
      required final bool isGovermentDocSubmitting,
      required final Option<Either<AuthFailure, String>>
          governmentDocAuthFailureOrSuccessOption,
      required final InputEmptyOrNot covidVaccinationDoc,
      required final bool showCovidErrorMessages,
      required final bool isCovidDocSubmitting,
      required final Option<Either<AuthFailure, String>>
          coviDocAuthFailureOrSuccessOption,
      required final bool isSubmitting,
      required final Option<Either<AuthFailure, String>>
          authFailureOrSuccessOption}) = _$DocumentStateImpl;

  @override
  int get currentPage;
  @override

  /// FOR GOVERNMENT DOCUMENT
  InputEmptyOrNot get govermentDoc;
  @override
  bool get showGovernmentIdErrorMessages;
  @override
  bool get isGovermentDocSubmitting;
  @override
  Option<Either<AuthFailure, String>>
      get governmentDocAuthFailureOrSuccessOption;
  @override

  /// FOR COVID DOCUMENT
  InputEmptyOrNot get covidVaccinationDoc;
  @override
  bool get showCovidErrorMessages;
  @override
  bool get isCovidDocSubmitting;
  @override
  Option<Either<AuthFailure, String>> get coviDocAuthFailureOrSuccessOption;
  @override

  /// SUBMIT
  bool get isSubmitting;
  @override
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption;
  @override
  @JsonKey(ignore: true)
  _$$DocumentStateImplCopyWith<_$DocumentStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
