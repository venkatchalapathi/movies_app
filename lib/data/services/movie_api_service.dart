import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/config/api_config.dart';
import 'package:movies_app/data/models/movie_model.dart';

class MovieApiService {
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/movie/popular?api_key=${ApiConfig.apiKey}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final results = data['results'] as List;
        return results.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching movies: $e');
    }
  }

  Future<MovieModel> getMovieDetails(int movieId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/movie/$movieId?api_key=${ApiConfig.apiKey}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return MovieModel.fromJson(data);
      } else {
        throw Exception('Failed to load movie details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching movie details: $e');
    }
  }
}

