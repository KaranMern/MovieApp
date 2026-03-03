class ApiConstants {
  static String apiURL(int page,String filter) =>
      "https://api.themoviedb.org/3/movie/${filter}?page=${page}";
  static String authorization = "Authorization";
  static String imageUrl = "https://image.tmdb.org/t/p/w342";
  static String token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NDI5MTMxNDliZTM0YmQyNWM0MzkyMzM5NjBhODY4OSIsIm5iZiI6MTczMTMyMjkxMS41MDg5OTk4LCJzdWIiOiI2NzMxZTQxZmI2YTJhOWYxNGEyYjgxM2YiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.gPmYQ1cCHcOArRDo0jmoWteZN1Vuvx4k1cLgV8eQ250";
}
