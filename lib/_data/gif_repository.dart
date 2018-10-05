import 'dart:async';

import 'package:giphy_app/_data/gif_response.dart';
import 'package:giphy_app/_data/web_client.dart';

class GifRepository {
  const GifRepository([
    this.client = const WebClient(),
  ]);

  final WebClient client;

  Future<GifObject> getRandomTrending() async {
    return await client.get('/v1/gifs/trending').then(
      (response) {
        final gifs = GifResponse.fromJson(response.body).data;
        gifs.shuffle();
        return gifs[0];
      },
    ).catchError((error) => throw Exception(error));
  }
}
