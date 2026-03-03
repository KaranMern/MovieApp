// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_detail_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MovieEntity {
  int? get page => throw _privateConstructorUsedError;
  List<ResultEntity>? get results => throw _privateConstructorUsedError;
  int? get totalPages => throw _privateConstructorUsedError;
  int? get totalResults => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MovieEntityCopyWith<MovieEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieEntityCopyWith<$Res> {
  factory $MovieEntityCopyWith(
          MovieEntity value, $Res Function(MovieEntity) then) =
      _$MovieEntityCopyWithImpl<$Res, MovieEntity>;
  @useResult
  $Res call(
      {int? page,
      List<ResultEntity>? results,
      int? totalPages,
      int? totalResults});
}

/// @nodoc
class _$MovieEntityCopyWithImpl<$Res, $Val extends MovieEntity>
    implements $MovieEntityCopyWith<$Res> {
  _$MovieEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? results = freezed,
    Object? totalPages = freezed,
    Object? totalResults = freezed,
  }) {
    return _then(_value.copyWith(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      results: freezed == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<ResultEntity>?,
      totalPages: freezed == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int?,
      totalResults: freezed == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MovieEntityImplCopyWith<$Res>
    implements $MovieEntityCopyWith<$Res> {
  factory _$$MovieEntityImplCopyWith(
          _$MovieEntityImpl value, $Res Function(_$MovieEntityImpl) then) =
      __$$MovieEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? page,
      List<ResultEntity>? results,
      int? totalPages,
      int? totalResults});
}

/// @nodoc
class __$$MovieEntityImplCopyWithImpl<$Res>
    extends _$MovieEntityCopyWithImpl<$Res, _$MovieEntityImpl>
    implements _$$MovieEntityImplCopyWith<$Res> {
  __$$MovieEntityImplCopyWithImpl(
      _$MovieEntityImpl _value, $Res Function(_$MovieEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? results = freezed,
    Object? totalPages = freezed,
    Object? totalResults = freezed,
  }) {
    return _then(_$MovieEntityImpl(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      results: freezed == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<ResultEntity>?,
      totalPages: freezed == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int?,
      totalResults: freezed == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$MovieEntityImpl implements _MovieEntity {
  const _$MovieEntityImpl(
      {this.page,
      final List<ResultEntity>? results,
      this.totalPages,
      this.totalResults})
      : _results = results;

  @override
  final int? page;
  final List<ResultEntity>? _results;
  @override
  List<ResultEntity>? get results {
    final value = _results;
    if (value == null) return null;
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? totalPages;
  @override
  final int? totalResults;

  @override
  String toString() {
    return 'MovieEntity(page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieEntityImpl &&
            (identical(other.page, page) || other.page == page) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults));
  }

  @override
  int get hashCode => Object.hash(runtimeType, page,
      const DeepCollectionEquality().hash(_results), totalPages, totalResults);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieEntityImplCopyWith<_$MovieEntityImpl> get copyWith =>
      __$$MovieEntityImplCopyWithImpl<_$MovieEntityImpl>(this, _$identity);
}

abstract class _MovieEntity implements MovieEntity {
  const factory _MovieEntity(
      {final int? page,
      final List<ResultEntity>? results,
      final int? totalPages,
      final int? totalResults}) = _$MovieEntityImpl;

  @override
  int? get page;
  @override
  List<ResultEntity>? get results;
  @override
  int? get totalPages;
  @override
  int? get totalResults;
  @override
  @JsonKey(ignore: true)
  _$$MovieEntityImplCopyWith<_$MovieEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ResultEntity {
  bool? get adult => throw _privateConstructorUsedError;
  String? get backdropPath => throw _privateConstructorUsedError;
  List<int>? get genreIds => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get originalLanguage => throw _privateConstructorUsedError;
  String? get originalTitle => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  double? get popularity => throw _privateConstructorUsedError;
  String? get posterPath => throw _privateConstructorUsedError;
  String? get releaseDate => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  bool? get video => throw _privateConstructorUsedError;
  double? get voteAverage => throw _privateConstructorUsedError;
  int? get voteCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ResultEntityCopyWith<ResultEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultEntityCopyWith<$Res> {
  factory $ResultEntityCopyWith(
          ResultEntity value, $Res Function(ResultEntity) then) =
      _$ResultEntityCopyWithImpl<$Res, ResultEntity>;
  @useResult
  $Res call(
      {bool? adult,
      String? backdropPath,
      List<int>? genreIds,
      int? id,
      String? originalLanguage,
      String? originalTitle,
      String? overview,
      double? popularity,
      String? posterPath,
      String? releaseDate,
      String? title,
      bool? video,
      double? voteAverage,
      int? voteCount});
}

/// @nodoc
class _$ResultEntityCopyWithImpl<$Res, $Val extends ResultEntity>
    implements $ResultEntityCopyWith<$Res> {
  _$ResultEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adult = freezed,
    Object? backdropPath = freezed,
    Object? genreIds = freezed,
    Object? id = freezed,
    Object? originalLanguage = freezed,
    Object? originalTitle = freezed,
    Object? overview = freezed,
    Object? popularity = freezed,
    Object? posterPath = freezed,
    Object? releaseDate = freezed,
    Object? title = freezed,
    Object? video = freezed,
    Object? voteAverage = freezed,
    Object? voteCount = freezed,
  }) {
    return _then(_value.copyWith(
      adult: freezed == adult
          ? _value.adult
          : adult // ignore: cast_nullable_to_non_nullable
              as bool?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      genreIds: freezed == genreIds
          ? _value.genreIds
          : genreIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      originalLanguage: freezed == originalLanguage
          ? _value.originalLanguage
          : originalLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      originalTitle: freezed == originalTitle
          ? _value.originalTitle
          : originalTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      popularity: freezed == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      video: freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as bool?,
      voteAverage: freezed == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double?,
      voteCount: freezed == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResultEntityImplCopyWith<$Res>
    implements $ResultEntityCopyWith<$Res> {
  factory _$$ResultEntityImplCopyWith(
          _$ResultEntityImpl value, $Res Function(_$ResultEntityImpl) then) =
      __$$ResultEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? adult,
      String? backdropPath,
      List<int>? genreIds,
      int? id,
      String? originalLanguage,
      String? originalTitle,
      String? overview,
      double? popularity,
      String? posterPath,
      String? releaseDate,
      String? title,
      bool? video,
      double? voteAverage,
      int? voteCount});
}

/// @nodoc
class __$$ResultEntityImplCopyWithImpl<$Res>
    extends _$ResultEntityCopyWithImpl<$Res, _$ResultEntityImpl>
    implements _$$ResultEntityImplCopyWith<$Res> {
  __$$ResultEntityImplCopyWithImpl(
      _$ResultEntityImpl _value, $Res Function(_$ResultEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adult = freezed,
    Object? backdropPath = freezed,
    Object? genreIds = freezed,
    Object? id = freezed,
    Object? originalLanguage = freezed,
    Object? originalTitle = freezed,
    Object? overview = freezed,
    Object? popularity = freezed,
    Object? posterPath = freezed,
    Object? releaseDate = freezed,
    Object? title = freezed,
    Object? video = freezed,
    Object? voteAverage = freezed,
    Object? voteCount = freezed,
  }) {
    return _then(_$ResultEntityImpl(
      adult: freezed == adult
          ? _value.adult
          : adult // ignore: cast_nullable_to_non_nullable
              as bool?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      genreIds: freezed == genreIds
          ? _value._genreIds
          : genreIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      originalLanguage: freezed == originalLanguage
          ? _value.originalLanguage
          : originalLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      originalTitle: freezed == originalTitle
          ? _value.originalTitle
          : originalTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      popularity: freezed == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      video: freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as bool?,
      voteAverage: freezed == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double?,
      voteCount: freezed == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$ResultEntityImpl implements _ResultEntity {
  const _$ResultEntityImpl(
      {this.adult,
      this.backdropPath,
      final List<int>? genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount})
      : _genreIds = genreIds;

  @override
  final bool? adult;
  @override
  final String? backdropPath;
  final List<int>? _genreIds;
  @override
  List<int>? get genreIds {
    final value = _genreIds;
    if (value == null) return null;
    if (_genreIds is EqualUnmodifiableListView) return _genreIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? id;
  @override
  final String? originalLanguage;
  @override
  final String? originalTitle;
  @override
  final String? overview;
  @override
  final double? popularity;
  @override
  final String? posterPath;
  @override
  final String? releaseDate;
  @override
  final String? title;
  @override
  final bool? video;
  @override
  final double? voteAverage;
  @override
  final int? voteCount;

  @override
  String toString() {
    return 'ResultEntity(adult: $adult, backdropPath: $backdropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultEntityImpl &&
            (identical(other.adult, adult) || other.adult == adult) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            const DeepCollectionEquality().equals(other._genreIds, _genreIds) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.originalLanguage, originalLanguage) ||
                other.originalLanguage == originalLanguage) &&
            (identical(other.originalTitle, originalTitle) ||
                other.originalTitle == originalTitle) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.popularity, popularity) ||
                other.popularity == popularity) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.voteAverage, voteAverage) ||
                other.voteAverage == voteAverage) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      adult,
      backdropPath,
      const DeepCollectionEquality().hash(_genreIds),
      id,
      originalLanguage,
      originalTitle,
      overview,
      popularity,
      posterPath,
      releaseDate,
      title,
      video,
      voteAverage,
      voteCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultEntityImplCopyWith<_$ResultEntityImpl> get copyWith =>
      __$$ResultEntityImplCopyWithImpl<_$ResultEntityImpl>(this, _$identity);
}

abstract class _ResultEntity implements ResultEntity {
  const factory _ResultEntity(
      {final bool? adult,
      final String? backdropPath,
      final List<int>? genreIds,
      final int? id,
      final String? originalLanguage,
      final String? originalTitle,
      final String? overview,
      final double? popularity,
      final String? posterPath,
      final String? releaseDate,
      final String? title,
      final bool? video,
      final double? voteAverage,
      final int? voteCount}) = _$ResultEntityImpl;

  @override
  bool? get adult;
  @override
  String? get backdropPath;
  @override
  List<int>? get genreIds;
  @override
  int? get id;
  @override
  String? get originalLanguage;
  @override
  String? get originalTitle;
  @override
  String? get overview;
  @override
  double? get popularity;
  @override
  String? get posterPath;
  @override
  String? get releaseDate;
  @override
  String? get title;
  @override
  bool? get video;
  @override
  double? get voteAverage;
  @override
  int? get voteCount;
  @override
  @JsonKey(ignore: true)
  _$$ResultEntityImplCopyWith<_$ResultEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
