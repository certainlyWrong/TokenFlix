import 'dart:convert';
import 'package:tokenflix/model/movie_informations.model.dart';

class MovieModel {
  final List<String> genres;
  final int id, voteAverage;
  final DateTime releaseDate;
  final String title, posterUrl;
  MovieInformations? informations;

  MovieModel._({
    required this.id,
    required this.title,
    required this.genres,
    required this.posterUrl,
    required this.voteAverage,
    required this.releaseDate,
  });

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel._(
      id: map['id'],
      title: map['title'],
      posterUrl: map['poster_url'],
      voteAverage: map['vote_average'],
      genres: List<String>.from(map['genres']),
      releaseDate: DateTime.parse(map['release_date']),
    );
  }

  factory MovieModel.fromJson(String json) {
    Map<String, dynamic> movie = jsonDecode(json) as Map<String, dynamic>;
    return MovieModel.fromMap(movie);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'genres': genres,
      'poster_url': posterUrl,
      'vote_average': voteAverage,
      'release_date': releaseDate.toIso8601String(),
      if (informations != null) 'informations': informations!.toMap(),
    };
  }

  String toJson() => jsonEncode(toMap());
}
