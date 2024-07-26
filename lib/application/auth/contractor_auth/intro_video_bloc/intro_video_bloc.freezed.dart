// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intro_video_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IntroVideoEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() setupVideo,
    required TResult Function() playVideo,
    required TResult Function() pauseVideo,
    required TResult Function() videoCompleted,
    required TResult Function() getQuizQuestionlist,
    required TResult Function(int questionIndex, QuizMcqDTO selectedOption)
        optionSelected,
    required TResult Function() submitQuiz,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? setupVideo,
    TResult? Function()? playVideo,
    TResult? Function()? pauseVideo,
    TResult? Function()? videoCompleted,
    TResult? Function()? getQuizQuestionlist,
    TResult? Function(int questionIndex, QuizMcqDTO selectedOption)?
        optionSelected,
    TResult? Function()? submitQuiz,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? setupVideo,
    TResult Function()? playVideo,
    TResult Function()? pauseVideo,
    TResult Function()? videoCompleted,
    TResult Function()? getQuizQuestionlist,
    TResult Function(int questionIndex, QuizMcqDTO selectedOption)?
        optionSelected,
    TResult Function()? submitQuiz,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetupVideo value) setupVideo,
    required TResult Function(_PlayVideo value) playVideo,
    required TResult Function(_PauseVideo value) pauseVideo,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_GetQuizQuestionList value) getQuizQuestionlist,
    required TResult Function(_OptionSelected value) optionSelected,
    required TResult Function(_SubmitQuiz value) submitQuiz,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetupVideo value)? setupVideo,
    TResult? Function(_PlayVideo value)? playVideo,
    TResult? Function(_PauseVideo value)? pauseVideo,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_GetQuizQuestionList value)? getQuizQuestionlist,
    TResult? Function(_OptionSelected value)? optionSelected,
    TResult? Function(_SubmitQuiz value)? submitQuiz,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetupVideo value)? setupVideo,
    TResult Function(_PlayVideo value)? playVideo,
    TResult Function(_PauseVideo value)? pauseVideo,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_GetQuizQuestionList value)? getQuizQuestionlist,
    TResult Function(_OptionSelected value)? optionSelected,
    TResult Function(_SubmitQuiz value)? submitQuiz,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntroVideoEventCopyWith<$Res> {
  factory $IntroVideoEventCopyWith(
          IntroVideoEvent value, $Res Function(IntroVideoEvent) then) =
      _$IntroVideoEventCopyWithImpl<$Res, IntroVideoEvent>;
}

/// @nodoc
class _$IntroVideoEventCopyWithImpl<$Res, $Val extends IntroVideoEvent>
    implements $IntroVideoEventCopyWith<$Res> {
  _$IntroVideoEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SetupVideoImplCopyWith<$Res> {
  factory _$$SetupVideoImplCopyWith(
          _$SetupVideoImpl value, $Res Function(_$SetupVideoImpl) then) =
      __$$SetupVideoImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SetupVideoImplCopyWithImpl<$Res>
    extends _$IntroVideoEventCopyWithImpl<$Res, _$SetupVideoImpl>
    implements _$$SetupVideoImplCopyWith<$Res> {
  __$$SetupVideoImplCopyWithImpl(
      _$SetupVideoImpl _value, $Res Function(_$SetupVideoImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SetupVideoImpl implements _SetupVideo {
  const _$SetupVideoImpl();

  @override
  String toString() {
    return 'IntroVideoEvent.setupVideo()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SetupVideoImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() setupVideo,
    required TResult Function() playVideo,
    required TResult Function() pauseVideo,
    required TResult Function() videoCompleted,
    required TResult Function() getQuizQuestionlist,
    required TResult Function(int questionIndex, QuizMcqDTO selectedOption)
        optionSelected,
    required TResult Function() submitQuiz,
  }) {
    return setupVideo();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? setupVideo,
    TResult? Function()? playVideo,
    TResult? Function()? pauseVideo,
    TResult? Function()? videoCompleted,
    TResult? Function()? getQuizQuestionlist,
    TResult? Function(int questionIndex, QuizMcqDTO selectedOption)?
        optionSelected,
    TResult? Function()? submitQuiz,
  }) {
    return setupVideo?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? setupVideo,
    TResult Function()? playVideo,
    TResult Function()? pauseVideo,
    TResult Function()? videoCompleted,
    TResult Function()? getQuizQuestionlist,
    TResult Function(int questionIndex, QuizMcqDTO selectedOption)?
        optionSelected,
    TResult Function()? submitQuiz,
    required TResult orElse(),
  }) {
    if (setupVideo != null) {
      return setupVideo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetupVideo value) setupVideo,
    required TResult Function(_PlayVideo value) playVideo,
    required TResult Function(_PauseVideo value) pauseVideo,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_GetQuizQuestionList value) getQuizQuestionlist,
    required TResult Function(_OptionSelected value) optionSelected,
    required TResult Function(_SubmitQuiz value) submitQuiz,
  }) {
    return setupVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetupVideo value)? setupVideo,
    TResult? Function(_PlayVideo value)? playVideo,
    TResult? Function(_PauseVideo value)? pauseVideo,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_GetQuizQuestionList value)? getQuizQuestionlist,
    TResult? Function(_OptionSelected value)? optionSelected,
    TResult? Function(_SubmitQuiz value)? submitQuiz,
  }) {
    return setupVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetupVideo value)? setupVideo,
    TResult Function(_PlayVideo value)? playVideo,
    TResult Function(_PauseVideo value)? pauseVideo,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_GetQuizQuestionList value)? getQuizQuestionlist,
    TResult Function(_OptionSelected value)? optionSelected,
    TResult Function(_SubmitQuiz value)? submitQuiz,
    required TResult orElse(),
  }) {
    if (setupVideo != null) {
      return setupVideo(this);
    }
    return orElse();
  }
}

