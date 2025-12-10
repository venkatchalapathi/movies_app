import 'package:movies_app/data/models/movie_model.dart';
import 'package:movies_app/data/services/database_service.dart';
import 'package:movies_app/data/services/movie_api_service.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService _apiService;
  final DatabaseService _databaseService;

  MovieRepositoryImpl({
    required MovieApiService apiService,
    required DatabaseService databaseService,
  })  : _apiService = apiService,
        _databaseService = databaseService;

  @override
  Future<List<Movie>> getPopularMovies() async {
    return await _apiService.getPopularMovies();
  }

  @override
  Future<Movie> getMovieDetails(int movieId) async {
    return await _apiService.getMovieDetails(movieId);
  }

  @override
  Future<List<Movie>> getFavoriteMovies() async {
    return await _databaseService.getFavorites();
  }

  @override
  Future<void> addToFavorites(Movie movie) async {
    await _databaseService.insertFavorite(MovieModel(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      posterPath: movie.posterPath,
      backdropPath: movie.backdropPath,
      releaseDate: movie.releaseDate,
      voteAverage: movie.voteAverage,
      popularity: movie.popularity,
    ));
  }

  @override
  Future<void> removeFromFavorites(int movieId) async {
    await _databaseService.deleteFavorite(movieId);
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    return await _databaseService.isFavorite(movieId);
  }
}

