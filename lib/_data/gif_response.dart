import 'dart:convert';

class GifResponse {
  GifResponse(this.data);

  final List<GifObject> data;

  factory GifResponse.fromJson(String jsonString) {
    final jsonMap = json.decode(jsonString);
    final gifs = List<GifObject>();

    for (var gifObject in jsonMap['data']) {
      gifs.add(GifObject(
        gifObject['source_tld'],
        gifObject['title'],
        gifObject['images']['fixed_height']['url'],
      ));
    }

    return GifResponse(gifs);
  }
}

class GifObject {
  GifObject(this.source, this.title, this.url);

  final String source;
  final String title;
  final String url;

  factory GifObject.empty() => GifObject('', '', '');

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GifObject &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          source == other.source &&
          title == other.title;

  @override
  int get hashCode => url.hashCode ^ source.hashCode ^ title.hashCode;
}