abstract class _SetupVideo implements IntroVideoEvent {
  const factory _SetupVideo() = _$SetupVideoImpl;
}

/// @nodoc
abstract class _$$PlayVideoImplCopyWith<$Res> {
  factory _$$PlayVideoImplCopyWith(
          _$PlayVideoImpl value, $Res Function(_$PlayVideoImpl) then) =
      __$$PlayVideoImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PlayVideoImplCopyWithImpl<$Res>
    extends _$IntroVideoEventCopyWithImpl<$Res, _$PlayVideoImpl>
    implements _$$PlayVideoImplCopyWith<$Res> {
  __$$PlayVideoImplCopyWithImpl(
      _$PlayVideoImpl _value, $Res Function(_$PlayVideoImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PlayVideoImpl implements _PlayVideo {
  const _$PlayVideoImpl();

  @override
  String toString() {
    return 'IntroVideoEvent.playVideo()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PlayVideoImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() setupVideo,
    required TResult Function() playVideo,
    required TResult Function() pauseVideo,
    required TResult Function() videoCompleted,
    required TResult Function() getQuizQuestionlist,
    required TResult Function(int questionIndex, QuizMcqDTO selectedOption)
        optionSelected,
    required TResult Function() submitQuiz,
  }) {
    return playVideo();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? setupVideo,
    TResult? Function()? playVideo,
    TResult? Function()? pauseVideo,
    TResult? Function()? videoCompleted,
    TResult? Function()? getQuizQuestionlist,
    TResult? Function(int questionIndex, QuizMcqDTO selectedOption)?
        optionSelected,
    TResult? Function()? submitQuiz,
  }) {
    return playVideo?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? setupVideo,
    TResult Function()? playVideo,
    TResult Function()? pauseVideo,
    TResult Function()? videoCompleted,
    TResult Function()? getQuizQuestionlist,
    TResult Function(int questionIndex, QuizMcqDTO selectedOption)?
        optionSelected,
    TResult Function()? submitQuiz,
    required TResult orElse(),
  }) {
    if (playVideo != null) {
      return playVideo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetupVideo value) setupVideo,
    required TResult Function(_PlayVideo value) playVideo,
    required TResult Function(_PauseVideo value) pauseVideo,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_GetQuizQuestionList value) getQuizQuestionlist,
    required TResult Function(_OptionSelected value) optionSelected,
    required TResult Function(_SubmitQuiz value) submitQuiz,
  }) {
    return playVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetupVideo value)? setupVideo,
    TResult? Function(_PlayVideo value)? playVideo,
    TResult? Function(_PauseVideo value)? pauseVideo,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_GetQuizQuestionList value)? getQuizQuestionlist,
    TResult? Function(_OptionSelected value)? optionSelected,
    TResult? Function(_SubmitQuiz value)? submitQuiz,
  }) {
    return playVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetupVideo value)? setupVideo,
    TResult Function(_PlayVideo value)? playVideo,
    TResult Function(_PauseVideo value)? pauseVideo,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_GetQuizQuestionList value)? getQuizQuestionlist,
    TResult Function(_OptionSelected value)? optionSelected,
    TResult Function(_SubmitQuiz value)? submitQuiz,
    required TResult orElse(),
  }) {
    if (playVideo != null) {
      return playVideo(this);
    }
    return orElse();
  }
}

abstract class _PlayVideo implements IntroVideoEvent {
  const factory _PlayVideo() = _$PlayVideoImpl;
}

