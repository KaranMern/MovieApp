import 'package:dio/dio.dart';
import 'package:sample/core/error/exception.dart';
import '../../../../core/Constants/api_constants.dart';
import '../../../../core/Constants/string_constants.dart';
import '../../../../core/error/dio_exception.dart';
import '../../../../core/network/secure_storage.dart';
import '../models/movie_detail.dart';

abstract class DashboardDataSource {
  Future<MovieDetail> getMovies({int? page, String? filter});
}

class MoviesDataSource extends DashboardDataSource {
  final Dio Apidio;
  final SecureStorageBase secureStorageBase;
  // final FirebaseCrashlytics crashlytics;
  MoviesDataSource({required this.Apidio, required this.secureStorageBase});

  @override
  Future<MovieDetail> getMovies({int? page, String? filter}) async {
    try {
      final token = await secureStorageBase.getValue(Constants.apiToken);
      final response = await Apidio.get(
        "${ApiConstants.apiURL(page ?? 1, filter ?? 'popular')}",
        options: Options(
          headers: {"${ApiConstants.authorization}": "${token}"},
        ),
      );

      if (response.statusCode == 200) {
        return MovieDetail.fromJson(response.data);
      } else {
        throw ServerException(message: "Failed to get Movie Details");
      }
    }
    // crashlytics.recordError(e, st);
    on DioException catch (e) {
      throw DioExceptionMapper.map(e);
    } catch (e, stackTrace) {
      // crashlytics.recordError(e, stackTrace);
      throw ServerException(message: e.toString());
    }
  }
}
