import 'package:flutter/foundation.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/movie_repository.dart';

class MovieProvider with ChangeNotifier {
  final MovieRepository _repository;

  MovieProvider(this._repository);

  List<Movie> _movies = [];
  List<Movie> _favoriteMovies = [];
  bool _isLoading = false;
  String? _error;

  List<Movie> get movies => _movies;
  List<Movie> get favoriteMovies => _favoriteMovies;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadMovies() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _movies = await _repository.getPopularMovies();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadFavoriteMovies() async {
    try {
      _favoriteMovies = await _repository.getFavoriteMovies();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(Movie movie) async {
    try {
      final isFavorite = await _repository.isFavorite(movie.id);
      if (isFavorite) {
        await _repository.removeFromFavorites(movie.id);
      } else {
        await _repository.addToFavorites(movie);
      }
      await loadFavoriteMovies();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> checkIsFavorite(int movieId) async {
    try {
      return await _repository.isFavorite(movieId);
    } catch (e) {
      return false;
    }
  }
}

