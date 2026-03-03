import '../../data/datasources/remote_data_source.dart';
import '../entities/movie_detail_entity.dart';

abstract class DashboardRepository {
  Future<MovieEntity> fetchProducts({int? page, String? filter});
}

class DashboardRepositoryImpl extends DashboardRepository {
  final DashboardDataSource dashboardDatasource;

  DashboardRepositoryImpl(this.dashboardDatasource);

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
