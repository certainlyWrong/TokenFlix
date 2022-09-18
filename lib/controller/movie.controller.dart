import 'dart:convert';
import 'package:tokenflix/model/movie.model.dart';
import 'package:tokenflix/service/tokenflix.service.dart';

class MovieController {
  List<MovieModel> _movies = [];
  final Set<int> _favorites = {};
  final TokenFlixService _tokenFlixService;

  MovieController._({required TokenFlixService tokenFlixService})
      : _tokenFlixService = tokenFlixService;

  factory MovieController.create() =>
      MovieController._(tokenFlixService: TokenFlixService.create());

  Future<List<MovieModel>> loadFavorites() async {
    if (_favorites.isEmpty) {
      return [];
    }
    return (await movies)
        .where((element) => _favorites.contains(element.id))
        .toList();
  }

  saveFavorites({required MovieModel movie}) {
    _favorites.add(movie.id);
  }

  removeFavorites({required MovieModel movie}) {
    _favorites.remove(movie.id);
  }

  Future<List<MovieModel>> loadByGenres(String genres) async {
    return (await movies)
        .where((movie) => movie.genres.contains(genres))
        .toList();
  }

  Future<List<MovieModel>> loadByYear(int year) async {
    return (await movies)
        .where((movie) => movie.releaseDate.year == year)
        .toList();
  }

  Future<List<MovieModel>> loadByTitle(String title) async {
    return (await movies)
        .where(
            (movie) => movie.title.toLowerCase().contains(title.toLowerCase()))
        .toList();
  }

  Future<List<MovieModel>> loadByRating(double rating) async {
    return (await movies)
        .where((movie) => movie.voteAverage >= rating)
        .toList();
  }

  // FIXME - This is a temporary solution
  Future<List<MovieModel>> loadByReleaseDate(DateTime releaseDate) async {
    return (await movies)
        .where((movie) => movie.releaseDate == releaseDate)
        .toList();
  }

  Future<List<MovieModel>> get movies async {
    return _movies.isEmpty ? (await _load()) : _movies;
  }

  Future<List<MovieModel>> _load() async {
    String jsonMovies = await _loadJson();
    List<Map<String, dynamic>> mapMovies = await _jsonToMap(jsonMovies);
    _movies = mapMovies.map((e) => MovieModel.fromMap(e)).toList();
    return _movies;
  }

  Future<String> _loadJson() async {
    return (await _tokenFlixService.movies()).body;
  }

  Future<List<Map<String, dynamic>>> _jsonToMap(String jsonMovies) async {
    List<Map<String, dynamic>> mapMovies = [...jsonDecode(jsonMovies)];
    return mapMovies;
  }
}