/// @nodoc
abstract class _$$PauseVideoImplCopyWith<$Res> {
  factory _$$PauseVideoImplCopyWith(
          _$PauseVideoImpl value, $Res Function(_$PauseVideoImpl) then) =
      __$$PauseVideoImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PauseVideoImplCopyWithImpl<$Res>
    extends _$IntroVideoEventCopyWithImpl<$Res, _$PauseVideoImpl>
    implements _$$PauseVideoImplCopyWith<$Res> {
  __$$PauseVideoImplCopyWithImpl(
      _$PauseVideoImpl _value, $Res Function(_$PauseVideoImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PauseVideoImpl implements _PauseVideo {
  const _$PauseVideoImpl();

  @override
  String toString() {
    return 'IntroVideoEvent.pauseVideo()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PauseVideoImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() setupVideo,
    required TResult Function() playVideo,
    required TResult Function() pauseVideo,
    required TResult Function() videoCompleted,
    required TResult Function() getQuizQuestionlist,
    required TResult Function(int questionIndex, QuizMcqDTO selectedOption)
        optionSelected,
    required TResult Function() submitQuiz,
  }) {
    return pauseVideo();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? setupVideo,
    TResult? Function()? playVideo,
    TResult? Function()? pauseVideo,
    TResult? Function()? videoCompleted,
    TResult? Function()? getQuizQuestionlist,
    TResult? Function(int questionIndex, QuizMcqDTO selectedOption)?
        optionSelected,
    TResult? Function()? submitQuiz,
  }) {
    return pauseVideo?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? setupVideo,
    TResult Function()? playVideo,
    TResult Function()? pauseVideo,
    TResult Function()? videoCompleted,
    TResult Function()? getQuizQuestionlist,
    TResult Function(int questionIndex, QuizMcqDTO selectedOption)?
        optionSelected,
    TResult Function()? submitQuiz,
    required TResult orElse(),
  }) {
    if (pauseVideo != null) {
      return pauseVideo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetupVideo value) setupVideo,
    required TResult Function(_PlayVideo value) playVideo,
    required TResult Function(_PauseVideo value) pauseVideo,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_GetQuizQuestionList value) getQuizQuestionlist,
    required TResult Function(_OptionSelected value) optionSelected,
    required TResult Function(_SubmitQuiz value) submitQuiz,
  }) {
    return pauseVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetupVideo value)? setupVideo,
    TResult? Function(_PlayVideo value)? playVideo,
    TResult? Function(_PauseVideo value)? pauseVideo,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_GetQuizQuestionList value)? getQuizQuestionlist,
    TResult? Function(_OptionSelected value)? optionSelected,
    TResult? Function(_SubmitQuiz value)? submitQuiz,
  }) {
    return pauseVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetupVideo value)? setupVideo,
    TResult Function(_PlayVideo value)? playVideo,
    TResult Function(_PauseVideo value)? pauseVideo,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_GetQuizQuestionList value)? getQuizQuestionlist,
    TResult Function(_OptionSelected value)? optionSelected,
    TResult Function(_SubmitQuiz value)? submitQuiz,
    required TResult orElse(),
  }) {
    if (pauseVideo != null) {
      return pauseVideo(this);
    }
    return orElse();
  }
}

abstract class _PauseVideo implements IntroVideoEvent {
  const factory _PauseVideo() = _$PauseVideoImpl;
}

/// @nodoc
abstract class _$$VideoCompletedImplCopyWith<$Res> {
  factory _$$VideoCompletedImplCopyWith(_$VideoCompletedImpl value,
          $Res Function(_$VideoCompletedImpl) then) =
      __$$VideoCompletedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VideoCompletedImplCopyWithImpl<$Res>
    extends _$IntroVideoEventCopyWithImpl<$Res, _$VideoCompletedImpl>
    implements _$$VideoCompletedImplCopyWith<$Res> {
  __$$VideoCompletedImplCopyWithImpl(
      _$VideoCompletedImpl _value, $Res Function(_$VideoCompletedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$VideoCompletedImpl implements _VideoCompleted {
  const _$VideoCompletedImpl();

  @override
  String toString() {
    return 'IntroVideoEvent.videoCompleted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$VideoCompletedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() setupVideo,
    required TResult Function() playVideo,
    required TResult Function() pauseVideo,
    required TResult Function() videoCompleted,
    required TResult Function() getQuizQuestionlist,
    required TResult Function(int questionIndex, QuizMcqDTO selectedOption)
        optionSelected,
    required TResult Function() submitQuiz,
  }) {
    return videoCompleted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? setupVideo,
    TResult? Function()? playVideo,
    TResult? Function()? pauseVideo,
    TResult? Function()? videoCompleted,
    TResult? Function()? getQuizQuestionlist,
    TResult? Function(int questionIndex, QuizMcqDTO selectedOption)?
        optionSelected,
    TResult? Function()? submitQuiz,
  }) {
    return videoCompleted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? setupVideo,
    TResult Function()? playVideo,
    TResult Function()? pauseVideo,
    TResult Function()? videoCompleted,
    TResult Function()? getQuizQuestionlist,
    TResult Function(int questionIndex, QuizMcqDTO selectedOption)?
        optionSelected,
    TResult Function()? submitQuiz,
    required TResult orElse(),
  }) {
    if (videoCompleted != null) {
      return videoCompleted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetupVideo value) setupVideo,
    required TResult Function(_PlayVideo value) playVideo,
    required TResult Function(_PauseVideo value) pauseVideo,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_GetQuizQuestionList value) getQuizQuestionlist,
    required TResult Function(_OptionSelected value) optionSelected,
    required TResult Function(_SubmitQuiz value) submitQuiz,
  }) {
    return videoCompleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetupVideo value)? setupVideo,
    TResult? Function(_PlayVideo value)? playVideo,
    TResult? Function(_PauseVideo value)? pauseVideo,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_GetQuizQuestionList value)? getQuizQuestionlist,
    TResult? Function(_OptionSelected value)? optionSelected,
    TResult? Function(_SubmitQuiz value)? submitQuiz,
  }) {
    return videoCompleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetupVideo value)? setupVideo,
    TResult Function(_PlayVideo value)? playVideo,
    TResult Function(_PauseVideo value)? pauseVideo,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_GetQuizQuestionList value)? getQuizQuestionlist,
    TResult Function(_OptionSelected value)? optionSelected,
    TResult Function(_SubmitQuiz value)? submitQuiz,
    required TResult orElse(),
  }) {
    if (videoCompleted != null) {
      return videoCompleted(this);
    }
    return orElse();
  }
}

