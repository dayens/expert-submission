// ignore_for_file: constant_identifier_names

import 'package:flutter_test/flutter_test.dart';

import 'shared.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  group('SSL Pinning tests', () {
    test('should get response 200 when connection succeeded', () async {
      final _myClient = await Shared.createLEClient(isTestMode: true);
      final response = await _myClient
          .get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'));

      expect(response.statusCode, 200);
      _myClient.close();
    });
  });
}
