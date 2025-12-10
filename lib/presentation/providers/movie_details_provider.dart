import 'package:flutter/foundation.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/movie_repository.dart';

class MovieDetailsProvider with ChangeNotifier {
  final MovieRepository _repository;

  MovieDetailsProvider(this._repository);

  Movie? _movie;
  bool _isLoading = false;
  String? _error;
  bool _isFavorite = false;

  Movie? get movie => _movie;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isFavorite => _isFavorite;

  Future<void> loadMovieDetails(int movieId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _movie = await _repository.getMovieDetails(movieId);
      _isFavorite = await _repository.isFavorite(movieId);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite() async {
    if (_movie == null) return;

    try {
      if (_isFavorite) {
        await _repository.removeFromFavorites(_movie!.id);
        _isFavorite = false;
      } else {
        await _repository.addToFavorites(_movie!);
        _isFavorite = true;
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}

