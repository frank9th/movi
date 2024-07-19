import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

const token =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4MTg2ODAzZDIyNjE5OGFlYzk3NTMyYjgxYzkyM2E2ZCIsIm5iZiI6MTcyMTIyMDU5MS42ODc5Nywic3ViIjoiNjY5N2I1NjA5NDNhMTNiNDU2YTlmZTE1Iiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.RhJ1knS8bAVnQlcTyc-VaYRpC7ojhqtRHcYqnsrihp8';

class MovieProvider extends ChangeNotifier {
  final _apiKey = '8186803d226198aec97532b81c923a6d'; // Replace with your TMDB API key
  final _baseUrl = 'https://api.themoviedb.org/3/';

  List<Movie> _trendingMovies = [];
  List<Genre> _genres = [];
  String _searchQuery = '';

  List<Movie> get trendingMovies => _trendingMovies;
  List<Genre> get genres => _genres;
  String get searchQuery => _searchQuery;

  bool isLoading = true;

  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
  };

  Future<List<Movie>> fetchTrendingMovies() async {
    try {
      final response = await http.get(Uri.parse('${_baseUrl}trending/movie/day?language=en-US'),
          headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final movies = data['results'] as List;
        if (kDebugMode) {
          print(movies.length);
          print('The movie list from network');
        }
        _trendingMovies = movies.map((movie) => Movie.fromJson(movie)).toList();
        isLoading = false;
        notifyListeners();
        print('notified listiners');
      } else {
        if (kDebugMode) {
          print('Error fetching trending movies: ${response.statusCode}');
          print('Respons body: ${response.body}');
          print(response.request?.url);
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching trending movies: $error');
      }
    }
    isLoading = false;
    notifyListeners();
    return _trendingMovies;
  }

  Future<void> fetchGenres() async {
    try {
      final response =
          await http.get(Uri.parse('${_baseUrl}genre/movie/list?language=en'), headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final genres = data['genres'] as List;
        _genres = genres.map((genre) => Genre.fromJson(genre)).toList();
        notifyListeners();
      } else {
        if (kDebugMode) {
          print('Error fetching genres: ${response.statusCode}');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching genres: $error');
      }
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Add functions for search, fetching movie details, etc. (refer to TMDB API documentation)

  List<Movie> getMoviesByCategory(String category) {
    // Implement logic to filter movies based on category (e.g., trending, top rated)
    // This example assumes filtering by the 'title' property for demonstration
    return _trendingMovies
        .where((movie) => movie.title.toLowerCase().contains(category.toLowerCase()))
        .toList();
  }

  List<Movie> getTopRatedMovies() {
    // Sort movies by voteAverage in descending order (highest first)

    print('the solting list: ${_trendingMovies.length}');
    return _trendingMovies.toList()..sort((a, b) => b.voteAverage.compareTo(a.voteAverage));
  }
}
