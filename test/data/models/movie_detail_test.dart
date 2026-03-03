// test/data/models/movie_detail_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:sample/features/Movies/data/models/movie_detail.dart';

void main() {
  group('MovieDetail Model', () {
    final tJson = {
      'page': 1,
      'results': [
        {
          'adult': false,
          'backdrop_path': '/path.jpg',
          'genre_ids': [28, 12],
          'id': 1,
          'original_language': 'en',
          'original_title': 'Test Movie',
          'overview': 'A test movie.',
          'popularity': 9.5,
          'poster_path': '/poster.jpg',
          'release_date': '2024-01-01',
          'title': 'Test Movie',
          'video': false,
          'vote_average': 8.0,
          'vote_count': 1000,
        },
      ],
      'total_pages': 5,
      'total_results': 100,
    };

    test('fromJson should correctly parse a valid JSON map', () {
      final result = MovieDetail.fromJson(tJson);

      expect(result.page, 1);
      expect(result.totalPages, 5);
      expect(result.totalResults, 100);
      expect(result.results, isNotNull);
      expect(result.results!.length, 1);
    });

    test('toJson should return a valid map', () {
      final model = MovieDetail.fromJson(tJson);
      final json = model.toJson();

      expect(json['page'], 1);
      expect(json['total_pages'], 5);
      expect(json['results'], isA<List>());
    });

    test('results list is empty when json results is null', () {
      final json = {
        'page': 1,
        'results': null,
        'total_pages': 1,
        'total_results': 0,
      };
      final result = MovieDetail.fromJson(json);
      expect(result.results, isNull);
    });
  });

  group('Results Model', () {
    final tResultJson = {
      'adult': false,
      'backdrop_path': '/path.jpg',
      'genre_ids': [28, 12],
      'id': 42,
      'original_language': 'en',
      'original_title': 'Origin',
      'overview': 'Overview text',
      'popularity': 7.3,
      'poster_path': '/poster.jpg',
      'release_date': '2024-06-15',
      'title': 'Movie Title',
      'video': false,
      'vote_average': 7.5,
      'vote_count': 500,
    };

    test('fromJson parses all fields correctly', () {
      final result = Results.fromJson(tResultJson);

      expect(result.id, 42);
      expect(result.title, 'Movie Title');
      expect(result.voteAverage, 7.5);
      expect(result.genreIds, [28, 12]);
      expect(result.adult, false);
    });

    test('toJson returns correct map', () {
      final result = Results.fromJson(tResultJson);
      final json = result.toJson();

      expect(json['id'], 42);
      expect(json['title'], 'Movie Title');
    });
  });
}
