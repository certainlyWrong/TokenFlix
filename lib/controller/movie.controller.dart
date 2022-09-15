import 'dart:convert';
import 'package:tokenflix/model/movie.model.dart';
import 'package:tokenflix/service/tokenflix.service.dart';

class MovieController {
  List<MovieModel> _movies = [];
  final TokenFlixService _tokenFlixService;

  MovieController._({required TokenFlixService tokenFlixService})
      : _tokenFlixService = tokenFlixService;

  factory MovieController.create() =>
      MovieController._(tokenFlixService: TokenFlixService.create());

  Future<List<MovieModel>> get movies async {
    return _movies.isEmpty ? (await _loadMovies()) : _movies;
  }

  Future<List<MovieModel>> _loadMovies() async {
    String jsonMovies = await _loadJsonMovies();
    List<Map<String, dynamic>> mapMovies = await _jsonToMapMovies(jsonMovies);
    _movies = mapMovies.map((e) => MovieModel.fromMap(e)).toList();
    return _movies;
  }

  Future<String> _loadJsonMovies() async {
    return (await _tokenFlixService.movies()).body;
  }

  Future<List<Map<String, dynamic>>> _jsonToMapMovies(String jsonMovies) async {
    return jsonDecode(jsonMovies) as List<Map<String, dynamic>>;
  }
}
