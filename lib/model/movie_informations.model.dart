import 'dart:convert';

class MovieInformationsModel {
  final bool adult;
  final int runtime;
  final double voteAverage;
  final List<String> genres;
  final DateTime releaseDate;
  final String backdropUrl, overview, posterUrl, title;

  MovieInformationsModel._({
    required this.adult,
    required this.backdropUrl,
    required this.genres,
    required this.overview,
    required this.posterUrl,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
  });

  factory MovieInformationsModel.fromMap(Map<String, dynamic> map) {
    return MovieInformationsModel._(
      adult: map['adult'],
      runtime: map['runtime'],
      backdropUrl: map['backdrop_url'],
      overview: map['overview'],
      posterUrl: map['poster_url'],
      title: map['title'],
      genres: List<String>.from(map['genres']),
      releaseDate: DateTime.parse(map['release_date']),
      voteAverage: map['vote_average'],
    );
  }

  factory MovieInformationsModel.fromJson(String json) {
    Map<String, dynamic> movie = jsonDecode(json) as Map<String, dynamic>;
    return MovieInformationsModel.fromMap(movie);
  }

  Map<String, dynamic> toMap() {
    return {
      'adult': adult,
      'runtime': runtime,
      'backdrop_url': backdropUrl,
      'overview': overview,
      'poster_url': posterUrl,
      'title': title,
      'genres': genres,
      'release_date': releaseDate.toIso8601String(),
      'vote_average': voteAverage,
    };
  }

  String toJson() => jsonEncode(toMap());
}
