import 'package:sample/features/movies/data/datasources/remote_data_source.dart';
import 'package:sample/features/movies/domain/entities/movie_detail_entity.dart';

/// Repository contract for fetching movie list data (domain layer).
abstract class DashboardRepository {
  Future<MovieEntity> fetchProducts({int? page, String? filter});
}

/// Implementation that uses [DashboardDataSource] and maps [MovieDetail]
/// model to [MovieEntity] / [ResultEntity] for the domain.
class DashboardRepositoryImpl extends DashboardRepository {
  DashboardRepositoryImpl(this.dashboardDatasource);
  final DashboardDataSource dashboardDatasource;

  @override
  Future<MovieEntity> fetchProducts({int? page, String? filter}) async {
    final model = await dashboardDatasource.getMovies(
      page: page,
      filter: filter,
    );
    return MovieEntity(
      page: model.page,
      totalPages: model.totalPages,
      totalResults: model.totalResults,
      results: model.results
          ?.map(
            (r) => ResultEntity(
              adult: r.adult,
              backdropPath: r.backdropPath,
              genreIds: r.genreIds,
              id: r.id,
              originalLanguage: r.originalLanguage,
              originalTitle: r.originalTitle,
              overview: r.overview,
              popularity: r.popularity,
              posterPath: r.posterPath,
              releaseDate: r.releaseDate,
              title: r.title,
              video: r.video,
              voteAverage: r.voteAverage,
              voteCount: r.voteCount,
            ),
          )
          .toList(),
    );
  }
}