abstract class _VideoCompleted implements IntroVideoEvent {
  const factory _VideoCompleted() = _$VideoCompletedImpl;
}

/// @nodoc
abstract class _$$GetQuizQuestionListImplCopyWith<$Res> {
  factory _$$GetQuizQuestionListImplCopyWith(_$GetQuizQuestionListImpl value,
          $Res Function(_$GetQuizQuestionListImpl) then) =
      __$$GetQuizQuestionListImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetQuizQuestionListImplCopyWithImpl<$Res>
    extends _$IntroVideoEventCopyWithImpl<$Res, _$GetQuizQuestionListImpl>
    implements _$$GetQuizQuestionListImplCopyWith<$Res> {
  __$$GetQuizQuestionListImplCopyWithImpl(_$GetQuizQuestionListImpl _value,
      $Res Function(_$GetQuizQuestionListImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetQuizQuestionListImpl implements _GetQuizQuestionList {
  const _$GetQuizQuestionListImpl();

  @override
  String toString() {
    return 'IntroVideoEvent.getQuizQuestionlist()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetQuizQuestionListImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() setupVideo,
    required TResult Function() playVideo,
    required TResult Function() pauseVideo,
    required TResult Function() videoCompleted,
    required TResult Function() getQuizQuestionlist,
    required TResult Function(int questionIndex, QuizMcqDTO selectedOption)
        optionSelected,
    required TResult Function() submitQuiz,
  }) {
    return getQuizQuestionlist();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? setupVideo,
    TResult? Function()? playVideo,
    TResult? Function()? pauseVideo,
    TResult? Function()? videoCompleted,
    TResult? Function()? getQuizQuestionlist,
    TResult? Function(int questionIndex, QuizMcqDTO selectedOption)?
        optionSelected,
    TResult? Function()? submitQuiz,
  }) {
    return getQuizQuestionlist?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? setupVideo,
    TResult Function()? playVideo,
    TResult Function()? pauseVideo,
    TResult Function()? videoCompleted,
    TResult Function()? getQuizQuestionlist,
    TResult Function(int questionIndex, QuizMcqDTO selectedOption)?
        optionSelected,
    TResult Function()? submitQuiz,
    required TResult orElse(),
  }) {
    if (getQuizQuestionlist != null) {
      return getQuizQuestionlist();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetupVideo value) setupVideo,
    required TResult Function(_PlayVideo value) playVideo,
    required TResult Function(_PauseVideo value) pauseVideo,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_GetQuizQuestionList value) getQuizQuestionlist,
    required TResult Function(_OptionSelected value) optionSelected,
    required TResult Function(_SubmitQuiz value) submitQuiz,
  }) {
    return getQuizQuestionlist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetupVideo value)? setupVideo,
    TResult? Function(_PlayVideo value)? playVideo,
    TResult? Function(_PauseVideo value)? pauseVideo,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_GetQuizQuestionList value)? getQuizQuestionlist,
    TResult? Function(_OptionSelected value)? optionSelected,
    TResult? Function(_SubmitQuiz value)? submitQuiz,
  }) {
    return getQuizQuestionlist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetupVideo value)? setupVideo,
    TResult Function(_PlayVideo value)? playVideo,
    TResult Function(_PauseVideo value)? pauseVideo,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_GetQuizQuestionList value)? getQuizQuestionlist,
    TResult Function(_OptionSelected value)? optionSelected,
    TResult Function(_SubmitQuiz value)? submitQuiz,
    required TResult orElse(),
  }) {
    if (getQuizQuestionlist != null) {
      return getQuizQuestionlist(this);
    }
    return orElse();
  }
}

abstract class _GetQuizQuestionList implements IntroVideoEvent {
  const factory _GetQuizQuestionList() = _$GetQuizQuestionListImpl;
}

/// @nodoc
abstract class _$$OptionSelectedImplCopyWith<$Res> {
  factory _$$OptionSelectedImplCopyWith(_$OptionSelectedImpl value,
          $Res Function(_$OptionSelectedImpl) then) =
      __$$OptionSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int questionIndex, QuizMcqDTO selectedOption});

  $QuizMcqDTOCopyWith<$Res> get selectedOption;
}

