// integration_test/helpers/mock_data.dart

import 'package:sample/features/movies/domain/entities/movie_detail_entity.dart';

class MockData {
  static MovieEntity movieEntity = MovieEntity(
    page: 1,
    totalPages: 2,
    totalResults: 20,
    results: [
      ResultEntity(
        id: 1,
        title: 'Avengers',
        posterPath: '/poster.jpg',
        releaseDate: '2024-04-01',
        voteAverage: 8.5,
        adult: false,
        video: false,
        genreIds: [28],
        popularity: 100.0,
        overview: 'A great movie',
        originalLanguage: 'en',
        originalTitle: 'Avengers',
        voteCount: 1000,
      ),
      ResultEntity(
        id: 2,
        title: 'Spider-Man',
        posterPath: '/spiderman.jpg',
        releaseDate: '2024-05-01',
        voteAverage: 7.5,
        adult: false,
        video: false,
        genreIds: [28, 12],
        popularity: 90.0,
        overview: 'Spider-Man movie',
        originalLanguage: 'en',
        originalTitle: 'Spider-Man',
        voteCount: 800,
      ),
    ],
  );
}