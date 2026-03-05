/// API-related constants for TMDB (The Movie Database) and request configuration.
class ApiConstants {
  /// Builds the movie list endpoint URL with [page] and [filter] (e.g. popular, top_rated).
  static String apiURL(int page, String filter) =>
      'https://api.themoviedb.org/3/movie/$filter?page=$page';

  /// HTTP header key for authorization (Bearer token).
  static String authorization = 'Authorization';

  /// Base URL for TMDB poster images (w342 size).
  static String imageUrl = 'https://image.tmdb.org/t/p/w342';

  }