/// @nodoc
class __$$OptionSelectedImplCopyWithImpl<$Res>
    extends _$IntroVideoEventCopyWithImpl<$Res, _$OptionSelectedImpl>
    implements _$$OptionSelectedImplCopyWith<$Res> {
  __$$OptionSelectedImplCopyWithImpl(
      _$OptionSelectedImpl _value, $Res Function(_$OptionSelectedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionIndex = null,
    Object? selectedOption = null,
  }) {
    return _then(_$OptionSelectedImpl(
      questionIndex: null == questionIndex
          ? _value.questionIndex
          : questionIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedOption: null == selectedOption
          ? _value.selectedOption
          : selectedOption // ignore: cast_nullable_to_non_nullable
              as QuizMcqDTO,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $QuizMcqDTOCopyWith<$Res> get selectedOption {
    return $QuizMcqDTOCopyWith<$Res>(_value.selectedOption, (value) {
      return _then(_value.copyWith(selectedOption: value));
    });
  }
}

/// @nodoc

class _$OptionSelectedImpl implements _OptionSelected {
  const _$OptionSelectedImpl(
      {required this.questionIndex, required this.selectedOption});

  @override
  final int questionIndex;
  @override
  final QuizMcqDTO selectedOption;

  @override
  String toString() {
    return 'IntroVideoEvent.optionSelected(questionIndex: $questionIndex, selectedOption: $selectedOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OptionSelectedImpl &&
            (identical(other.questionIndex, questionIndex) ||
                other.questionIndex == questionIndex) &&
            (identical(other.selectedOption, selectedOption) ||
                other.selectedOption == selectedOption));
  }

  @override
  int get hashCode => Object.hash(runtimeType, questionIndex, selectedOption);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OptionSelectedImplCopyWith<_$OptionSelectedImpl> get copyWith =>
      __$$OptionSelectedImplCopyWithImpl<_$OptionSelectedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() setupVideo,
    required TResult Function() playVideo,
    required TResult Function() pauseVideo,
    required TResult Function() videoCompleted,
    required TResult Function() getQuizQuestionlist,
    required TResult Function(int questionIndex, QuizMcqDTO selectedOption)
        optionSelected,
    required TResult Function() submitQuiz,
  }) {
    return optionSelected(questionIndex, selectedOption);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? setupVideo,
    TResult? Function()? playVideo,
    TResult? Function()? pauseVideo,
    TResult? Function()? videoCompleted,
    TResult? Function()? getQuizQuestionlist,
    TResult? Function(int questionIndex, QuizMcqDTO selectedOption)?
        optionSelected,
    TResult? Function()? submitQuiz,
  }) {
    return optionSelected?.call(questionIndex, selectedOption);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? setupVideo,
    TResult Function()? playVideo,
    TResult Function()? pauseVideo,
    TResult Function()? videoCompleted,
    TResult Function()? getQuizQuestionlist,
    TResult Function(int questionIndex, QuizMcqDTO selectedOption)?
        optionSelected,
    TResult Function()? submitQuiz,
    required TResult orElse(),
  }) {
    if (optionSelected != null) {
      return optionSelected(questionIndex, selectedOption);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetupVideo value) setupVideo,
    required TResult Function(_PlayVideo value) playVideo,
    required TResult Function(_PauseVideo value) pauseVideo,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_GetQuizQuestionList value) getQuizQuestionlist,
    required TResult Function(_OptionSelected value) optionSelected,
    required TResult Function(_SubmitQuiz value) submitQuiz,
  }) {
    return optionSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetupVideo value)? setupVideo,
    TResult? Function(_PlayVideo value)? playVideo,
    TResult? Function(_PauseVideo value)? pauseVideo,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_GetQuizQuestionList value)? getQuizQuestionlist,
    TResult? Function(_OptionSelected value)? optionSelected,
    TResult? Function(_SubmitQuiz value)? submitQuiz,
  }) {
    return optionSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetupVideo value)? setupVideo,
    TResult Function(_PlayVideo value)? playVideo,
    TResult Function(_PauseVideo value)? pauseVideo,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_GetQuizQuestionList value)? getQuizQuestionlist,
    TResult Function(_OptionSelected value)? optionSelected,
    TResult Function(_SubmitQuiz value)? submitQuiz,
    required TResult orElse(),
  }) {
    if (optionSelected != null) {
      return optionSelected(this);
    }
    return orElse();
  }
}

abstract class _OptionSelected implements IntroVideoEvent {
  const factory _OptionSelected(
      {required final int questionIndex,
      required final QuizMcqDTO selectedOption}) = _$OptionSelectedImpl;

