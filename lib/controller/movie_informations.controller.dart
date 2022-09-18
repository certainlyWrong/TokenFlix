import 'package:tokenflix/service/tokenflix.service.dart';
import 'package:tokenflix/model/movie_informations.model.dart';

class MovieInformationsController {
  Map<int, MovieInformationsModel> _moviesInformations = {};

  final TokenFlixService _tokenFlixService;

  MovieInformationsController._({
    required TokenFlixService tokenFlixService,
  }) : _tokenFlixService = tokenFlixService;

  factory MovieInformationsController.create() => MovieInformationsController._(
        tokenFlixService: TokenFlixService.create(),
      );
}
