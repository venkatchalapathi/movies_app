import 'package:movies_app/domain/entities/movie.dart';

abstract class MovieRepository {

  Future<List<Movie>> getPopularMovies();

  Future<Movie> getMovieDetails(int movieId);

  Future<List<Movie>> getFavoriteMovies();

  Future<void> addToFavorites(Movie movie);

  Future<void> removeFromFavorites(int movieId);

  Future<bool> isFavorite(int movieId);
}

