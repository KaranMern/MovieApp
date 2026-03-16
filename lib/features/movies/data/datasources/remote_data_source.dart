import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sample/core/Constants/api_constants.dart';
import 'package:sample/core/error/dio_exception.dart';
import 'package:sample/core/error/exception.dart';
import 'package:sample/features/movies/data/models/movie_detail.dart';

/// Contract for fetching paginated movie list data from a remote source.
abstract class DashboardDataSource {
  Future<MovieDetail> getMovies({int? page, String? filter});
}

/// Remote data source implementation using Dio and TMDB API.
/// Uses [apidio] for HTTP and [apiToken] (from env or constructor) for auth.
class MoviesDataSource extends DashboardDataSource {
  MoviesDataSource({
    required this.apidio,
    String? apiToken,
  }) : apiToken = apiToken ?? dotenv.env['MOVIE_API_TOKEN'];

  final Dio apidio;
  final String? apiToken;

  @override
  Future<MovieDetail> getMovies({int? page, String? filter}) async {
    try {
      final response = await apidio.get(
        ApiConstants.apiURL(page ?? 1, filter ?? 'popular'),
        options: Options(
          headers: {ApiConstants.authorization: apiToken},
        ),
      );

      if (response.statusCode == 200) {
        return MovieDetail.fromJson(response.data);
      } else {
        throw ServerException(message: 'Failed to get Movie Details');
      }
    } on DioException catch (e) {
      throw DioExceptionMapper.map(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