  int get questionIndex;
  QuizMcqDTO get selectedOption;
  @JsonKey(ignore: true)
  _$$OptionSelectedImplCopyWith<_$OptionSelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitQuizImplCopyWith<$Res> {
  factory _$$SubmitQuizImplCopyWith(
          _$SubmitQuizImpl value, $Res Function(_$SubmitQuizImpl) then) =
      __$$SubmitQuizImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmitQuizImplCopyWithImpl<$Res>
    extends _$IntroVideoEventCopyWithImpl<$Res, _$SubmitQuizImpl>
    implements _$$SubmitQuizImplCopyWith<$Res> {
  __$$SubmitQuizImplCopyWithImpl(
      _$SubmitQuizImpl _value, $Res Function(_$SubmitQuizImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SubmitQuizImpl implements _SubmitQuiz {
  const _$SubmitQuizImpl();

  @override
  String toString() {
    return 'IntroVideoEvent.submitQuiz()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubmitQuizImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() setupVideo,
    required TResult Function() playVideo,
    required TResult Function() pauseVideo,
    required TResult Function() videoCompleted,
    required TResult Function() getQuizQuestionlist,
    required TResult Function(int questionIndex, QuizMcqDTO selectedOption)
        optionSelected,
    required TResult Function() submitQuiz,
  }) {
    return submitQuiz();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? setupVideo,
    TResult? Function()? playVideo,
    TResult? Function()? pauseVideo,
    TResult? Function()? videoCompleted,
    TResult? Function()? getQuizQuestionlist,
    TResult? Function(int questionIndex, QuizMcqDTO selectedOption)?
        optionSelected,
    TResult? Function()? submitQuiz,
  }) {
    return submitQuiz?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? setupVideo,
    TResult Function()? playVideo,
    TResult Function()? pauseVideo,
    TResult Function()? videoCompleted,
    TResult Function()? getQuizQuestionlist,
    TResult Function(int questionIndex, QuizMcqDTO selectedOption)?
        optionSelected,
    TResult Function()? submitQuiz,
    required TResult orElse(),
  }) {
    if (submitQuiz != null) {
      return submitQuiz();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetupVideo value) setupVideo,
    required TResult Function(_PlayVideo value) playVideo,
    required TResult Function(_PauseVideo value) pauseVideo,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_GetQuizQuestionList value) getQuizQuestionlist,
    required TResult Function(_OptionSelected value) optionSelected,
    required TResult Function(_SubmitQuiz value) submitQuiz,
  }) {
    return submitQuiz(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetupVideo value)? setupVideo,
    TResult? Function(_PlayVideo value)? playVideo,
    TResult? Function(_PauseVideo value)? pauseVideo,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_GetQuizQuestionList value)? getQuizQuestionlist,
    TResult? Function(_OptionSelected value)? optionSelected,
    TResult? Function(_SubmitQuiz value)? submitQuiz,
  }) {
    return submitQuiz?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetupVideo value)? setupVideo,
    TResult Function(_PlayVideo value)? playVideo,
    TResult Function(_PauseVideo value)? pauseVideo,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_GetQuizQuestionList value)? getQuizQuestionlist,
    TResult Function(_OptionSelected value)? optionSelected,
    TResult Function(_SubmitQuiz value)? submitQuiz,
    required TResult orElse(),
  }) {
    if (submitQuiz != null) {
      return submitQuiz(this);
    }
    return orElse();
  }
}

abstract class _SubmitQuiz implements IntroVideoEvent {
  const factory _SubmitQuiz() = _$SubmitQuizImpl;
}

