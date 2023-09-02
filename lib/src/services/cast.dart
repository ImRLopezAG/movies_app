import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/src/src.dart';

class CastService {
  static final CastService _instance = CastService._internal();
  factory CastService() => _instance;
  CastService._internal();

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = EnvKeys.MOVIE_KEY!;

  Future<dynamic> _getDecodedData({required String endpoint, int page = 1}) async {
    final url = Uri.https(_baseUrl, '/3/movie/$endpoint', {
      'api_key': _apiKey,
      'language': 'en-US',
      'page': '$page',
    });
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    return decodedData;
  }

  Future<Credits> getCredits(int movieId) async {
    final decodedData = await _getDecodedData(endpoint: '$movieId/credits');
    final credits = Credits.fromJson(decodedData);
    return credits;
  }
}