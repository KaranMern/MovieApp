import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_detail_entity.freezed.dart';

/// Domain entity: paginated movie list (mirrors API structure).
@freezed
class MovieEntity with _$MovieEntity {
  const factory MovieEntity({
    int? page,
    List<ResultEntity>? results,
    int? totalPages,
    int? totalResults,
  }) = _MovieEntity;
}

/// Domain entity: single movie result for list and detail screens.
@freezed
class ResultEntity with _$ResultEntity {
  const factory ResultEntity({
    bool? adult,
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
    int? voteCount,
  }) = _ResultEntity;
}