/// @nodoc
mixin _$IntroVideoState {
  VideoPlayerController? get controller => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  bool get showErrorMessages => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  /// FOR INTRO QUIZ
// required List<QuizModel> questionList,
// required bool showQuizErrorMessages,
// required bool isQuizSubmitting,
  List<QuizDTO> get questions => throw _privateConstructorUsedError;
  List<QuizDTO> get updatedQuestions => throw _privateConstructorUsedError;
  bool get showQuizErrorMessages => throw _privateConstructorUsedError;
  bool get isQuizSubmitting => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, String>> get quizAuthFailureOrSuccessOption =>
      throw _privateConstructorUsedError;
  Option<Either<AccountFailure, List<QuizDTO>>>
      get quizQuestionFailureOrSuccessOption =>
          throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IntroVideoStateCopyWith<IntroVideoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntroVideoStateCopyWith<$Res> {
  factory $IntroVideoStateCopyWith(
          IntroVideoState value, $Res Function(IntroVideoState) then) =
      _$IntroVideoStateCopyWithImpl<$Res, IntroVideoState>;
  @useResult
  $Res call(
      {VideoPlayerController? controller,
      bool isPlaying,
      bool showErrorMessages,
      bool isSubmitting,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
      List<QuizDTO> questions,
      List<QuizDTO> updatedQuestions,
      bool showQuizErrorMessages,
      bool isQuizSubmitting,
      Option<Either<AuthFailure, String>> quizAuthFailureOrSuccessOption,
      Option<Either<AccountFailure, List<QuizDTO>>>
          quizQuestionFailureOrSuccessOption});
}

/// @nodoc
class _$IntroVideoStateCopyWithImpl<$Res, $Val extends IntroVideoState>
    implements $IntroVideoStateCopyWith<$Res> {
  _$IntroVideoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controller = freezed,
    Object? isPlaying = null,
    Object? showErrorMessages = null,
    Object? isSubmitting = null,
    Object? authFailureOrSuccessOption = null,
    Object? questions = null,
    Object? updatedQuestions = null,
    Object? showQuizErrorMessages = null,
    Object? isQuizSubmitting = null,
    Object? quizAuthFailureOrSuccessOption = null,
    Object? quizQuestionFailureOrSuccessOption = null,
  }) {
    return _then(_value.copyWith(
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as VideoPlayerController?,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<QuizDTO>,
      updatedQuestions: null == updatedQuestions
          ? _value.updatedQuestions
          : updatedQuestions // ignore: cast_nullable_to_non_nullable
              as List<QuizDTO>,
      showQuizErrorMessages: null == showQuizErrorMessages
          ? _value.showQuizErrorMessages
          : showQuizErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isQuizSubmitting: null == isQuizSubmitting
          ? _value.isQuizSubmitting
          : isQuizSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      quizAuthFailureOrSuccessOption: null == quizAuthFailureOrSuccessOption
          ? _value.quizAuthFailureOrSuccessOption
          : quizAuthFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
      quizQuestionFailureOrSuccessOption: null ==
              quizQuestionFailureOrSuccessOption
          ? _value.quizQuestionFailureOrSuccessOption
          : quizQuestionFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AccountFailure, List<QuizDTO>>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntroVideoStateImplCopyWith<$Res>
    implements $IntroVideoStateCopyWith<$Res> {
  factory _$$IntroVideoStateImplCopyWith(_$IntroVideoStateImpl value,
          $Res Function(_$IntroVideoStateImpl) then) =
      __$$IntroVideoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {VideoPlayerController? controller,
      bool isPlaying,
      bool showErrorMessages,
      bool isSubmitting,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
      List<QuizDTO> questions,
      List<QuizDTO> updatedQuestions,
      bool showQuizErrorMessages,
      bool isQuizSubmitting,
      Option<Either<AuthFailure, String>> quizAuthFailureOrSuccessOption,
      Option<Either<AccountFailure, List<QuizDTO>>>
          quizQuestionFailureOrSuccessOption});
}

/// @nodoc
class __$$IntroVideoStateImplCopyWithImpl<$Res>
    extends _$IntroVideoStateCopyWithImpl<$Res, _$IntroVideoStateImpl>
    implements _$$IntroVideoStateImplCopyWith<$Res> {
  __$$IntroVideoStateImplCopyWithImpl(
      _$IntroVideoStateImpl _value, $Res Function(_$IntroVideoStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controller = freezed,
    Object? isPlaying = null,
    Object? showErrorMessages = null,
    Object? isSubmitting = null,
    Object? authFailureOrSuccessOption = null,
    Object? questions = null,
    Object? updatedQuestions = null,
    Object? showQuizErrorMessages = null,
    Object? isQuizSubmitting = null,
    Object? quizAuthFailureOrSuccessOption = null,
    Object? quizQuestionFailureOrSuccessOption = null,
  }) {
    return _then(_$IntroVideoStateImpl(
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as VideoPlayerController?,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<QuizDTO>,
      updatedQuestions: null == updatedQuestions
          ? _value._updatedQuestions
          : updatedQuestions // ignore: cast_nullable_to_non_nullable
              as List<QuizDTO>,
      showQuizErrorMessages: null == showQuizErrorMessages
          ? _value.showQuizErrorMessages
          : showQuizErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isQuizSubmitting: null == isQuizSubmitting
          ? _value.isQuizSubmitting
          : isQuizSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      quizAuthFailureOrSuccessOption: null == quizAuthFailureOrSuccessOption
          ? _value.quizAuthFailureOrSuccessOption
          : quizAuthFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
      quizQuestionFailureOrSuccessOption: null ==
              quizQuestionFailureOrSuccessOption
          ? _value.quizQuestionFailureOrSuccessOption
          : quizQuestionFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AccountFailure, List<QuizDTO>>>,
    ));
  }
}

/// @nodoc

class _$IntroVideoStateImpl implements _IntroVideoState {
  const _$IntroVideoStateImpl(
      {required this.controller,
      required this.isPlaying,
      required this.showErrorMessages,
      required this.isSubmitting,
      required this.authFailureOrSuccessOption,
      required final List<QuizDTO> questions,
      required final List<QuizDTO> updatedQuestions,
      required this.showQuizErrorMessages,
      required this.isQuizSubmitting,
      required this.quizAuthFailureOrSuccessOption,
      required this.quizQuestionFailureOrSuccessOption})
      : _questions = questions,
        _updatedQuestions = updatedQuestions;

  @override
  final VideoPlayerController? controller;
  @override
  final bool isPlaying;
  @override
  final bool showErrorMessages;
  @override
  final bool isSubmitting;
  @override
  final Option<Either<AuthFailure, String>> authFailureOrSuccessOption;

  /// FOR INTRO QUIZ
// required List<QuizModel> questionList,
// required bool showQuizErrorMessages,
// required bool isQuizSubmitting,
  final List<QuizDTO> _questions;

  /// FOR INTRO QUIZ
// required List<QuizModel> questionList,
// required bool showQuizErrorMessages,
// required bool isQuizSubmitting,
  @override
  List<QuizDTO> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  final List<QuizDTO> _updatedQuestions;
  @override
  List<QuizDTO> get updatedQuestions {
    if (_updatedQuestions is EqualUnmodifiableListView)
      return _updatedQuestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_updatedQuestions);
  }

  @override
  final bool showQuizErrorMessages;
  @override
  final bool isQuizSubmitting;
  @override
  final Option<Either<AuthFailure, String>> quizAuthFailureOrSuccessOption;
  @override
  final Option<Either<AccountFailure, List<QuizDTO>>>
      quizQuestionFailureOrSuccessOption;

  @override
  String toString() {
    return 'IntroVideoState(controller: $controller, isPlaying: $isPlaying, showErrorMessages: $showErrorMessages, isSubmitting: $isSubmitting, authFailureOrSuccessOption: $authFailureOrSuccessOption, questions: $questions, updatedQuestions: $updatedQuestions, showQuizErrorMessages: $showQuizErrorMessages, isQuizSubmitting: $isQuizSubmitting, quizAuthFailureOrSuccessOption: $quizAuthFailureOrSuccessOption, quizQuestionFailureOrSuccessOption: $quizQuestionFailureOrSuccessOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntroVideoStateImpl &&
            (identical(other.controller, controller) ||
                other.controller == controller) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                other.showErrorMessages == showErrorMessages) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.authFailureOrSuccessOption,
                    authFailureOrSuccessOption) ||
                other.authFailureOrSuccessOption ==
                    authFailureOrSuccessOption) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions) &&
            const DeepCollectionEquality()
                .equals(other._updatedQuestions, _updatedQuestions) &&
            (identical(other.showQuizErrorMessages, showQuizErrorMessages) ||
                other.showQuizErrorMessages == showQuizErrorMessages) &&
            (identical(other.isQuizSubmitting, isQuizSubmitting) ||
                other.isQuizSubmitting == isQuizSubmitting) &&
            (identical(other.quizAuthFailureOrSuccessOption,
                    quizAuthFailureOrSuccessOption) ||
                other.quizAuthFailureOrSuccessOption ==
                    quizAuthFailureOrSuccessOption) &&
            (identical(other.quizQuestionFailureOrSuccessOption,
                    quizQuestionFailureOrSuccessOption) ||
                other.quizQuestionFailureOrSuccessOption ==
                    quizQuestionFailureOrSuccessOption));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      controller,
      isPlaying,
      showErrorMessages,
      isSubmitting,
      authFailureOrSuccessOption,
      const DeepCollectionEquality().hash(_questions),
      const DeepCollectionEquality().hash(_updatedQuestions),
      showQuizErrorMessages,
      isQuizSubmitting,
      quizAuthFailureOrSuccessOption,
      quizQuestionFailureOrSuccessOption);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntroVideoStateImplCopyWith<_$IntroVideoStateImpl> get copyWith =>
      __$$IntroVideoStateImplCopyWithImpl<_$IntroVideoStateImpl>(
          this, _$identity);
}

