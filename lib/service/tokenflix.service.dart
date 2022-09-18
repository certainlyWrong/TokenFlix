import 'package:http/http.dart' as http;

class TokenFlixService {
  final String _baseUrl;

  TokenFlixService._({required baseUrl}) : _baseUrl = baseUrl;

  factory TokenFlixService.create() => TokenFlixService._(
        baseUrl: 'https://desafio-mobile.nyc3.digitaloceanspaces.com',
      );

  Future<http.Response> movies() async {
    return await http.get(Uri.parse('$_baseUrl/movies-v2'));
  }

  Future<http.Response> movieInformations(int id) async {
    return await http.get(Uri.parse('$_baseUrl/movies-v2/$id'));
  }
}
