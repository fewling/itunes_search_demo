import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/itune_response.dart';

/// A service that fetches music tracks from iTunes.
/// As stated from the document, only music tracks are considered.
class ITuneService {
  static const _apiURL = 'https://itunes.apple.com/search';

  Future<ITuneResponse> fetchMusicTrack(String terms) async {
    final uri = '$_apiURL?term=$terms&entity=musicTrack';
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final iTuneResponse = ITuneResponse.fromJson(json);

      return iTuneResponse;
    } else {
      throw Exception('${response.statusCode}: '
          '${response.reasonPhrase}\n'
          '${response.body}');
    }
  }
}