abstract class _IntroVideoState implements IntroVideoState {
  const factory _IntroVideoState(
      {required final VideoPlayerController? controller,
      required final bool isPlaying,
      required final bool showErrorMessages,
      required final bool isSubmitting,
      required final Option<Either<AuthFailure, String>>
          authFailureOrSuccessOption,
      required final List<QuizDTO> questions,
      required final List<QuizDTO> updatedQuestions,
      required final bool showQuizErrorMessages,
      required final bool isQuizSubmitting,
      required final Option<Either<AuthFailure, String>>
          quizAuthFailureOrSuccessOption,
      required final Option<Either<AccountFailure, List<QuizDTO>>>
          quizQuestionFailureOrSuccessOption}) = _$IntroVideoStateImpl;

  @override
  VideoPlayerController? get controller;
  @override
  bool get isPlaying;
  @override
  bool get showErrorMessages;
  @override
  bool get isSubmitting;
  @override
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption;
  @override

  /// FOR INTRO QUIZ
// required List<QuizModel> questionList,
// required bool showQuizErrorMessages,
// required bool isQuizSubmitting,
  List<QuizDTO> get questions;
  @override
  List<QuizDTO> get updatedQuestions;
  @override
  bool get showQuizErrorMessages;
  @override
  bool get isQuizSubmitting;
  @override
  Option<Either<AuthFailure, String>> get quizAuthFailureOrSuccessOption;
  @override
  Option<Either<AccountFailure, List<QuizDTO>>>
      get quizQuestionFailureOrSuccessOption;
  @override
  @JsonKey(ignore: true)
  _$$IntroVideoStateImplCopyWith<_$IntroVideoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
