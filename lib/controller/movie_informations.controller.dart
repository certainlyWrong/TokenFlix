import 'dart:convert';

import 'package:tokenflix/service/tokenflix.service.dart';
import 'package:tokenflix/model/movie_informations.model.dart';

class MovieInformationsController {
  final TokenFlixService _tokenFlixService;
  final Map<int, MovieInformationsModel> _moviesInformations = {};

  MovieInformationsController._({
    required TokenFlixService tokenFlixService,
  }) : _tokenFlixService = tokenFlixService;

  factory MovieInformationsController.create() => MovieInformationsController._(
        tokenFlixService: TokenFlixService.create(),
      );

  Future<MovieInformationsModel> movieInformations(int movieId) async {
    if (_moviesInformations.containsKey(movieId)) {
      return _moviesInformations[movieId]!;
    }

    final movieInformations = await _loadMovieInformations(movieId);
    _moviesInformations[movieId] = movieInformations;
    return movieInformations;
  }

  Future<MovieInformationsModel> _loadMovieInformations(int movieId) async {
    return MovieInformationsModel.fromMap(await _loadMap(movieId));
  }

  Future<Map<String, dynamic>> _loadMap(int movieId) async {
    return jsonDecode(await _loadJson(movieId)) as Map<String, dynamic>;
  }

  Future<String> _loadJson(int movieId) async {
    return (await _tokenFlixService.movieInformations(movieId)).body;
  }
}
